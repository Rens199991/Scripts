if (Test-Path -Path "c:\temp\latest")
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\GetMapLatestDRNot"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\GetMapLatestDRNot"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\GetMapLatestDRNot\GetMapLatestDRNot.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation needed"
    exit 0  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\GetMapLatestDRNeeded"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\GetMapLatestDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\GetMapLatestDRNeeded\GetMapLatestDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1  
    }