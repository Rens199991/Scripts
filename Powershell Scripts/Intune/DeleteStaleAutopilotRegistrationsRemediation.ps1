#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsR\DeleteStaleAutopilotRegistrationsR.ps1.tag" -Value "Installed"
    }


#Import required module
Import-Module Microsoft.Graph.Beta.DeviceManagement.Enrollment

#Connect to MgGraph with permission scopes
Connect-MgGraph -Scopes "DeviceManagementServiceConfig.Read.All, DeviceManagementServiceConfig.ReadWrite.All"

#Specify time range
$currentTime = Get-Date
$minAge = $currentTime.AddDays(-500)


#Query Microsoft Graph Endpoints and filter for conditions
$allAutopilot = Get-MgBetaDeviceManagementWindowsAutopilotDeviceIdentity -All
$staleAutopilot = Get-MgBetaDeviceManagementWindowsAutopilotDeviceIdentity -All | Where-Object { $_.EnrollmentState -ne "notContacted" -and $_.LastContactedDateTime -lt $minAge }
$neverContactedAutopilot = Get-MgBetaDeviceManagementWindowsAutopilotDeviceIdentity -All | Where-Object { $_.EnrollmentState -eq "notContacted" }

Write-Output "$($allAutopilot.Count) Autopilot identities are existing in your tenant."
Write-Output "$($staleAutopilot.Count) Autopilot identities have not contacted the Intune service since $($minAge)."
Write-Output "$($neverContactedAutopilot.Count) Autopilot identities have not contacted the Intune service ever."



#Delete stale Registrations !On your own responsibility - no liability!
foreach ($device in $staleAutopilot) 
    {
    Remove-MgBetaDeviceManagementWindowsAutopilotDeviceIdentity -WindowsAutopilotDeviceIdentityId $device.Id
    Write-Output "The device with the following serial number is deleted: $($device.SerialNumber)"
    }


#Sync Autopilot Registrations (recommended after deletion), requires module Microsoft.Graph.Beta.DeviceManagement.Actions
Sync-MgBetaDeviceManagementWindowsAutopilotSetting