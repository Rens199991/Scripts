#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateRDPShortcutToDesktop"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateRDPShortcutToDesktop"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateRDPShortcutToDesktop\CreateRDPShortcutToDesktop.ps1.tag" -Value "Installed"
    }

#info over special folders in powershell: https://www.devguru.com/content/technologies/wsh/wshshell-specialfolders.html

$new_object = New-Object -ComObject WScript.Shell

#Hier de naam aanpassen van rdp file bij test.rdp

$destination = $new_object.SpecialFolders.Item("AllUsersDesktop") + "\OMER-RDS.rdp"
New-Item $destination

#Hieronder kunnen we de properties van de RDP bepalen, om de eigenschappen van een bestaande RDP te achterhalen kunnen we de RDP opendoen in Notepad
#Belangrijk, de eerste tick moet na $Destinatinon komen, niet eronder!!!!, de tweede tick achter de regel, dus ook niet eronder
#Script moet lopen in system/admin mode

Set-Content $destination 'screen mode id:i:2
use multimon:i:0
desktopwidth:i:800
desktopheight:i:600
session bpp:i:32
winposstr:s:0,3,0,0,800,600
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
full address:s:OVDG-W19-RDS01
audiomode:i:0
redirectprinters:i:1
redirectcomports:i:0
redirectsmartcards:i:1
redirectclipboard:i:1
redirectposdevices:i:0
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:0
alternate shell:s:
shell working directory:s:
gatewayhostname:s:rds.omer.be
gatewayusagemethod:i:2
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:1
promptcredentialonce:i:1
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:'
    
    

