#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrl"))
	{
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrl"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RemoveTCOCertifiedUrl\RemoveTCOCertifiedUrl.ps1.tag" -Value "Installed"
    }

#Begin script
Remove-Item -Recurse "c:\ProgramData\HP\TCO"
Remove-Item "C:\Users\Public\Desktop\TCO Certified.lnk"



   

