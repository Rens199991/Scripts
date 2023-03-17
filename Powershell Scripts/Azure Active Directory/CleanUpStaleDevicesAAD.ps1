#Get List
$dt = (Get-Date).AddDays(-180)

#Get-List
Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | select-object -Property AccountEnabled, DeviceId, DeviceOSType, DeviceOSVersion, DisplayName, DeviceTrustType, ApproximateLastLogonTimestamp 
 
#deactivate
Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | Set-AzureADDevice -AccountEnabled $false
 
#delete
Get-AzureADDevice -All:$true | Where {$_.ApproximateLastLogonTimeStamp -le $dt} | Remove-AzureADDevice
