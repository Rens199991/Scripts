$DriveStatus = Get-BitlockerVolume -MountPoint C:

If (!$DriveStatus.VolumeStatus -eq "FullyEncrypted")
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerDRNOT\DisableBitlockerDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerDRNeeded\DisableBitlockerDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 
