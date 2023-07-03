$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$Name = "HiberbootEnabled"
$Value = 0
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty $Name

If ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableFastbootDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableFastbootDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableFastbootDRNOT\DisableFastbootDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableFastbootDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableFastbootDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableFastbootDRNeeded\DisableFastbootDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 

