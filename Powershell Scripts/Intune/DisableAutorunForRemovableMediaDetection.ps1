$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$Name = "NoDriveTypeAutoRun"
$Value = 4
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty $Name

If ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaDRNOT\DisableAutorunForRemovableMediaDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableAutorunForRemovableMediaDRNeeded\DisableAutorunForRemovableMediaDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 

