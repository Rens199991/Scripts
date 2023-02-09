#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegkeysR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegkeysR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegkeysR\DeleteWindowsUpdatesRegkeysR.ps1.tag" -Value "Installed"
    }

$Regkey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
Remove-Item -Path $Regkey -Recurse -Force




