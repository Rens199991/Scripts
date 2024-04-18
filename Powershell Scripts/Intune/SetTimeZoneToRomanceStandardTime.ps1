#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTime"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTime"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTime\SetTimeZoneToRomanceStandardTime.ps1.tag" -Value "Installed"
    }

#Begin Script
Set-TimeZone -Id "Romance Standard Time"