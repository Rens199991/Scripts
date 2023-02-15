$Doeskeyvaluexist = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -ErrorAction SilentlyContinue

if ($null -eq $Doeskeyvaluexist)
    {
     #Create a tag file just so Intune knows this was installed
     If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveWindowsUpdateKeyDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveWindowsUpdateKeyDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveWindowsUpdateKeyDRNOT\RemoveWindowsUpdateKeyDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation needed"
    exit 0
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveWindowsUpdateKeyDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveWindowsUpdateKeyDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveWindowsUpdateKeyDRNeeded\RemoveWindowsUpdateKeyDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1   
    }










