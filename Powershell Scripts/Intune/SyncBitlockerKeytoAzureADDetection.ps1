$BitlockerVol = Get-BitLockerVolume -MountPoint $env:SystemDrive


if(-not($BitlockerVol.VolumeStatus -eq "FullyEncrypted"))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADDRNOT\SyncBitlockerKeytoAzureADDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"
    Exit 0
    }
Else
    { 
    Write-Output "Remediation Needed"
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADDRNeeded\SyncBitlockerKeytoAzureADDRNeeded.ps1.tag" -Value "Installed"
        }
    Exit 1
    }   
            