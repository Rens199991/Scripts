#Does not work in Powershell 7!
#Install the module
Install-Module AADInternals

#Import the module
Import-Module AADInternals


#Get the access token

Get-AADIntAccessTokenForAADGraph -Resource urn:ms-drs:enterpriseregistration.windows.net -SaveToCache

#Create a new BPRT

$bprt = New-AADIntBulkPRTToken -Name "My BPRT user"
$bprt