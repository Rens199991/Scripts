  #OneDrive
  #Kopieer eerst de downloadlink in Invoke Web-Request --> https://support.microsoft.com/en-us/office/onedrive-release-notes-845dcf18-f921-435e-bf28-4e24b95e5fc0
  Invoke-WebRequest "https://oneclient.sfx.ms/Win/Prod/21.205.1003.0003/amd64/OneDriveSetup.exe" -OutFile "C:\CXN\OneDrive\OneDriveSetup.exe"
  Start-Process "C:\CXN\OneDrive\OneDriveSetup.exe" -ArgumentList "/allusers" -wait
  
  #Teams
  #Eerst de MSI downloaden van deze pagina: https://docs.microsoft.com/en-us/microsoftteams/msi-deployment
  #In laatste regel van het script moet je het path aanpassen waar de msi zich bevindt. 
  #https://statics.teams.cdn.office.net/production-windows-x64/1.5.00.5967/Teams_windows_x64.msi
  $registryPath = "HKLM:\SOFTWARE\Microsoft\Teams\"
  $Name = "IsWVDEnvironment"
  $value = "1"
  New-Item -Path $registryPath -Force 
  New-ItemProperty -Path $registryPath -Name $name -Value $value 
  Start-Process "msiexec.exe" -ArgumentList "/i C:\Users\azureadmin\Downloads\Teams_windows_x64.msi ALLUSER=1 ALLUSERS=1"

  
  #Teamsoptimisation
  #https://christiaanbrinkhoff.com/2020/05/29/learn-how-to-install-and-configure-microsoft-teams-with-av-redirection-media-optimizations-on-windows-virtual-desktop/
  #https://docs.microsoft.com/en-us/azure/virtual-desktop/teams-on-wvd
  #https://statics.teams.cdn.office.net/production-windows-x64/1.5.00.5967/Teams_windows_x64.msi
  wget "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWNg9F" -OutFile "c:\CXN\MsRdcWebRTCSvc_HostSetup_1.1.2110.16001_x64.msi"
  Start-Process "msiexec.exe" -ArgumentList "/i c:\CXN\MsRdcWebRTCSvc_HostSetup_1.1.2110.16001_x64.msi /qn" -wait


 
      

 