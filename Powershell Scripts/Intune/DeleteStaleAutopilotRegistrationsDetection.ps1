if (-not(Test-Path -Path "C:\Program Files"))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsDRNOT"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsDRNOT\DeleteStaleAutopilotRegistrationsDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation needed"
    exit 0  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsDRNeeded"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DeleteStaleAutopilotRegistrationsDRNeeded\DeleteStaleAutopilotRegistrationsDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1  
    }


   


