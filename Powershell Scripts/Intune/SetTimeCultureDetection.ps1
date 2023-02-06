#Heel Belangrijk dat je het script runt met de logged-on credentials!!!
$Culture = Get-culture
$Culture

If ($Culture.Name -eq "nl-BE")
    {
    #Create a tag file just so Intune knows this was installed
    If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureDRNOT"))
        {   
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureDRNOT\SetTimeCultureDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureDRNEEDED"))
        {   
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureDRNEEDED"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureDRNEEDED\SetTimeCultureDRNEEDED.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 

