#Deze moet je runnen in de Windows Powershell ISE
#Connect to MGGraph & MSGraph
Connect-MgGraph  
Connect-MSGraph


Get-MgContext



$IntuneModule = Get-Module -Name "Microsoft.Graph.Intune" -ListAvailable
if (!$IntuneModule)
    {
    write-host "Microsoft.Graph.Intune Powershell module not installed..." -f Red
    write-host "Install by running 'Install-Module Microsoft.Graph.Intune' from an elevated PowerShell prompt" -f Yellow
    write-host "Script can't continue..." -f Red
    write-host
    exit
    }

#Sync ll devices running Windows
$Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem,'Windows')"
Foreach ($Device in $Devices)
    { 
    Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
    Write-Host "Sending Sync request to Device with DeviceID $($Device.managedDeviceId)" -ForegroundColor Yellow 
    }
 

