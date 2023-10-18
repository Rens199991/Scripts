	Try 
		{
		$exists = Get-AppPackage -AllUsers -name "MSTeams"
		If ($exists)
			{
			Write-host "Installed"
			}
		}
	catch 
		{
        }