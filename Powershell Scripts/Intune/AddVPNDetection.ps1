if (Get-VpnConnection -Name "Allinox")
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\AddVPNDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\AddVPNDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\AddVPNDRNOT\AddVPNDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"
    Exit 0
    }
Else
    { 
    Write-Output "Remediation Needed"
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\AddVPNDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\AddVPNDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\AddVPNDRNeeded\AddVPNDRNeeded.ps1.tag" -Value "Installed"
        }
    Exit 1
    }   