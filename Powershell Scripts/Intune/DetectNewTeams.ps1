$TeamsNew = Get-ChildItem "C:\Program Files\WindowsApps" -Filter "MSTeams_*"

if($TeamsNew)
	{
    Write-Host "Found It"
    exit 0
	}
else
	{
	 Write-Host "Teams not Found, will install Teams"
    exit 1
	}