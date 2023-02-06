#run as administrator

$files = Get-ChildItem "e:\"


$migratefolder = "c:\temp\"

foreach($f in $files)
{
    $mount = Mount-vhd -Path $f.FullName -PassThru | Get-Disk | Get-Partition | Get-Volume
    $driveletter = ($mount.DriveLetter + ":\")
    Get-ChildItem $driveletter
    $ADuser = Get-ADUser $f.Name.Replace('UVHD-','').replace('.vhdx','')

    #copydata
    #desktop
    $folder = 'Desktop'
    $source = $driveletter + $folder
    $dest = $migratefolder + $ADuser.SamAccountName + "\" + $folder
    robocopy $source $dest /mir

     #Documents
    $folder = 'Documents'
    $source = $driveletter + $folder
    $dest = $migratefolder + $ADuser.SamAccountName + "\" + $folder
    robocopy $source $dest /mir

    #pictures
    $folder = 'pictures'
    $source = $driveletter + $folder
    $dest = $migratefolder + $ADuser.SamAccountName + "\" + $folder
    robocopy $source $dest /mir


    Dismount-VHD -Path $f.FullName
}
