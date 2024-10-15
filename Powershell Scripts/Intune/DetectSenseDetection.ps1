#Run DISM silently to check if Microsoft.Windows.Sense.Client capability is installed
$dismOutput = dism /Online /Get-Capabilities /Quiet | Select-String -Pattern "Microsoft.Windows.Sense.Client"


If ($dismOutput -match "State : Installed")
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientDRNOT\DetectSenseClientDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation Needed"    
    Exit 0
    }
Else
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientDRNeeded\DetectSenseClientDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation Needed"
    Exit 1
    } 





