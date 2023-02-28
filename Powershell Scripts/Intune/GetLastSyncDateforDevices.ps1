#Bron:https://conditionalaccess.uk/get-a-list-of-intune-devices-that-havent-synced-in-x-days/
#Install the Microsoft Graph PowerShell module
Install-Module Microsoft.Graph

#Authenticate with Microsoft Graph
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", "DeviceManagementManagedDevices.ReadWrite.All"

#Get Context
Get-MgContext

#CSV Report path
$CSVpath = "C:\DeviceSyncReport<klantnaam>.csv"

#Set the filter expression
#global standardised ISO 8601 date format that is “YYYY-MM-DDT(SeperatesTimeFromZone)HH:mm:ss(Time is in 24hoursformat)Z, + or -(OffsetofUTC,in Winter+01:00,in Summer +02:00)
$filter = "lastSyncDateTime lt 2023-02-28T11:00:00+01:00"

#Get the Intune-managed devices that match the filter
$devices = Get-MgDeviceManagementManagedDevice -Filter $filter

#Build the CSV report
    foreach ($device in $devices) { 
        $userDeviceProperties = [pscustomobject][ordered]@{
            UserPrincipalName = $device.UserPrincipalName
            DeviceName        = $device.deviceName
            DeviceID          = $device.id
            LastSyncTime      = $device.lastSyncDateTime 
        }
        $userDeviceProperties | Export-CSV -Path $CSVpath -Append -NoTypeInformation   
    }