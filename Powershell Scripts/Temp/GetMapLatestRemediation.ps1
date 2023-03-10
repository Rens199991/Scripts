If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\GetMapLatestR"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\GetMapLatestR"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\GetMapLatestR\GetMapLatestR.ps1.tag" -Value "Installed"
        }