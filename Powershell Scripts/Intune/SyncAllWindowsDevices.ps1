#Connnect-MSGraph --> This needed to be run in Powershell 5.1 --> Not support for Powershell Core Yet
#Disconnect-MgGraph
Disconnect-MgGraph


#Connect to MgGraph
Connect-MgGraph -scope DeviceManagementManagedDevices.PrivilegedOperations.All, DeviceManagementManagedDevices.ReadWrite.All,DeviceManagementManagedDevices.Read.All


#Get Context
Get-MgContext

 
#### Gets All devices
$Devices = Get-MgDeviceManagementManagedDevice
 
Foreach ($Device in $Devices)
{
 
Sync-MgDeviceManagementManagedDevice -ManagedDeviceId $Device.Id
 
Write-Host "Sending Sync request to Device with Device name $($Device.DeviceName)" -ForegroundColor Yellow
  
}
