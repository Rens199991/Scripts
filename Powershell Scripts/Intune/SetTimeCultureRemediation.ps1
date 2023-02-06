#Heel Belangrijk dat je het script runt met de logged-on credentials!!!
#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureR"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\SetTimeCultureR\SetTimeCultureR.ps1.tag" -Value "Installed"
    }

#Set Regional settings to Dutch Belgium (Zo staat de tijdnotatie niet op AM/PM)
Set-WinHomeLocation -GeoId 21
Set-Culture nl-BE