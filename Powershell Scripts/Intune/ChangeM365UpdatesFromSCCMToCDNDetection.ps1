$Path = "HKLM:\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate"
$Name = "OfficeMgmtCOM"
$Type = "DWORD"
$Value = 0
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    
    
If ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNDRNOT\ChangeM365UpdatesFromSCCMToCDNDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNDRNEEDED"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNDRNEEDED"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNDRNEEDED\ChangeM365UpdatesFromSCCMToCDNDRNEEDED.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 
