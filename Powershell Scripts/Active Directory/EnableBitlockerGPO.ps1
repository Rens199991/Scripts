<#hhhsfs
A) First Create a GPO

1.Go to Computer Configuration > Administrative Templates > Windows Components > BitLocker Drive Encryption > Operating System Drives.
2.In the right pane, double-click "Require additional authentication at startup"
3.Make sure the "Enabled" option is chosen so that all other options below will be active.
4.Uncheck the box for "Allow BitLocker without a compatible TPM."
5.For the choice of "Configure TPM startup:", choose "Allow TPM."
6.For the choice of "Configure TPM startup PIN:", choose "Do not allow startup PIN with TPM."
7.For the choice of "Configure TPM startup key:", choose "Do not allow startup key with TPM."
8.For the choice of "Configure TPM startup key and PIN:"Do not allowc startup key and PIN with TPM."
9. Click the "Apply" button and then the "OK" button to save the changes.
#>

<#

B) Make a Share with the PS script (see below) and make it accessible to the Domain users and Domain Computers
#>

<#

C) Make a Scheduled Task GPO to activate the PS Script. (Computer Configuration > Preferences > Control Panel Settings > Scheduled Tasks > 
New Scheduled Task (At least Windows 7)

1. General      Action: Update
                Name: Start Bitlocker encryption
                When running the task, use the following user account: NT AUTHORITY\System
                    - Run wheter user is logged on or not
                    - Run with highest privileges
                Configure for windows Vista or Windows Server 2008
2. Triggers:    At log on of any user
3. Action:      Start a program: Powershell.exe
                Add arguments: \\CAS-SRVDC01\EnableBitlockerGPO$\EnableBitlockerGPO.ps1
                (Full command: Powershell.exe \\CAS-SRVDC01\EnableBitlockerGPO$\EnableBitlockerGPO.ps1)
#>


#The command below will encrypt the used space only, skip the hardware test and store the recovery password in the Active Directory.
Enable-Bitlocker -MountPoint c: -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector