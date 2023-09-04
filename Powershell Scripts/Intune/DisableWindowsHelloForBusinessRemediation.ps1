Invoke-WebRequest -Uri "https://github.com/gnon17/MS-Cloud-Scripts/raw/main/SetACL.exe" -OutFile C:\Temp\SetACL.exe
C:\Temp\SetACL.exe -on "C:\windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc" -ot file -actn setowner -ownr "n:administrators"
C:\Temp\SetACL.exe -on "C:\windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc" -ot file -actn ace -ace "n:administrators;p:full" -actn rstchldrn -rst DACL



#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessRemediationR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessR\DisableWindowsHelloForBusinessR.ps1.tag" -Value "Installed"
    }


#Begin Script
Remove-Item "C:\windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc" -recurse -force
Remove-Item $path\SetACL.exe -Force




