Param(
    [Parameter(Mandatory = $True)]
    [String]
    $SharepointURL,
    [Parameter(Mandatory = $True)]
    [String]
    $tenantID
)

$scope = 'User.Read.All'
Connect-MgGraph -TenantId $tenantId -Scopes $scope
Connect-SPOService -Url $SharepointURL;

$list = @() #list of UPN to pass to the SP command
$Totalusers = 0 #total user provisioned.

#Get licensed users
$users = Get-MgUser -Filter 'assignedLicenses/$count ne 0' -ConsistencyLevel eventual -CountVariable licensedUserCount -All -Select UserPrincipalName

foreach ($u in $users) {
    $Totalusers++
    Write-Host "$Totalusers/$($users.Count)"
    $list += $u.userprincipalname

    if ($list.Count -eq 199) {
        #We reached the limit
        Write-Host "Batch limit reached, requesting provision for the current batch"
        Request-SPOPersonalSite -UserEmails $list -NoWait
        Start-Sleep -Milliseconds 655
        $list = @()
    }
}

if ($list.Count -gt 0) {
    Request-SPOPersonalSite -UserEmails $list -NoWait
}
Disconnect-SPOService
Disconnect-MgGraph
Write-Host "Completed OneDrive Provisioning for $Totalusers users"