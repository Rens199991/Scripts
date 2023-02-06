#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrlR\RemoveTCOCertifiedUrlR.ps1.tag" -Value "Installed"
    }

#Begin Script
Remove-Item -Path "c:\ProgramData\HP\TCO" -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Users\Public\Desktop\TCO Certified.lnk" -ErrorAction SilentlyContinue


   

