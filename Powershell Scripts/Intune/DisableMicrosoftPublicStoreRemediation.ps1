#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreR"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreR"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\DisableMicrosoftPublicStoreR\DisableMicrosoftPublicStoreR.ps1.tag" -Value "Installed"
    }

#Begin Script
$store = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"

If(-not(Test-Path $store))
    {
    New-Item $store
    }

Set-ItemProperty $store RequirePrivateStoreOnly -Value 1 