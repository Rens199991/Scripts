$GetTimezone = (Get-timezone).id
$Timezone = "Romance Standard Time"
    
If ($GetTimezone -eq $TimeZone)
    {
    #Create a tag file just so Intune knows this was installedSetTimeZoneToRomanceStandardTime
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTimeDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTimeDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTimeDRNOT\SetTimeZoneToRomanceStandardTimeDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTimeDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTimeDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeZoneToRomanceStandardTimeDRNeeded\SetTimeZoneToRomanceStandardTimeDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 

