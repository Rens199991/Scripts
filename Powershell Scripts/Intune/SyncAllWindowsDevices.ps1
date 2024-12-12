#Connnect-MSGraph --> This needed to be run in Powershell 5.1 --> Not support for Powershell Core Yet
#Disconnect-MgGraph
Disconnect-MgGraph

#Install Needed Modules
Install-Module Microsoft.Graph.Intune
Import-Module Microsoft.Graph.Intune 

#Connect to MgGraph & MsGraph
#Intune Graph Application Registration APi moet de juiste rechten hebben, zie rechten in World of Travel)
Connect-MgGraph  -Scopes "DeviceManagementManagedDevices.PrivilegedOperations.All"
Connect-MSGraph -AdminConsent
Get-MSGraphEnvironment

#Get Context
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

#Sync all devices running Windows
$Devices = Get-IntuneManagedDevice -Filter "contains(operatingsystem,'Windows')"
Foreach ($Device in $Devices)
    { 
    Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $Device.managedDeviceId
    Write-Host "Sending Sync request to Device with DeviceID $($Device.managedDeviceId)" -ForegroundColor Yellow 
    }
 

