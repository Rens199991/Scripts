$Path = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Options"
$Name = "DisablePOP3"
$Value = 1
$Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name


If ($Registry -eq $Value)
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookDRNOT\BlockPop3andIMAPforOutlookDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\BlockPop3andIMAPforOutlookDRNeeded\BlockPop3andIMAPforOutlookDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 
