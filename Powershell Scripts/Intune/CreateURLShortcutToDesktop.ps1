#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateURLShortcutToDesktop"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateURLShortcutToDesktop"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateURLShortcutToDesktop\CreateURLShortcutToDesktop.ps1.tag" -Value "Installed"
    }

#Declare Variables,deze gaan aanpassen naargelang de klant, eerste 2 commanden als je geen custom icon nodig hebt
#$publiciconpath = "https://saprfintune.blob.core.windows.net/resources/Icons/Servicedesk.ico"
#$privateiconpath = "$($env:ProgramData)\CXN\Scripts\Icons\icon.ico"
$NameUrl = "\\Profacts Servicedesk.lnk"

<#
#Get icon and copy to Icon folder, deze blok commanden als je geen custom icon nodig hebt
New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\Icons" -Force
Invoke-WebRequest -Uri $publiciconpath -OutFile $privateiconpath
#>

#info over special folders in powershell: https://www.devguru.com/content/technologies/wsh/wshshell-specialfolders.html
$new_object = New-Object -ComObject WScript.Shell

#Desktop Copies to Logged in User's Desktop, AllUsersDesktop Copies to C:\Users\Public\Desktop
$destination = $new_object.SpecialFolders.Item('AllUsersDesktop')

#Bij Childpath de naam ingeven van de Url die je wenst te zien op uw desktop, 4 lijn commanden als je geen custom icon nodig hebt
$source_path = Join-Path -Path $destination -ChildPath $NameUrl
$source = $new_object.CreateShortcut($source_path)
$source.TargetPath = 'https://profacts.atlassian.net/servicedesk/customer/portals'
#$source.IconLocation = $privateiconpath
$source.Save() 


