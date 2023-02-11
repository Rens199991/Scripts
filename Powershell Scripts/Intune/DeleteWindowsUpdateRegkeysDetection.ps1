if ((-not(Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdates")))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysDRNOT\DeleteWindowsUpdateRegkeysDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"
    exit 0  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData))\CXN\Scripts\DeleteWindowsUpdateRegkeysDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteWindowsUpdateRegkeysDRNeeded\DeleteWindowsUpdateRegkeysDRNeeded.ps1.tag" -Value "Installed"
        } 
    Write-Output "Remediation Needed"
    exit 1   
    }


