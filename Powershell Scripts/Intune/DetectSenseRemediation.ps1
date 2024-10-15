#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DetectSenseClientR\DetectSenseClientR.ps1.tag" -Value "Installed"
    }

#Install the capability using DISM, suppressing any prompts
dism /Online /Add-Capability /CapabilityName:Microsoft.Windows.Sense.Client /Quiet /NoRestart
