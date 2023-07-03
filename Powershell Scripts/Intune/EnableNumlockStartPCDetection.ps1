#Define drive HKU:
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS

$Path = "HKU:\.DEFAULT\Control Panel\Keyboard"
$Name = "InitialKeyboardIndicators"
$Value = 2
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty $Name
    
If ($Registry -eq $Value)
    {
    Write-Output "No Remediation Needed"
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCDRNOT\EnableNumlockStartPCDRNOT.ps1.tag" -Value "Installed"
        }
    Exit 0
    }
Else
    { 
    Write-Output "Remediation Needed"
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\EnableNumlockStartPCDRNeeded\EnableNumlockStartPCDRNeeded.ps1.tag" -Value "Installed"
        }
    Exit 1
    } 




