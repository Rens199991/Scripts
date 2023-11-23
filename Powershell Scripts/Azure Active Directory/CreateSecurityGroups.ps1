#Install needed Modules
#Install-Module Microsoft.Graph -Scope CurrentUser

#Disconnect multiple times to sign off ot other tenants
Disconnect-AzAccount
Disconnect-MgGraph

#Connect and verify that you are in right tenant
Connect-AzAccount
Connect-MgGraph -Scopes "Group.readwrite.all"
Get-AzContext   
Get-MgContext

#https://docs.microsoft.com/en-us/graph/api/group-post-groups?view=graph-rest-1.0&tabs=http


$common = @{
    Grouptypes = @(
        'DynamicMembership'
    )
    mailenabled = $false
    isAssignableToRole = $false
    securityEnabled = $true
    MembershipRuleProcessingState = "on"
}


$allUsersAndGuests = @{
    Description = 'All Users (Included Guests)'
    Displayname = 'All Users (Included Guests)'
    mailnickname = 'allUsersAndGuests'
    membershiprule = '(user.objectId -ne null)'
}
$allUsers = @{
    Description = 'All Users (Excluded Guests)'
    Displayname = 'All Users (Excluded Guests)'
    mailnickname = 'allUsers'
    membershiprule = '(user.userType -eq "Member")' 
}
$AllGuests = @{
    Description = 'All Guest Users'
    Displayname = 'All Guest Users'
    mailnickname = 'allGuests'
    membershiprule = '(user.objectId -eq "Guest")'
}





$AllDevices = @{
    Description = 'All Devices'
    Displayname = 'All Devices'
    mailnickname = 'AllDevices'
    membershiprule = '(device.managementtype -eq "MDM") -or (device.managementType -ne "MDM")'
               }
               
$AllManagedDevices = @{
    Description = 'All Managed Devices'
    Displayname = 'All Managed Devices'
    mailnickname = 'AllDevicesManaged'
    membershiprule = '(device.managementtype -eq "MDM")'
}
$AllNotManagedDevices = @{
    Description = 'All Not Managed Devices'
    Displayname = 'All Not Managed Devices'
    mailnickname = 'AllNotManagedDevices'
    membershiprule = '(device.managementtype -ne "MDM")'
}





$WindowsDevices = @{
    Description = 'Windows Devices'
    Displayname = 'Windows Devices'
    mailnickname = 'WindowsDevices'
    membershiprule = '(device.DeviceOSType -startsWith "Windows") '
}
$WindowsManagedDevices = @{
    Description = 'Windows Managed Devices'
    Displayname = 'Windows Managed Devices'
    mailnickname = 'WindowsDevicesManaged'
    membershiprule = '(device.DeviceOSType -startsWith "Windows") -and (device.managementType -eq "MDM")'
}
$WindowsNotManagedDevices = @{
    Description = 'Windows Not Managed Devices'
    Displayname = 'Windows Not Managed Devices'
    mailnickname = 'WindowsNotManagedDevices'
    membershiprule = '(device.DeviceOSType -startsWith "Windows") -and (device.managementType -ne "MDM")'
}
$WindowsCorporateOwnedManagedDevices = @{
    Description = 'Windows Corporate-Owned Managed Devices'
    Displayname = 'Windows Corporate-Owned Managed Devices'
    mailnickname = 'WindowsCorporate-OwnedManagedDevices'
    membershiprule = '(device.deviceOSType -startsWith "Windows") and (device.managementType -eq "MDM") and (device.deviceOwnership -eq "Company") or (device.devicePhysicalIDs -any _ -contains "[ZTDId]")'
}
$WindowsPersonallyOwnedManagedDevices = @{
    Description = 'Windows Personally-Owned Managed Devices'
    Displayname = 'Windows Personally-Owned Managed Devices'
    mailnickname = 'WindowsPersonally-OwnedManagedDevices'
    membershiprule = '(device.deviceOSType -startsWith "Windows") and (device.managementType -eq "MDM") and (device.deviceOwnership -eq "Personal")'
}






$WindowsAutopilotDevices = @{
    Description = 'Windows Autopilot Devices'
    Displayname = 'Windows Autopilot Devices'
    mailnickname = 'WindowsAutopilotDevices'
    membershiprule = '(device.devicePhysicalIDs -any _ -contains "[ZTDId]") '
}
$WindowsEnrolledAutopilotDevices = @{
    Description = 'Windows Enrolled Autopilot Devices'
    Displayname = 'Windows Enrolled Autopilot Devices'
    mailnickname = 'WindowsEnrolledAutopilotDevices'
    membershiprule = '(device.devicePhysicalIDs -any _ -contains "[ZTDId]") -and (device.managementType -eq "MDM")'
}
$WindowsNotYetEnrolledAutopilotDevices = @{
    Description = 'Windows Not Yet Enrolled Autopilot Devices'
    Displayname = 'Windows Not Yet Enrolled Autopilot Devices'
    mailnickname = 'WindowsNotYetEnrolledAutopilotDevices'
    membershiprule = '(device.devicePhysicalIDs -any _ -contains "[ZTDId]") -and (device.managementType -ne "MDM")'
}


$WindowsServersManagedbyMicrosoftDefender = @{
    Description = 'Windows Servers Managed by Microsoft Defender'
    Displayname = 'Windows Servers Managed by Microsoft Defender'
    mailnickname = 'WindowsServersManagedbyMicrosoftDefender'
    membershiprule = '(device.managementType -eq "MicrosoftSense")'
}
$MicrosoftSurfaceHubDevices = @{
    Description = 'Microsoft SurfaceHubs Devices'
    Displayname = 'Microsoft SurfaceHubs Devices'
    mailnickname = 'MicrosoftSurfaceHubsDevices'
    membershiprule = '(device.DeviceOSType -startsWith "SurfaceHub")'
}




$AndroidDevices = @{
    Description = 'Android Devices'
    Displayname = 'Android Devices'
    mailnickname = 'AndroidDevices'
    membershiprule = '(device.DeviceOSType -startsWith "Android") '
}
$AndroidPersonallyOwnedwithWorkprofileDevices = @{
    Description = 'Android Personally-Owned with Workprofile Devices'
    Displayname = 'Android Personally-Owned with Workprofile Devices'
    mailnickname = 'AndroidPersonally-OwnedwithWorkprofileDevices'
    membershiprule = '(device.deviceOSType -eq "AndroidForWork") and (device.managementType -eq "MDM") '
}
$AndroidCorporateOwnedwithWorkprofileDevices = @{
    Description = 'Android Corporate-Owned with Workprofile Devices'
    Displayname = 'Android Corporate-Owned with Workprofile Devices'
    mailnickname = 'AndroidCorporate-OwnedwithWorkprofileDevices'
    membershiprule = '(device.enrollmentProfileName -match "Android - Corporate-Owned with Workprofile Devices Enrollment Profile") '
}
$AndroidCorporateOwnedFullyManagedDevices = @{
    Description = 'Android Corporate-Owned Fully Managed Devices'
    Displayname = 'Android Corporate-Owned Fully Managed Devices'
    mailnickname = 'AndroidCorporate-OwnedFullyManagedDevices'
    membershiprule = '(device.deviceOSType -eq "AndroidEnterprise") -and (device.enrollmentProfileName -eq null) '
}




$iOSiPadOSDevices = @{
    Description = 'iOS/iPadOS Devices'
    Displayname = 'iOS/iPadOS Devices'
    mailnickname = 'iOS/iPadOSDevices'
    membershiprule = '(device.DeviceOSType -startsWith "iOS") '
}
$iOSiPadOSPersonallyOwnedwithWorkprofileDevices = @{
    Description = 'iOS/iPadOS Personally-Owned with Workprofile Devices'
    Displayname = 'iOS/iPadOS Personally-Owned with Workprofile Devices'
    mailnickname = 'iOS/iPadOSPersonally-OwnedwithWorkprofileDevices'
    membershiprule = '(device.enrollmentProfileName -match "iOS/iPadOS UserEnrollment") '
}
$iOSiPadOSPersonallyOwnedFullyManagedwithoutWorkprofileDevices = @{
    Description = 'iOS/iPadOS Personally-Owned Fully Managed without Workprofile Devices'
    Displayname = 'iOS/iPadOS Personally-Owned Fully Managed without Workprofile Devices'
    mailnickname = 'iOS/iPadOSPersonally-OwnedwithoutWorkprofileDevices'
    membershiprule = '(device.enrollmentProfileName -match "iOS/iPadOS DeviceEnrollment") '
}











New-MgGroup -BodyParameter ($common + $allUsersAndGuests)
New-MgGroup -BodyParameter ($common + $allUsers)
New-MgGroup -BodyParameter ($common + $AllGuests)
New-MgGroup -BodyParameter ($common + $AllDevices)
New-MgGroup -BodyParameter ($common + $AllManagedDevices)
New-MgGroup -BodyParameter ($common + $AllNotManagedDevices)
New-MgGroup -BodyParameter ($common + $WindowsDevices )
New-MgGroup -BodyParameter ($common + $WindowsManagedDevices)
New-MgGroup -BodyParameter ($common + $WindowsNotManagedDevices)
New-MgGroup -BodyParameter ($common + $WindowsCorporateOwnedManagedDevices)
New-MgGroup -BodyParameter ($common + $WindowsPersonallyOwnedManagedDevices)

New-MgGroup -BodyParameter ($common + $WindowsAutopilotDevices)
New-MgGroup -BodyParameter ($common + $WindowsEnrolledAutopilotDevices)
New-MgGroup -BodyParameter ($common + $WindowsNotYetEnrolledAutopilotDevices)
New-MgGroup -BodyParameter ($common + $WindowsServersManagedbyMicrosoftDefender)
New-MgGroup -BodyParameter ($common + $MicrosoftSurfaceHubDevices)


New-MgGroup -BodyParameter ($common + $AndroidDevices)
New-MgGroup -BodyParameter ($common + $AndroidPersonallyOwnedwithWorkprofileDevices)
New-MgGroup -BodyParameter ($common + $AndroidCorporateOwnedwithWorkprofileDevices)
New-MgGroup -BodyParameter ($common + $AndroidCorporateOwnedFullyManagedDevices)
New-MgGroup -BodyParameter ($common + $iOSiPadOSDevices)
New-MgGroup -BodyParameter ($common + $iOSiPadOSPersonallyOwnedwithWorkprofileDevices)
New-MgGroup -BodyParameter ($common + $iOSiPadOSPersonallyOwnedFullyManagedwithoutWorkprofileDevices)









New-MgGroup -DisplayName 'NON-MFA Users'  -MailEnabled:$False  -MailNickName 'NON-MFAUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'NON-Compliant Users'  -MailEnabled:$False  -MailNickName 'NON-CompliantUsers' -SecurityEnabled:$true  
New-MgGroup -DisplayName 'NON-Approved Client App Users'  -MailEnabled:$False  -MailNickName 'NON-ApprovedClientAppUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'NON-Blocked Countries Users'  -MailEnabled:$False  -MailNickName 'NON-BlockedCountriesUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'NON-ModernAuth Users'  -MailEnabled:$False  -MailNickName 'NON-ModernAuthUsers' -SecurityEnabled:$true

New-MgGroup -DisplayName 'Internal Login Users'  -MailEnabled:$False  -MailNickName 'InternalLoginUsers' -SecurityEnabled:$true

New-MgGroup -DisplayName 'Windows Update Fast Ring Users'  -MailEnabled:$False  -MailNickName 'WindowsUpdateSlowRingUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'Windows Update Slow Ring Users'  -MailEnabled:$False  -MailNickName 'WindowsUpdateSlowRingUsers' -SecurityEnabled:$true

New-MgGroup -DisplayName 'Management Users'  -MailEnabled:$False  -MailNickName 'ManagementUsers' -SecurityEnabled:$true


New-MgGroup -DisplayName 'Android Personally-Owned Devices with Workprofile Users' -MailEnabled:$False  -MailNickName 'AndroidPersonally-OwnedDeviceswithWorkprofileUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'Android Corporate-Owned Devices with Workprofile Users' -MailEnabled:$False  -MailNickName 'AndroidCorporate-OwnedDeviceswithWorkprofileUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'Android Corporate-Owned Devices Fully Managed Users' -MailEnabled:$False  -MailNickName 'AndroidFullyManagedUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'iOS/iPadOS Personally-Owned Devices with Workprofile Users' -MailEnabled:$False  -MailNickName 'iOS/iPadOSPersonally-OwnedDeviceswithWorkprofileUsers' -SecurityEnabled:$true
New-MgGroup -DisplayName 'iOS/iPadOS Personally-Owned Fully Managed Devices without Workprofile Users' -MailEnabled:$False  -MailNickName 'iOS/iPadOSFullyManagedwithoutWorkprofileUsers' -SecurityEnabled:$true
