#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegkeys"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegkeys"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdatesRegkeys\DeleteWindowsUpdatesRegkeys.ps1.tag" -Value "Installed"
    }


$Regkey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
 
Remove-Item -Path $Regkey -Recurse -Force




