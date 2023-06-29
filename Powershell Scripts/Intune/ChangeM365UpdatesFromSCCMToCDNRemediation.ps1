#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\ChangeM365UpdatesFromSCCMToCDNR\ChangeM365UpdatesFromSCCMToCDNR.ps1.tag" -Value "Installed"
    }


#Begin Script
$Path = "HKLM:\SOFTWARE\Policies\Microsoft\office\16.0\common\officeupdate"
$Name = "OfficeMgmtCOM"
$Type = "DWORD"
$Value = 0
 
Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value