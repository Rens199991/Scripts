<#
Extra info --> https://andrewstaylor.com/2022/08/09/removing-bloatware-from-windows-10-11-via-script/
Run in the 64-bit context
#>

if (Test-Path -Path "C:\Program Files")
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareDRNeeded"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareDRNeeded\RemoveBloatwareDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1  
    }
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareDRNOT"))
	    {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveBloatwareDRNOT\RemoveBloatwareDRNOT.ps1.tag" -Value "Installed"
        }
    Write-Output "No Remediation needed"
    exit 0  
    }


   
