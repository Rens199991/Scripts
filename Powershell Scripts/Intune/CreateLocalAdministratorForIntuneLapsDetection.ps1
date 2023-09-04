$userName = "godmode"
$Userexist = (Get-LocalUser).Name -Contains $userName


if ($userexist) 
    {
    #Create a tag file just so Intune knows this was installed
        If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLapsDRNOT"))
            {
            New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\\CreateLocalAdministratorForIntuneLapsDRNOT"
            Set-Content -Path "$($env:ProgramData)\CXN\Scripts\\CreateLocalAdministratorForIntuneLapsDRNOT\\CreateLocalAdministratorForIntuneLapsDRNOT.ps1.tag" -Value "Installed"
            } 
    Write-Host "$userName exist, No Remediation Needed" 
    Exit 0
    } 
Else 
    {
        #Create a tag file just so Intune knows this was installed
        If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateLocalAdministratorForIntuneLapsDRNOT"))
            {
            New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\\CreateLocalAdministratorForIntuneLapsDRNOT"
            Set-Content -Path "$($env:ProgramData)\CXN\Scripts\\CreateLocalAdministratorForIntuneLapsDRNOT\\CreateLocalAdministratorForIntuneLapsDRNOT.ps1.tag" -Value "Installed"
            } 
    Write-Host "$userName does not Exists, Remediation Needed"
    Exit 1
    }