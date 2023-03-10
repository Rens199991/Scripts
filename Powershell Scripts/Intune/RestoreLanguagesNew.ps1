If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\RestoreLanguagesNew"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\RestoreLanguagesNew"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\RestoreLanguagesNew\RestoreLanguagesNew.ps1.tag" -Value "Installed"
    }

#Retrieves all installed languagepacks
$LanguageList = Get-WinUserLanguageList

#Adds Installedlanguagepacks
$LanguageList.Add("en-BE")
$LanguageList.Add("fr-FR")
$LanguageList.Add("nl-NL")
$LanguageList.Add("de-DE")
$LanguageList.Add("en-US")

Set-WinUserLanguageList $LanguageList -Force

#Puts Region On Belgion
Set-WinHomeLocation -GeoId 21

#Sets Keyboard to Belgian Period
Set-WinDefaultInputMethodOverride '2000:00000813'

#Sets Displaylanguage
Set-WinUILanguageOverride en-US