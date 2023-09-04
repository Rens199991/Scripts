#Create a tag file just so Intune knows this was installed
If (-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLapsR"))
    {   
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLapsR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLapsR\CreateLocalAdministratorForIntuneLapsR.ps1.tag" -Value "Installed"
    }

#Script
$userName = "godmode"
New-LocalUser -Name $username -Description "godmode local user account" -NoPassword
Add-LocalGroupMember -Group "Administrators" -Member $userName
  











