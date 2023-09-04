Invoke-WebRequest -Uri "https://github.com/gnon17/MS-Cloud-Scripts/raw/main/SetACL.exe" -OutFile C:\Temp\SetACL.exe
C:\Temp\SetACL.exe -on "C:\windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc" -ot file -actn setowner -ownr "n:administrators"
C:\Temp\SetACL.exe -on "C:\windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc" -ot file -actn ace -ace "n:administrators;p:full" -actn rstchldrn -rst DACL
$ngc = get-childitem C:\windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc -ErrorAction SilentlyContinue

If ($null -eq $ngc)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessDRNOT\DisableWindowsHelloForBusinessDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableWindowsHelloForBusinessDRNeeded\DisableWindowsHelloForBusinessDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 




