$users = Get-ChildItem c:\users | Where-Object{ $_.PSIsContainer }

foreach ($user in $users)
    {
    $userpath = "C:\users\$user\AppData\Local\Microsoft\Edge"
        Try
            {
            Remove-Item $userpath\* -Recurse -ErrorVariable errs -ErrorAction SilentlyContinue
            }
        catch 
            {
            "$errs" | Out-File c:\temp\errors.txt -append
            }
    }