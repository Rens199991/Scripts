#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLaps"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLaps"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLaps\CreateLocalAdministratorForIntuneLaps.ps1.tag" -Value "Installed"
    }

#Script
$userName = "support"
New-LocalUser -Name $username -Description "lapsadmin local user account" -NoPassword
Add-LocalGroupMember -Group "Administrators" -Member $userName
  




