if ((Test-Path -Path "c:\ProgramData\HP\TCO") -or (Test-Path -Path "C:\Users\Public\Desktop\TCO Certified.lnk" -PathType Leaf))
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlDRNeeded"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlDRNeeded"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlDRNeeded\RemoveTCOCertifiedUrlDRNeeded.ps1.tag" -Value "Installed"
        }
    Write-Output "Remediation needed"
    exit 1  
    } 
else 
    {
    #Create a tag file just so Intune knows this was installed
    If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlDRNOT"))
        {
        New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlDRNOT"
        Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlDRNOT\RemoveTCOCertifiedUrlDRNOT.ps1.tag" -Value "Installed"
        }
   Write-Output "No Remediation needed"
   exit 0
    }


   

