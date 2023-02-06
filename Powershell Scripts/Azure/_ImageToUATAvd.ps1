$ErrorActionPreference = "Stop"
Connect-AzAccount -Identity


$targetRgName = Get-AutomationVariable -Name "uat-avd-vm-rgname"
$rgName = Get-AutomationVariable -Name "avd-image-rgname"
$vaultName = Get-AutomationVariable -Name "avd-kv-name"
$deployUatAvdJsonUrl = Get-AutomationVariable -Name "avd-vm-arm-url"
$deployUatAvdParamJsonUrl = Get-AutomationVariable -Name "uat-avd-vm-armparam-url"
$AcgImageDefinitionName = Get-AutomationVariable -Name "avd-image-definition-name"


#region Helper functions
function ConvertFrom-SecureStringCrossPwshVersions {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline)]
        [System.Security.SecureString]$secureString
    )
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
    $plaintext = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
    return $plaintext
}

function ConvertTo-Hashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }
        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    ConvertTo-Hashtable -InputObject $object
                }
            )
            ## Return the array but don't enumerate it because the object may be pretty complex
            Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject]) {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = ConvertTo-Hashtable -InputObject $property.Value
            }
            $hash
        }
        else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}

#endregion

Write-Output "Retrieving ACG & Image Definition"
$galleryRg = Get-AzResourceGroup -Name $rgName
$gallery = Get-AzGallery -ResourceGroupName $galleryRg.ResourceGroupName
$imageDefinition = Get-AzGalleryImageDefinition -ResourceGroupName $galleryRg.ResourceGroupName -GalleryName $gallery.Name -Name $AcgImageDefinitionName

#Get latest version
Write-Output "Getting the latest version"
$imageVersionList = Get-AzGalleryImageVersion -ResourceGroupName $galleryRg.ResourceGroupName -GalleryName $gallery.Name -GalleryImageDefinitionName $imageDefinition.Name | Select-Object Name -ExpandProperty Name
$latestVersionNumber = ($imageVersionList | ForEach-Object { [version]$_ } | Sort-Object -Descending | Select-Object -First 1).ToString()
Write-Output ("Latest version = '{0}'" -f $latestVersionNumber)

Write-Output "Retrieving Keyvault secrets"
$localadmin_user = (Get-AzKeyVaultSecret -VaultName $vaultName -SecretName "localadmin-user" -WarningAction SilentlyContinue).SecretValue | ConvertFrom-SecureStringCrossPwshVersions
$localadmin_password = (Get-AzKeyVaultSecret -VaultName $vaultName -SecretName "localadmin-password" -WarningAction SilentlyContinue).SecretValue | ConvertFrom-SecureStringCrossPwshVersions
$domainadmin_user = (Get-AzKeyVaultSecret -VaultName $vaultName -SecretName "domainadmin-user" -WarningAction SilentlyContinue).SecretValue | ConvertFrom-SecureStringCrossPwshVersions
$domainadmin_password = (Get-AzKeyVaultSecret -VaultName $vaultName -SecretName "domainadmin-password" -WarningAction SilentlyContinue).SecretValue | ConvertFrom-SecureStringCrossPwshVersions

Write-Output "Download Deployment files from Storage Account"
Invoke-WebRequest -Uri $deployUatAvdJsonUrl -OutFile deploy.uat.avd.json -UseBasicParsing
Invoke-WebRequest -Uri $deployUatAvdParamJsonUrl -OutFile deploy.uat.avd.params.json -UseBasicParsing

Write-Output "Reading ARM Template"
if ($PSVersionTable.PSVersion.Major -eq 5) {
    $armparamobject = Get-Content ".\deploy.uat.avd.params.json" | ConvertFrom-Json | ConvertTo-Hashtable
}
else {
    $armparamobject = Get-Content ".\deploy.uat.avd.params.json" | ConvertFrom-Json -AsHashtable
}

Write-Output "Reading AVD Hostpool"
$AVDHostpoolName = $armparamobject.parameters.hostpoolname.value
$AVDHostpool = Get-AzWvdHostPool | Where-Object { $_.Name -eq $AVDHostpoolName }

Write-Output "Reading Domain Name"
$vmDomainName = $armparamobject.parameters.Domainname.value

Write-Output "Cleaning up old Sessionhosts"
$oldVms = Get-AzVM -ResourceGroupName $targetRgName

foreach ($oldVm in $oldVms) {
    Write-Output ("Checking {0}" -f $oldVm.Name)
    #TODO: Cleanup
    if ($oldVm.StorageProfile.ImageReference.ExactVersion -eq $latestVersionNumber) {
        Write-Output ("VM Version OK: '{0}'. Skipping VM" -f $oldVm.StorageProfile.ImageReference.ExactVersion)
        continue
    }

    Write-Output "Not the current version... Removing VM from AVD & removing VM resources"

    Write-Output "Step 1: Removing from AVD"
    $removeDummy = Remove-AzWvdSessionHost -HostPoolName $AVDHostpool.Name -ResourceGroupName $targetRgName -Name ("{0}.{1}" -f $oldVm.Name, $vmDomainName) -Force
    $removeDummy 


    Write-Output "Step 2: Removing VM resources"
    Write-Output "Deallocating VM"
    Stop-AzVM -ResourceGroupName $oldVm.ResourceGroupName -Name $oldVm.Name -Force
    Write-Output "Removing VM"
    $oldVm | Remove-AzVM -Force
    Write-Output "Removing NIC(s) & PIPs (if any)"
    foreach ($nic in $oldVm.NetworkProfile.NetworkInterfaces) {
        Remove-AzResource -ResourceId $nic.Id -Force
    }
    Write-Output "Removing OSDisk"
    Remove-AzResource -ResourceId $oldVm.StorageProfile.OsDisk.ManagedDisk.Id -Force
    Write-Output "Removing Data Disks (if any)"
    foreach ($datadisk in $oldVm.StorageProfile.DataDisks) {
        Remove-AzResource -ResourceId $datadisk.ManagedDisk.Id -Force
    }

    Write-Output "Done"
}

Write-Output "Filling in the missing parameters in ARM Template"
$armparamobject.parameters.LocalAdminUser.value = $localadmin_user
$armparamobject.parameters.LocalAdminPassword.value = $localadmin_password
$armparamobject.parameters.DomainAdminUpn.value = $domainadmin_user
$armparamobject.parameters.DomainAdminPassword.value = $domainadmin_password
$armparamobject.parameters.ACG_ImageVersionName.value = $latestVersionNumber

$datetime = (Get-Date).AddHours(24)
$longDateTime = $datetime.ToUniversalTime().ToString("o")
$armparamobject.parameters.tokenExpirationTime.value = $longDateTime

$bogusparameterobject = @{ }
$armparamobject.parameters.keys | ForEach-Object { $bogusparameterobject[$_] = $armparamobject.parameters[$_]['value'] }

Write-Output "Testing the deployment"
$deploymentName = ("avd.deployment.{0}.{1}" -f $latestVersionNumber, (Get-Date).ToString("s").Replace(":", "_"))
$deploymentTest = $null
$deploymentTest = Test-AzResourceGroupDeployment -ResourceGroupName $targetRgName -TemplateFile ".\deploy.uat.avd.json" -TemplateParameterObject $bogusparameterobject
if (($null -eq $deploymentTest) -or ($deploymentTest.Count -eq 0)) {
    Write-Output "Kicking off the deployment"
    $deployResult = New-AzResourceGroupDeployment -ResourceGroupName $targetRgName -TemplateFile ".\deploy.uat.avd.json" -TemplateParameterObject $bogusparameterobject -Mode Incremental -Name $deploymentName
    Write-Output ($deployResult | ConvertTo-Json)
}
else {
    Write-Warning "Error in ARM Template deployment!"
    Write-Output "Error in Template:"
    Write-Output ($deploymentTest | ConvertTo-Json -Compress)
}

Write-Output "All done!"