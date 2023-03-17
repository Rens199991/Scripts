If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RestoreLanguagesNew"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RestoreLanguagesNew"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RestoreLanguagesNew\RestoreLanguagesNew.ps1.tag" -Value "Installed"
    }

#Install Languages
Install-Language en-US
Install-Language en-BE
Install-Language nl-BE
Install-Language fr-FR 
Install-Language de-DE

#Retrieves all installed languagepacks
$LanguageList = Get-WinUserLanguageList

#Clears Languagepacks
$LanguageList.Clear()

#Adds Installedlanguagepacks
$LanguageList.Add("en-BE")
$LanguageList.Add("fr-FR")
$LanguageList.Add("nl-NL")
$LanguageList.Add("de-DE")
$LanguageList.Add("en-US")

#Retrieves all installed languagepacks
$LanguageList = Get-WinUserLanguageList

Set-WinUserLanguageList $LanguageList -Force

#Puts Region On Belgion
Set-WinHomeLocation -GeoId 21

#Sets Regional Format to nl-BE
Set-Culture nl-BE

#Sets Keyboard to Belgian Period
Set-WinDefaultInputMethodOverride '2000:00000813'

#Sets Displaylanguage
Set-WinUILanguageOverride en-BE