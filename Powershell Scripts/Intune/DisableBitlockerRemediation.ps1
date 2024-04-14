#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableBitlockerR\DisableBitlockerR.ps1.tag" -Value "Installed"
    }

#Begin Script
$DriveStatus = Get-BitlockerVolume -MountPoint C:
If ($DriveStatus.VolumeStatus -eq "FullyEncrypted") 
    {
    Write-Host "C Volume is fully encrypted. Disabling bitlocker and decrypting volume"
    Try {
        Disable-Bitlocker -MountPoint "C:"
        }

    Catch 
        {
        Write-Host -ForegroundColor Red $_
        Write-Host "There was an issue disabling bitlocker"
        }
    }

$Loop = $true

while($Loop)
    {
    $DecryptStatus = Get-BitlockerVolume -MountPoint C: | Select -expandproperty VolumeStatus
    $DecryptPercentage = Get-BitlockerVolume -MountPoint C: | Select -expandproperty EncryptionPercentage

    if($DecryptStatus -eq "FullyDecrypted")
        {
        Write-Host -ForegroundColor Green "Volume has been fully decrypted"
        $Loop = $false
        }
    Else 
        {
        Write-Host "Waiting for decryption. Current encryption percentage is $DecryptPercentage"
        Start-Sleep -Seconds 15
        }
    }