#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\AllowAccessPublicDesktop"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\AllowAccessPublicDesktop"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\AllowAccessPublicDesktop\AllowAccessPublicDesktop.ps1.tag" -Value "Installed"
    }

#Begin script
$folderPath = "C:\Users\Public\Desktop"
$acl = Get-Acl $folderPath
$user = New-Object System.Security.Principal.SecurityIdentifier('S-1-5-11')
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule ($user,"Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($rule)
Set-ACL $folderPath $acl

