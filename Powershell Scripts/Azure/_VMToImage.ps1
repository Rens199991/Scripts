$ErrorActionPreference = "Stop"
Connect-AzAccount -Identity

$rgName = Get-AutomationVariable -Name 'avd-image-rgname'
$sysprepUrl = Get-AutomationVariable -Name 'avd-image-sysprep-url'
$AcgImageDefinitionName = Get-AutomationVariable -Name 'avd-image-definition-name'
$vmName = Get-AutomationVariable -Name 'avd-image-vmname'

#Select VM
Write-Output ("Retrieving RG '{0}'" -f $rgName)
$vmRg = Get-AzResourceGroup -Name $rgName
Write-Output ("Retrieving VM '{0}' in RG '{1}'" -f $vmName, $vmRg.ResourceGroupName)
$sourceVm = Get-AzVM -ResourceGroupName $vmRg.ResourceGroupName -Name $vmName

Write-Output "Downloading Sysprep script"
Invoke-WebRequest -Uri $sysprepUrl -OutFile sysprep.ps1 -UseBasicParsing

Write-Output "Running Sysprep"
Invoke-AzVMRunCommand -ResourceGroupName $vmRg.ResourceGroupName -Name $sourceVm.Name -CommandId 'RunPowerShellScript' -ScriptPath .\sysprep.ps1

Write-Output "Waiting 120 seconds for full shutdown"
Start-Sleep -Seconds 120

do {
    Write-Output "Checking VM Status, needs to be 'PowerState/stopped'"
    $sourceVMStatus = Get-AzVM -ResourceGroupName $vmRg.ResourceGroupName -Name $vmName -Status
    $sourceVMStatus.Statuses | Where-Object { $_.code -eq "PowerState/stopped" }
    if ($null -eq ($sourceVMStatus.Statuses | Where-Object { $_.code -eq "PowerState/stopped" })) {
        Write-Output "VM not stopped yet... waiting 15 sec..."
        Start-Sleep -Seconds 15
    }
} while ($null -eq ($sourceVMStatus.Statuses | Where-Object { $_.code -eq "PowerState/stopped" }))

Write-Output "Deallocating VM"
Stop-AzVM -ResourceGroupName $sourceVm.ResourceGroupName -Name $sourceVm.Name -Force
Write-Output "Generalizing VM"
Set-AzVm -ResourceGroupName $sourceVm.ResourceGroupName -Name $sourceVm.Name -Generalized

#Select ACG
Write-Output "Retrieving ACG & Image Definition"
$galleryRg = Get-AzResourceGroup -Name $rgName
$gallery = Get-AzGallery -ResourceGroupName $galleryRg.ResourceGroupName
$imageDefinition = Get-AzGalleryImageDefinition -ResourceGroupName $galleryRg.ResourceGroupName -GalleryName $gallery.Name -Name $AcgImageDefinitionName
$imageVersionList = Get-AzGalleryImageVersion -ResourceGroupName $galleryRg.ResourceGroupName -GalleryName $gallery.Name -GalleryImageDefinitionName $imageDefinition.Name | Select-Object Name -ExpandProperty Name

#Get latest version number
if ($null -ne $imageVersionList) {
	$latestVersionNumber = $imageVersionList | ForEach-Object { [version]$_ } | Sort-Object -Descending | Select-Object -First 1
	$newImageVersion = ([System.Version]::new($latestVersionNumber.Major, ($latestVersionNumber.Minor + 1), 0)).ToString()
}
else {
	$newImageVersion = ([System.Version]::new(1, 0, 0)).ToString()
}


$region1 = @{Name = 'West Europe'; ReplicaCount = 1 }
$targetRegions = @($region1)

Write-Output "Starting image creation"
$imageVersionJob = New-AzGalleryImageVersion -GalleryImageDefinitionName $imageDefinition.Name -GalleryImageVersionName $newImageVersion -GalleryName $gallery.Name -ResourceGroupName $gallery.ResourceGroupName -Location $gallery.Location `
    -TargetRegion $targetRegions  -SourceImageId $sourceVm.Id.ToString() -AsJob

Write-Output "Waiting in loop until finished"
do {
    Write-Output "waiting 15 seconds"
    Start-Sleep -Seconds 15

} while ($imageVersionJob.State -eq "Running")

Start-Sleep -Seconds 3
Write-Output "Job done!"
$imageVersionJob

Write-Output "Cleaning up imager VM"
Write-Output "Removing VM"
$sourceVm | Remove-AzVM -Force
Write-Output "Removing NIC(s) & PIPs (if any)"
foreach ($nic in $sourceVm.NetworkProfile.NetworkInterfaces) {
    $azNic = Get-AzNetworkInterface -ResourceId $nic.Id
    Remove-AzResource -ResourceId $nic.Id -Force
    Remove-AzResource -ResourceId $azNic.IpConfigurations[0].PublicIpAddress[0].Id -Force
}
Write-Output "Removing OSDisk"
Remove-AzResource -ResourceId $sourceVm.StorageProfile.OsDisk.ManagedDisk.Id -Force
Write-Output "Removing Data Disks (if any)"
foreach ($datadisk in $sourceVm.StorageProfile.DataDisks) {
    Remove-AzResource -ResourceId $datadisk.ManagedDisk.Id -Force
}

Write-Output "All done!"