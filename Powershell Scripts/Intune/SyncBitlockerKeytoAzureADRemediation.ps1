#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SyncBitlockerKeytoAzureADR\SyncBitlockerKeytoAzureADR.ps1.tag" -Value "Installed"
    }

$BitlockerVol = Get-BitLockerVolume -MountPoint $env:SystemDrive
$KPID=""
    foreach($KP in $BitlockerVol.KeyProtector){
            if($KP.KeyProtectorType -eq "RecoveryPassword")
                {
                $KPID=$KP.KeyProtectorId
                }
            }

$output = BackupToAAD-BitLockerKeyProtector -MountPoint "$($env:SystemDrive)" -KeyProtectorId $KPID
$output | Format-List
