#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeys"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeys"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeys\DeleteWindowsUpdateRegkeys.ps1.tag" -Value "Installed"
    }

$Regkey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
Remove-Item -Path $Regkey -Recurse -Force




