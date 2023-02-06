$upn = "chris@van-as.be"
$user = Get-ADUser -Filter "UserPrincipalname -like '$upn'"
$immutableid = [System.Convert]::ToBase64String($user.ObjectGUID.tobytearray())

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-Module AzureAd 

Connect-AzureAD
Get-AzureADUser -Filter "userPrincipalName eq '$upn'" | Set-AzureADUser -ImmutableId $immutableID
