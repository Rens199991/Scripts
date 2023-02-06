@echo off
echo.
echo  ____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
echo (  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
echo  ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
echo (____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)
echo.
echo HP and Windows 10 Bloatware Removal Version 1.0
echo By Thomas Lambert
echo.
echo Make Sure to Run As Administrator!
echo.
:Start
::Pause
@echo on

:: Hewlett-Packard Software Removal

START /WAIT /MIN WMIC product where name="Assistant" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Documentation" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Documentation" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Guide" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Energy Star" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="StatusAlerts" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Support" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Documentation" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Print SW" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Notifications" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Pixel Sharp" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP System Default Settings" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="Discover HP Touchpoint Manager" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP 3D DriveGuard" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Welcome" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Registration Service" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Software Setup" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP System Default Settings" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Client Security Manager" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Hotkey Support" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Sure Click Application Support for Windows" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Sure Click" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP JumpStart Launch" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP JumpStart Bridge" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP Customer Experience Enhancements" call uninstall /nointeractive
START /WAIT /MIN WMIC product where name="HP ESU for Microsoft Windows 10" call uninstall /nointeractive
START /WAIT /MIN WMIC product where Name="HP Support Solutions Framework" call uninstall /nointeractive

::------------------------

Echo Begin removal via GUID 
::Pause
:: Hewlett-Packard ACLM.NET
start /wait msiexec /qn /norestart /x {6F340107-F9AA-47C6-B54C-C3A19F11553F}
start /wait msiexec /qn /norestart /x {06FCC605-92A1-4A1C-B7D1-85E5778290A4}

:: Hewlett-Packard Asset Agent for Health Check
start /wait msiexec /qn /norestart /x {669D4A35-146B-4314-89F1-1AC3D7B88367}

:: HP
start /wait msiexec /qn /norestart /x {B2EE25B9-5B00-4ACF-94F0-92433C28C39E}
start /wait msiexec /qn /norestart /x {3023EBDA-BF1B-4831-B347-E5018555F26E}

:: HP 3.00.xxxx (various versions)
start /wait msiexec /qn /norestart /x {2F518061-89DB-4AF0-9A7A-2BF73B60E6F0}
start /wait msiexec /qn /norestart /x {912D30CF-F39E-4B31-AD9A-123C6B794EE2}
start /wait msiexec /qn /norestart /x {F9569D00-4576-46C8-B6C7-207A4FD39745}

:: HP 3D DriveGuard
start /wait msiexec /qn /norestart /x {E8D0E2B8-B64B-44BC-8E01-00DDACBDF78A}
start /wait msiexec /qn /norestart /x {E5823036-6F09-4D0A-B05C-E2BAA129288A}
start /wait msiexec /qn /norestart /x {0C57987A-A03A-4B95-A309-D23F78F406CA}
start /wait msiexec /qn /norestart /x {55CA337D-2BE3-4AA4-BA1E-652F4C02E893}
start /wait msiexec /qn /norestart /x {675D093B-815D-47FD-AB2C-192EC751E8E2}
start /wait msiexec /qn /norestart /x {5B08AF35-B699-4A44-BB89-3E51E70611E8}
start /wait msiexec /qn /norestart /x {C05002F1-06F8-4A15-B6F8-E4DC655C28AA}
start /wait msiexec /qn /norestart /x {6BA7C52E-4071-47CC-9060-ABB143862DB0}
start /wait msiexec /qn /norestart /x {ADE2F6A7-E7BD-4955-BD66-30903B223DDF}
start /wait msiexec /qn /norestart /x {07E79F52-1D78-4081-814E-BF093FF7A1BF}
start /wait msiexec /qn /norestart /x {F792E5B0-11C4-4C68-8A63-FB5F52749180}
start /wait msiexec /qn /norestart /x {130E5108-547F-4482-91EE-F45C784E08C7}
start /wait msiexec /qn /norestart /x {D79A02E9-6713-4335-9668-AAC7474C0C0E}
start /wait msiexec /qn /norestart /x {54CE68A8-4F2D-4328-B1F7-D6C720405F7F}
start /wait msiexec /qn /norestart /x {299625B9-6C69-462C-9CEA-8E06D878B1C5}
start /wait msiexec /qn /norestart /x {85A42FF0-F0D0-44A3-B226-C124D6E8B1D5}

:: HP 64 Bit HP CIO Components Installer
start /wait msiexec /qn /norestart /x {FF21C3E6-97FD-474F-9518-8DCBE94C2854}
start /wait msiexec /qn /norestart /x {BC741628-0AFC-405C-8946-DD46D1005A0A}

:: HP ActiveCheck component for HP Active Support Libary
start /wait msiexec /qn /norestart /x {254C37AA-6B72-4300-84F6-98A82419187E}
start /wait msiexec /qn /norestart /x {CBB639E0-B534-4827-97B5-CA1A4CA985B5}

:: HP Active Support Library
start /wait msiexec /qn /norestart /x {0A47BAFF-D4FF-4BD3-96CA-02A22EA62722}

:: HP Advisor
start /wait msiexec /qn /norestart /x {403996EB-2DCE-4C43-A2B8-2B956880772D}
start /wait msiexec /qn /norestart /x {40FB8D7C-6FF8-4AF2-BC8B-0B1DB32AF04B}

:: HP App Studio
start /wait msiexec /qn /norestart /x {565E7B0E-B76B-4EAD-9753-F1E72A5CF12E}

:: HP Auto
start /wait msiexec /qn /norestart /x {CB7D766C-879F-4800-BB09-3D29E306EF63}
start /wait msiexec /qn /norestart /x {CC4D56B7-6F18-470B-8734-ABCD75BCF4F1}

:: HP Boot Optimizer
start /wait msiexec /qn /norestart /x {1341D838-719C-4A05-B50F-49420CA1B4BB}

:: HP BufferChm
start /wait msiexec /qn /norestart /x {FA0FF682-CC70-4C57-93CD-E276F3E7537E}
start /wait msiexec /qn /norestart /x {2EEA7AA4-C203-4b90-A34F-19FB7EF1C81C}
start /wait msiexec /qn /norestart /x {62230596-37E5-4618-A329-0D21F529A86F}
start /wait msiexec /qn /norestart /x {687FEF8A-8597-40b4-832C-297EA3F35817}

:: HP BPDSoftware (various versions); known to create annoying error messages and popups at system boot
start /wait msiexec /qn /norestart /x {20D48DD8-06BA-4d5a-9796-6C7582F07947}
start /wait msiexec /qn /norestart /x {38DAE5F5-EC70-4aa5-801B-D11CA0A33B41}
start /wait msiexec /qn /norestart /x {508CE680-CAF5-4d0a-86E5-84E7B0701F26}
start /wait msiexec /qn /norestart /x {268C2D6E-CDE9-47CD-87D9-A87710966709}
start /wait msiexec /qn /norestart /x {671B4BAD-D681-4d29-9498-D8BF3F1A389D}
start /wait msiexec /qn /norestart /x {6CC080F1-2E00-41D5-BE47-A3BC784E9DFB}
start /wait msiexec /qn /norestart /x {AFB69549-3AAE-4433-A99B-673B8A513379}

:: HP C4400_Help
start /wait msiexec /qn /norestart /x {4F923F90-46D1-4492-9CC6-13FBBA00E7EC}

:: HP Cards_Calendar_OrderGift_DoMorePlugout 1.00.0000
start /wait msiexec /qn /norestart /x {C918E3D8-208F-43DB-B346-6299D59336D7}

:: HP CinemaNow Media Manager
start /wait msiexec /qn /norestart /x {A5E65B95-F016-474D-BC0D-6AF64412BBDF}

:: HP Client Security Manager (various versions)
start /wait msiexec /qn /norestart /x {39930586-2677-432B-B928-F970FB43F46F}
start /wait msiexec /qn /norestart /x {3B46DFDA-6155-423B-BCBB-F1C267E4ADD9}
start /wait msiexec /qn /norestart /x {3AF15EEA-8EDF-4393-BB6C-CF8A9986486A}
start /wait msiexec /qn /norestart /x {CA19DC3C-DA9E-40B1-B501-710F437604C0}
start /wait msiexec /qn /norestart /x {D5510D28-D0E4-433E-A0F3-EE3FCECA60D2}
start /wait msiexec /qn /norestart /x {167AA1D5-8412-44BC-A003-B7A3662D1CE2}
start /wait msiexec /qn /norestart /x {82E616DB-8BE9-46B7-AE42-60200985AD78}

:: HP Client Services 1.1.12938.3539
start /wait msiexec /qn /norestart /x {28074A47-851D-4599-A270-87609F58EB57}

:: HP Color LaserJet Pro MFP M476 Scan Shortcuts 32.0.74.0
start /wait msiexec /qn /norestart /x {B411AD10-1BC9-4939-8848-BC5E66F662B7}

:: HP Connected Remote
start /wait msiexec /qn /norestart /x {F1DD6CD2-6734-4089-9EF5-441F51E083B6}
start /wait msiexec /qn /norestart /x {F243A34B-AB7F-4065-B770-B85B767C247C}

:: HP Connection Manager (various versions)
start /wait msiexec /qn /norestart /x {04C23662-CE15-48BE-AF77-7BD9028934E7}
start /wait msiexec /qn /norestart /x {7940DAB9-AC72-4422-8908-DCF58C2C1D21}
start /wait msiexec /qn /norestart /x {226837D8-0BF8-4CBE-BAB2-8F07E2C2B4DD}
start /wait msiexec /qn /norestart /x {40FB8D7C-6FF8-4AF2-BC8B-0B1DB32AF04B}
start /wait msiexec /qn /norestart /x {EB58480C-0721-483C-B354-9D35A147999F}
start /wait msiexec /qn /norestart /x {7B7FF4D0-D4E2-4E8E-908D-90AB01BC4568}
start /wait msiexec /qn /norestart /x {6468C4A5-E47E-405F-B675-A70A70983EA6}

:: HP CoolSense
start /wait msiexec /qn /norestart /x {85DF2EED-08BC-46FB-90DA-28B0D0A8E8A8}
start /wait msiexec /qn /norestart /x {DFD6EBE3-F0DA-4E24-9202-37AF8D20888B}
start /wait msiexec /qn /norestart /x {ADDF4B84-5D28-4EAE-8511-EF808C8BC81C}
start /wait msiexec /qn /norestart /x {1504CF6F-8139-497F-86FC-46174B67CF7F}
start /wait msiexec /qn /norestart /x {59F8C5AA-91BD-423D-BF05-09A80F39898F}
start /wait msiexec /qn /norestart /x {11AF9A96-6D83-4C3B-8DCB-16EA2A358E3F}

:: HP Copy (various versions)
start /wait msiexec /qn /norestart /x {3C92B2E6-380D-4fef-B4DF-4A3B4B669771}
start /wait msiexec /qn /norestart /x {55D003F4-9599-44BF-BA9E-95D060730DD3}

:: HP CUE Status (various versions)
start /wait msiexec /qn /norestart /x {5B025634-7D5B-4B8D-BE2A-7943C1CF2D5D}
start /wait msiexec /qn /norestart /x {CE938F96-2EDD-4377-942A-1B877616E523}
start /wait msiexec /qn /norestart /x {A0B9F8DF-C949-45ed-9808-7DC5C0C19C81}
start /wait msiexec /qn /norestart /x {03A7C57A-B2C8-409b-92E5-524A0DFD0DD3}
start /wait msiexec /qn /norestart /x {0EF5BEA9-B9D3-46d7-8958-FB69A0BAEACC}

:: HP Customer Experience Enhancements / HP Advisor / HP Customer Feedback / HP Launch Box
start /wait msiexec /qn /norestart /x {07FA4960-B038-49EB-891B-9F95930AA544}
start /wait msiexec /qn /norestart /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}
start /wait msiexec /qn /norestart /x {07F6DC37-0857-4B68-A675-4E35989E85E3}
start /wait msiexec /qn /norestart /x {07FA4960-B038-49EB-891B-9F95930AA544}
start /wait msiexec /qn /norestart /x {73A43E42-3658-4DD9-8551-FACDA3632538}
start /wait msiexec /qn /norestart /x {AB5E289E-76BF-4251-9F3F-9B763F681AE0}
start /wait msiexec /qn /norestart /x {9DBA770F-BF73-4D39-B1DF-6035D95268FC}
start /wait msiexec /qn /norestart /x {BF1E75D0-E7AF-4BEA-9FBC-567F0C54BDF9}
start /wait msiexec /qn /norestart /x {C27C82E4-9C53-4D76-9ED3-A01A3D5EE679}
start /wait msiexec /qn /norestart /x {C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}
start /wait msiexec /qn /norestart /x {57A5AEC1-97FC-474D-92C4-908FCC2253D4}

:: HP CustomerResearchQFolder
start /wait msiexec /qn /norestart /x {7206B668-FEE0-455B-BB1F-9B5A2E0EC94A}

:: HP Connected Music
start /wait msiexec /qn /norestart /x {8126E380-F9C6-4317-9CEE-9BBDDAB676E5}

:: HP D2400_Help
start /wait msiexec /qn /norestart /x {7EF7CCB0-52BF-4947-BE6E-E47D586E8842}

:: HP Deskjet 2510 series Setup Guide
start /wait msiexec /qn /norestart /x {216C7F38-4BBC-4E9A-8392-C9FA21B54386}

:: HP Deskjet Series Help
start /wait msiexec /qn /norestart /x {F7632A9B-661E-4FD9-B1A4-3B86BC99847F}
start /wait msiexec /qn /norestart /x {97C1C98D-6AE5-4C71-9B00-EBBD9E014450}

:: HP Destinations
start /wait msiexec /qn /norestart /x {5E487136-B52E-4856-8F5F-FCDF5E5FC5EE}
start /wait msiexec /qn /norestart /x {D99A8E3A-AE5A-4692-8B19-6F16D454E240}
start /wait msiexec /qn /norestart /x {EF9E56EE-0243-4BAD-88F4-5E7508AA7D96}

:: HP Device Access Manager
start /wait msiexec /qn /norestart /x {D7BC5D88-FC93-46D6-B7B0-145C2E168A95}
start /wait msiexec /qn /norestart /x {2642BE09-1F9F-4E18-AAD4-0258B9BCE611}
start /wait msiexec /qn /norestart /x {9EC0BE64-2C6C-428A-A4C2-E7EDF831B29A}
start /wait msiexec /qn /norestart /x {DBCD5E64-7379-4648-9444-8A6558DCB614}
start /wait msiexec /qn /norestart /x {BD7204BA-DD64-499E-9B55-6A282CDF4FA4}
start /wait msiexec /qn /norestart /x {55B52830-024A-443E-AF61-61E1E71AFA1B}

:: HP DeviceManagementQFolder
start /wait msiexec /qn /norestart /x {AB5D51AE-EBC3-438D-872C-705C7C2084B0}
start /wait msiexec /qn /norestart /x {F769B78E-FF0E-4db5-95E2-9F4C8D6352FE}

:: HP Discover hp Touchpoint Manager
start /wait msiexec /qn /norestart /x {74C4DA32-D4FD-406B-AEA3-6781757C8EC3}
start /wait msiexec /qn /norestart /x {37EC8980-A8E5-411D-8CDD-CB1CCA95057F}

:: HP DisplayLink Core Software and DisplayLink Graphics
start /wait msiexec /qn /norestart /x {796E076A-82F7-4D49-98C8-DEC0C3BC733A}
start /wait msiexec /qn /norestart /x {33023FE8-9028-416A-8A5C-C115B59DD538}
start /wait msiexec /qn /norestart /x {0DE76F90-E993-47C7-BF6A-2B385492D490}
start /wait msiexec /qn /norestart /x {2021896F-CECA-463C-A7A8-9949A13910F7}
start /wait msiexec /qn /norestart /x {7BB949B9-EB47-47E4-814D-88F8CD301543}
start /wait msiexec /qn /norestart /x {D21BDA13-5E4C-401D-8353-2543251B40E2}
start /wait msiexec /qn /norestart /x {A4D282D0-1B48-481B-9E52-5F0B001A2BAB}
start /wait msiexec /qn /norestart /x {34412EC4-6A3C-454F-AF8B-75B0A0DF00AB}
start /wait msiexec /qn /norestart /x {861C4DFA-E691-4BA6-BE6B-D5BA211990B6}
start /wait msiexec /qn /norestart /x {3B1040BE-8AB0-4D80-A68E-029D70A0868B}
start /wait msiexec /qn /norestart /x {70E2B27F-0B7F-41B2-8145-E7377BC9F75A}
start /wait msiexec /qn /norestart /x {8C2259F3-35F4-4663-87BF-9F5F6AE6C4F7}
start /wait msiexec /qn /norestart /x {12F5A080-A6EE-4FCC-B355-80CBBF33FAA0}
start /wait msiexec /qn /norestart /x {89E40591-0404-4769-88E7-F649C95AE151}
start /wait msiexec /qn /norestart /x {65B2569D-303B-41EC-B38C-0934963BC3AD}
start /wait msiexec /qn /norestart /x {D9D8900B-CFEB-44C6-B417-D6308B5B145D}
start /wait msiexec /qn /norestart /x {29E6A126-BB06-41CF-B12D-E6A56261328D}

:: HP Documentation
start /wait msiexec /qn /norestart /x {73A33079-D1A0-4469-8903-C4A48B4975E2}
start /wait msiexec /qn /norestart /x {C8D60CF4-BE7A-487E-BD36-535111BDB0FE}
start /wait msiexec /qn /norestart /x {06600E94-1C34-40E2-AB09-D30AECF78172}
start /wait msiexec /qn /norestart /x {025D3904-FA39-4AA2-A05B-9EFAAF36B1F2}
start /wait msiexec /qn /norestart /x {1F0493F6-311D-44E5-A9E6-F0D4C63FB8FD}
start /wait msiexec /qn /norestart /x {5340A3C6-4169-484A-ADA7-63BCF5C557A0}
start /wait msiexec /qn /norestart /x {7573D7E5-02BB-4903-80EB-36073A99BC8D}
start /wait msiexec /qn /norestart /x {791A06E2-340F-43B0-8FAB-62D151339362}
start /wait msiexec /qn /norestart /x {8327F6D2-C8CC-49B5-B8D1-46C83909650E}
start /wait msiexec /qn /norestart /x {84F0C8C0-263A-4B3A-888D-2A5FDEA15401}
start /wait msiexec /qn /norestart /x {8ABB6A99-E2D5-47E4-905A-2FD4657D235E}
start /wait msiexec /qn /norestart /x {9867A917-5D17-40DE-83BA-BEA5293194B1}
start /wait msiexec /qn /norestart /x {A6365256-0FBA-4DCD-88CE-D92A4DC9328E}
start /wait msiexec /qn /norestart /x {A1CFA587-90D4-4DE6-B200-68CC0F92252F}
start /wait msiexec /qn /norestart /x {53AE55F3-8E99-4776-A347-06222894ECD3}
start /wait msiexec /qn /norestart /x {95CC589C-8D98-4539-9878-4E6A342304F2}
start /wait msiexec /qn /norestart /x {9D20F550-4222-49A7-A7A7-7CAAB2E16C9C}
start /wait msiexec /qn /norestart /x {89A12FD9-8FA0-4EB9-AE9A-34C7EB25C25B}
start /wait msiexec /qn /norestart /x {25F3EC6C-BB03-4CEB-B36C-E656A9DD149E}

:: HP Documentation Extras
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HP_Documentation" /f
del /q /f "C:\Users\All Users\Microsoft\Windows\Start Menu\Programs\HP Help and Support\HP Documentation.lnk"
del /q /f "C:\Users\All Users\Microsoft\Windows\Start Menu\Programs\HP\HP Documentation.lnk"
rmdir /S /Q "C:\Program Files\HP\Documentation"

:: HP DocProc
start /wait msiexec /qn /norestart /x {676981B7-A2D9-49D0-9F4C-03018F131DA9}
start /wait msiexec /qn /norestart /x {C29C1940-CB85-4F3B-906C-33FEE0E67103}
start /wait msiexec /qn /norestart /x {679EC478-3FF9-4987-B2FF-C2C2B27532A2}
start /wait msiexec /qn /norestart /x {9B362566-EC1B-4700-BB9C-EC661BDE2175}

:: HPDiagnosticAlert
start /wait msiexec /qn /norestart /x {B6465A32-8BE9-4B38-ADC5-4B4BDDC10B0D}
start /wait msiexec /qn /norestart /x {846B5DED-DC8C-4E1A-B5B4-9F5B39A0CACE}

:: HP DisableMSDefender (disables Microsoft Defender...wtf?)
start /wait msiexec /qn /norestart /x {74FE39A0-FB76-47CD-84BA-91E2BBB17EF2}
start /wait msiexec /qn /norestart /x {AF9E97C1-7431-426D-A8D5-ABE40995C0B1}

:: HP Drive Encryption for HP ProtectTools
start /wait msiexec /qn /norestart /x {B05372A4-5AF0-4343-BA7B-2745E30A2D23}
start /wait msiexec /qn /norestart /x {34E6F14D-68F9-486D-87BA-6AA8431F3F44}

:: HP Easy Setup - Frontend
start /wait msiexec /qn /norestart /x {40F7AED3-0C7D-4582-99F6-484A515C73F2}
::"%ProgramFiles%\InstallShield Installation Information\{40F7AED3-0C7D-4582-99F6-484A515C73F2}\setup.exe" -l0x9  -removeonly

:: HP Energy Star
start /wait msiexec /qn /norestart /x {FC0ADA4D-8FA5-4452-8AFF-F0A0BAC97EF7}
start /wait msiexec /qn /norestart /x {0FA995CC-C849-4755-B14B-5404CC75DC24}

:: HP ENVY 4500 series Help
start /wait msiexec /qn /norestart /x {95BECC50-22B4-4FCA-8A2E-BF77713E6D3A}

:: HP ESU for Microsoft Windows (Windows update hijacker)
start /wait msiexec /qn /norestart /x {240B2BF7-E7E6-425C-A2A4-A3149189BF7F}
start /wait msiexec /qn /norestart /x {A5F1C701-E150-4A86-A7F8-9E9225C2AE52}
start /wait msiexec /qn /norestart /x {6349342F-9CEF-4A70-995A-2CF3704C2603}
start /wait msiexec /qn /norestart /x {22706ADC-74A1-43A0-ABAE-47F84966B909}
start /wait msiexec /qn /norestart /x {2BF5E9CC-C55D-4B0F-ACAF-FFE77F333CD8}
start /wait msiexec /qn /norestart /x {A351CC1B-C92C-4F37-8109-9F6D33ACF5EF}
start /wait msiexec /qn /norestart /x {722A2876-B382-4AB5-8CC9-007FF5B28641}

:: HP eSupportQFolder
start /wait msiexec /qn /norestart /x {66E6CE0C-5A1E-430C-B40A-0C90FF1804A8}
start /wait msiexec /qn /norestart /x {8894A6A7-547D-4326-B4BC-FB62B9075CE2}

:: HP File Sanitizer
start /wait msiexec /qn /norestart /x {53D3E126-699A-4D92-AA66-6560D573553E}
start /wait msiexec /qn /norestart /x {60F90886-FAEE-4768-9817-093AB0F30540}

:: HP FWUpdateEDO2
start /wait msiexec /qn /norestart /x {415FA9AD-DA10-4ABE-97B6-5051D4795C90}

:: HP Games
:: These two FOR loops should catch ALL HP games, in theory at least
:: Basically, loop through the HP Games subdirectory, and if an "Uninstall.exe" exists ANYWHERE, run it with the /silent flag
for /r "%ProgramFiles%\HP Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )
for /r "%ProgramFiles(x86)%\HP Games" %%i in (Uninstall.exe) do ( if exist "%%i" "%%i" /silent )

:: HP GPBaseService2 (popups)
start /wait msiexec /qn /norestart /x {BB3447F6-9553-4AA9-960E-0DB5310C5779}

:: HP Insight Diagnostics Online Edition for Windows 9.3.0
start /wait msiexec /qn /norestart /x {DBE16A07-DDFF-4453-807A-212EF93916E0}

:: HP Launch Box
start /wait msiexec /qn /norestart /x {9CAB2212-0732-4827-8EC4-61D8EF0AA65B}
start /wait msiexec /qn /norestart /x {5A847522-375C-4D05-BD3D-88C450CC047F}

:: HP misc Help, eDocs and User Guide GUIDs (various versions for various products; most of these should be caught in the wildcard scan)
start /wait msiexec /qn /norestart /x {11C9A461-DD9D-4C71-85A4-6DCE7F99CC44}
start /wait msiexec /qn /norestart /x {B6B9006D-5A0A-4F17-B69A-42F48C1FC30C}
start /wait msiexec /qn /norestart /x {445CC807-9384-47FA-A2B6-FFE970352B88}
start /wait msiexec /qn /norestart /x {F90A86C9-7779-47DD-AC06-8EE832C55F55}
start /wait msiexec /qn /norestart /x {1575F408-60AC-4a37-904A-931117272926}
start /wait msiexec /qn /norestart /x {4B322C8E-8775-4f20-8978-ED63DB4770C4}
start /wait msiexec /qn /norestart /x {7E60EE8D-0914-444E-A682-7703BDDEB5EB}
start /wait msiexec /qn /norestart /x {DE13432E-F0C1-4842-A5BA-CC997DA72A70}
start /wait msiexec /qn /norestart /x {A4966638-798C-45B9-B5BF-07D3E63B58C2}
start /wait msiexec /qn /norestart /x {7F94FB03-6617-4442-9817-CDDB36EAE529}
start /wait msiexec /qn /norestart /x {86BC184E-CFCD-48D5-829A-666A36C6ACC9}
start /wait msiexec /qn /norestart /x {B8454F30-79EC-4959-BCF1-3776DEC406AB}
start /wait msiexec /qn /norestart /x {BCFAA37D-A6DB-43BF-A351-43F183E52D07}
start /wait msiexec /qn /norestart /x {5C76ED0D-0F6F-4985-8B34-F9AE7834848F}
start /wait msiexec /qn /norestart /x {74038F40-03AE-4785-865B-07EC7F6A5E97}
start /wait msiexec /qn /norestart /x {04D66C1E-E5E2-483C-8715-916C42703924}
start /wait msiexec /qn /norestart /x {5D3E11CE-2C9A-44E3-A561-ED9BAC439E83}
start /wait msiexec /qn /norestart /x {83A375B6-6FC2-4F8A-948E-E506DB9DCDF0}
start /wait msiexec /qn /norestart /x {D2A2E5CD-801A-4B8D-8119-F79449A09B67}
start /wait msiexec /qn /norestart /x {F6D61EC9-347B-4019-9F8E-E24169F7C330}
start /wait msiexec /qn /norestart /x {2A186F69-BCC4-4529-9F24-A8FFB7F4E1C9}
start /wait msiexec /qn /norestart /x {6357258D-2BF9-49E7-A9EF-0C609D52C46D}
start /wait msiexec /qn /norestart /x {563ADFC1-38E6-4EF0-8763-7CDA8289944B}
start /wait msiexec /qn /norestart /x {C1223A79-3983-4877-B162-75031E7CE322}
start /wait msiexec /qn /norestart /x {DDEBEA89-2B5A-4E5B-8702-369882BB3F52}
start /wait msiexec /qn /norestart /x {BD019D8F-25B9-49D6-B301-07AFF65E35DD}
start /wait msiexec /qn /norestart /x {4989DD05-86FB-4CA2-96C5-923DFAD89DA3}
start /wait msiexec /qn /norestart /x {55D8D1AB-94C2-498F-A165-608B834A30EA}
start /wait msiexec /qn /norestart /x {274E6D9A-7CCD-4D67-9660-639486F466B2}
start /wait msiexec /qn /norestart /x {92AB9371-D327-4D56-9BDD-B38A671A631D}
start /wait msiexec /qn /norestart /x {32A4CF00-9FAC-47c8-9B37-91CC23815D64}
start /wait msiexec /qn /norestart /x {6357D25F-A9C9-4CC7-A1FB-0DCF344E7C40}
start /wait msiexec /qn /norestart /x {1F670068-9589-4DC7-8FE4-1D0D13AF2526}
start /wait msiexec /qn /norestart /x {E1AE0CB7-1333-4728-8520-CB3F88A252B4}

:: HP Photosmart
start /wait msiexec /qn /norestart /x {4E484899-4F93-4086-88BA-56BDDF47A776}
start /wait msiexec /qn /norestart /x {582BA1F1-FAB4-41AD-A5E3-4A9535343461}
start /wait msiexec /qn /norestart /x {BB3447F6-9553-4AA9-960E-0DB5310C5779}
start /wait msiexec /qn /norestart /x {FE651900-D014-482F-AEBC-2928F57D1FB0}

:: HP Picasso Media Center Add-In
start /wait msiexec /qn /norestart /x {55979C41-7D6A-49CC-B591-64AC1BBE2C8B}

:: HP MarketResearch
start /wait msiexec /qn /norestart /x {95D08F4E-DFC2-4ce3-ACB7-8C8E206217E9}
start /wait msiexec /qn /norestart /x {D360FA88-17C8-4F14-B67F-13AAF9607B12}

:: HP MediaSmart Internet TV
start /wait msiexec /qn /norestart /x {E553760D-D7F7-48BF-BD8B-C7E23BA04CB5}

:: HP MediaSmart Movies and TV
start /wait msiexec /qn /norestart /x {4B4E2FA2-3B1E-4147-99DB-5033981D8C2F}

:: HP MediaSmart Music
start /wait msiexec /qn /norestart /x {91A34181-9FAD-43AB-A35F-E7A8945B7E1C}

:: HP MediaSmart SmartMenu
start /wait msiexec /qn /norestart /x {5A5F45AE-0250-4C34-9D89-F10BDDEE665F}
start /wait msiexec /qn /norestart /x {A3B64280-DE4C-40F0-86BB-CCB2A6056BA2}
start /wait msiexec /qn /norestart /x {88E60521-1E4E-4785-B9F1-1798A4BD0C30}
start /wait msiexec /qn /norestart /x {9DEF9686-CCB2-47B7-BF83-B49EA21FA016}
start /wait msiexec /qn /norestart /x {731A1D36-BF17-4C76-B7E7-CC055AF8C54E}

:: HP MediaSmart DVD
start /wait msiexec /qn /norestart /x {DCCAD079-F92C-44DA-B258-624FC6517A5A}

:: HP MediaSmart/TouchSmart Netflix (various versions)
start /wait msiexec /qn /norestart /x {34FF930E-DBF9-4858-BAB5-BAC957BF616E}
start /wait msiexec /qn /norestart /x {2D5E3D2B-919F-407C-8757-E64827518BB6}
start /wait msiexec /qn /norestart /x {BB1C717E-376C-4AA1-8940-81BFC38D9778}

:: HP MyRoom 10.0.0274
start /wait msiexec /qn /norestart /x {BB760C1D-98F4-4E38-8CC4-3B67329AA981}
start /wait msiexec /qn /norestart /x {9B9B8EE4-2EDB-41C2-AF2E-63E75D37CDDF}

:: HPProductAssistant (shows up as Network, hidden)
start /wait msiexec /qn /norestart /x {7910018D-02CF-4410-A7E5-CF5C10D05B7F}
start /wait msiexec /qn /norestart /x {8A27C0FE-87C7-4169-BF5A-05BF94F70A54}
start /wait msiexec /qn /norestart /x {21706D5B-A09C-42F1-95B5-CBDFE20F9852}

:: HP Product Improvement Study
start /wait msiexec /qn /norestart /x {446CCB22-B632-4A1D-BF84-DA8DB0575F98}
start /wait msiexec /qn /norestart /x {C927FC7E-4061-44AC-BE09-496AF6BAC131}
start /wait msiexec /qn /norestart /x {4B3264AA-951A-4A6B-B837-125224261F12}
start /wait msiexec /qn /norestart /x {791D3241-C6A4-417F-82E6-00543B6E5012}

:: HP Privacy Manager for HP ProtectTools
start /wait msiexec /qn /norestart /x {D69F9215-B06A-4ADF-A464-E2607B2FA296}

:: HP Quick Launch
start /wait msiexec /qn /norestart /x {10F539B1-31AF-43BF-9F0C-0EB66E918922}

:: HP QuickWeb Installer
start /wait msiexec /qn /norestart /x {394FA67A-FF0A-4356-BB77-D85E5A300BDE}

:: HP Setup
start /wait msiexec /qn /norestart /x {E2831862-F131-4327-B9CC-FA30F587EB6C}

:: HP Tone Control
start /wait msiexec /qn /norestart /x {9207D4A1-586E-49CA-A002-FC9F475AB1A3}

:: HP Odometer 2.10.0000
start /wait msiexec /qn /norestart /x {B899AE89-9B09-4F11-B299-A1209CAB8D00}

:: HP On Screen Display (various versions)
start /wait msiexec /qn /norestart /x {9ADABDDE-9644-461B-9E73-83FA3EFCAB50}
start /wait msiexec /qn /norestart /x {D734D743-2385-46ED-9B3E-168A24A9E1A9}
start /wait msiexec /qn /norestart /x {EC8D12E4-A73C-4C27-B1C7-E9683052E556}

:: HP PageLift
start /wait msiexec /qn /norestart /x {708ABF62-5D7A-4550-823A-1F9EFA63645A}
start /wait msiexec /qn /norestart /x {7059BDA7-E1DB-442C-B7A1-6144596720A4}
start /wait msiexec /qn /norestart /x {274A948D-DD41-4B8F-B66F-0F4AD233200F}

:: HPPhotoGadget
start /wait msiexec /qn /norestart /x {CAE4213F-F797-439D-BD9E-79B71D115BE3}

:: HPPhotoSmartDiscLabelContent1, DiscLabel_PrintOnDisc, disclabelplugin, DiscLabel_PaperLabel
start /wait msiexec /qn /norestart /x {681B698F-C997-42C3-B184-B489C6CA24C9}
start /wait msiexec /qn /norestart /x {20EFC9AA-BBC1-4DFD-81FF-99654F71CBF8}
start /wait msiexec /qn /norestart /x {B28635AB-1DF3-4F07-BFEA-975D911B549B}
start /wait msiexec /qn /norestart /x {D9D8F2CF-FE2D-4644-9762-01F916FE90A9}

:: HP Photosmart Essential
start /wait msiexec /qn /norestart /x {EB21A812-671B-4D08-B974-2A347F0D8F70}
start /wait msiexec /qn /norestart /x {D79113E7-274C-470B-BD46-01B10219DF6A}
start /wait msiexec /qn /norestart /x {BAC712C6-4061-4C9F-AB58-A5C53E76704A}

:: HP Product Assistant
start /wait msiexec /qn /norestart /x {150B6201-E9E6-4DFB-960E-CCBD53FBDDED}
start /wait msiexec /qn /norestart /x {67D3F1A0-A1F2-49b7-B9EE-011277B170CD}
start /wait msiexec /qn /norestart /x {36FDBE6E-6684-462b-AE98-9A39A1B200CC}
start /wait msiexec /qn /norestart /x {9D1B99B7-DAD8-440d-B4FB-1915332FBCC2}
start /wait msiexec /qn /norestart /x {C75CDBA2-3C86-481e-BD10-BDDA758F9DFF}
start /wait msiexec /qn /norestart /x {83F51BBA-48BE-4BB6-B96A-F4AAE4C462F9}

:: HP Product Detection
start /wait msiexec /qn /norestart /x {A436F67F-687E-4736-BD2B-537121A804CF}

:: HP Product Documentation Launcher // Product_SF_Min_QFolder // ProductContext
start /wait msiexec /qn /norestart /x {710F7B0F-A679-4314-8E69-E868B660FAEA}
start /wait msiexec /qn /norestart /x {89CEAE14-DD0F-448E-9554-15781EC9DB24}
start /wait msiexec /qn /norestart /x {414C803A-6115-4DB6-BD4E-FD81EA6BC71C}
start /wait msiexec /qn /norestart /x {5962ABC1-427C-4651-B6FC-187A9F653AEF}
start /wait msiexec /qn /norestart /x {6E4EE9B5-F69D-4455-B430-40FA5F0DC988}

:: HP Product Improvement Study (various versions)
start /wait msiexec /qn /norestart /x {E3D43596-7E26-479E-B718-77CB3D9270F6}
start /wait msiexec /qn /norestart /x {A90F92B7-3C3F-4AEF-B281-31DD17BB73CA}
start /wait msiexec /qn /norestart /x {37839D69-6DA4-4125-B33A-30DE86345DF4}
start /wait msiexec /qn /norestart /x {FEB2C4AA-661E-483F-9626-21A8ACFD10F2}
start /wait msiexec /qn /norestart /x {D2064264-3162-4DB1-AFE0-167BEFBBCD9C}
start /wait msiexec /qn /norestart /x {32797608-0840-4645-BE1B-37AFFB18908A}
start /wait msiexec /qn /norestart /x {988D55BB-08DE-43C9-8D16-3751361E2A79}

:: HP PostScript Converter
start /wait msiexec /qn /norestart /x {6E14E6D6-3175-4E1A-B934-CAB5A86367CD}

:: HP Power Assistant
start /wait msiexec /qn /norestart /x {3C33FD2E-6B21-4CD3-B41A-A7331D467617}

:: HP Power Data
start /wait msiexec /qn /norestart /x {42DBA167-C25D-49CE-BBAF-DEC25E737DA8}

:: HP Power Manager
start /wait msiexec /qn /norestart /x {8704FEEF-A6A8-4E7E-B124-BD6122C66E2C}
start /wait msiexec /qn /norestart /x {E35A3B13-78CD-4967-8AC8-AA9FDA693EDE}
start /wait msiexec /qn /norestart /x {D8BCE5B9-67CF-4F3F-93AE-3ACC754C72EB}

:: HP Product Detection
start /wait msiexec /qn /norestart /x {A436F67F-687E-4736-BD2B-537121A804CF}
start /wait msiexec /qn /norestart /x {424CECC6-CEB1-4A5F-9A42-ADE64F035DEB}

:: HP ProtectTools GUIDs. Too many to list, Google each GUID for more information
start /wait msiexec /qn /norestart /x {A40F60B1-F1E1-452E-96A5-FF97F9A2D102}
start /wait msiexec /qn /norestart /x {EEAFE1E5-076B-430A-96D9-B567792AFA88}
start /wait msiexec /qn /norestart /x {EEEB604C-C1A7-4f8c-B03F-56F9C1C9C45F}
start /wait msiexec /qn /norestart /x {6F8071B2-5ECA-4A71-8E5D-7E2FE8174559}
start /wait msiexec /qn /norestart /x {1868D30B-72C7-41E8-9657-69C5DFE1C768}
start /wait msiexec /qn /norestart /x {9D380C34-58B7-4FF9-9DB8-05685AAD93D4}
start /wait msiexec /qn /norestart /x {3E9BC837-E48E-4964-AFFD-7AB40EBA5C50}
start /wait msiexec /qn /norestart /x {71EE298A-7B6D-4303-8438-C3E50567DA1F}
start /wait msiexec /qn /norestart /x {3F728815-C7E8-40EA-8D1A-F7B8E2382325}
start /wait msiexec /qn /norestart /x {D5D422B9-6976-4E98-8DDF-9632CB515D7E}
start /wait msiexec /qn /norestart /x {6D4839CB-28B4-4070-8CA7-612CA92CA3D0}
start /wait msiexec /qn /norestart /x {29AB47F0-C5A3-401F-8A84-3324F2DC8E46}
start /wait msiexec /qn /norestart /x {B0781FBD-8AD6-4658-A031-9815E1AC5047}
start /wait msiexec /qn /norestart /x {55B30AF2-7331-4436-9318-D9EA45A42F79}
start /wait msiexec /qn /norestart /x {B004600E-4A10-448B-8CDD-4ADB25A24042}

:: hp psc 1200 series 1.10.0000
start /wait msiexec /qn /norestart /x {C88F84E5-AE23-44BD-922C-2ABEACACAF7A}

:: HP Quick Launch and Quick Start (various versions)
start /wait msiexec /qn /norestart /x {E92D47A1-D27D-430A-8368-0BAFD956507D}
start /wait msiexec /qn /norestart /x {BAD0FA60-09CF-4411-AE6A-C2844C8812FA}
start /wait msiexec /qn /norestart /x {2856A1C2-70C5-4EC3-AFF7-E5B51E5530A2}
start /wait msiexec /qn /norestart /x {E4A80DC6-8475-4AD9-9952-5E4437889563}
start /wait msiexec /qn /norestart /x {6B7AB1ED-B64E-4545-A8E7-F9E071E12B6F}
start /wait msiexec /qn /norestart /x {566BB063-0E28-4273-A748-690BE86A7E26}
start /wait msiexec /qn /norestart /x {53B17A98-5BF0-40BC-AAFF-850A357975AC}

:: HP QuickLook
start /wait msiexec /qn /norestart /x {24795E98-3D9E-4661-BA6F-BC6A4FB820CE}

:: HP QuickTransfer
start /wait msiexec /qn /norestart /x {E7004147-2CCA-431C-AA05-2AB166B9785D}
start /wait msiexec /qn /norestart /x {E517094C-06B6-419F-8FFD-EF4F57972130}

:: HP QuickWeb
start /wait msiexec /qn /norestart /x {BB4FC2AD-DF12-4EE1-8AA7-2C0A26B5E2FB}
start /wait msiexec /qn /norestart /x {7861911B-4270-498A-8F7A-FCF0570F4877}
start /wait msiexec /qn /norestart /x {8B52057C-15DB-433E-957C-E279BC7D07E3}

:: HP Recovery Manager
start /wait msiexec /qn /norestart /x {528AB81B-D65A-4AB0-A2B6-82B51A087D01}
start /wait msiexec /qn /norestart /x {64BAA990-F1FC-4145-A7B1-E41FBBC9DA47}
start /wait msiexec /qn /norestart /x {D817481A-193E-4332-A4F3-E19132F744F0}
start /wait msiexec /qn /norestart /x {6369FC9E-FC8D-493F-AD87-D51FAB492705}
start /wait msiexec /qn /norestart /x {DB97D0DE-0AA1-413C-8398-92C7FA3F4A67}
start /wait msiexec /qn /norestart /x {4F46FDB9-B906-47BF-B3D5-C62E01B3C5EE}
start /wait msiexec /qn /norestart /x {98C4DE92-27C8-482C-8431-514828756E80}

:: HP Registration Service
start /wait msiexec /qn /norestart /x {D1E8F2D7-7794-4245-B286-87ED86C1893C}
start /wait msiexec /qn /norestart /x {C0C9A493-51CB-4F3F-A296-5B5E410C338E}
start /wait msiexec /qn /norestart /x {D1E7D876-6B86-4B35-A93D-15B0D6C43EAF}
start /wait msiexec /qn /norestart /x {C2E428EB-116E-41C0-9E84-B22DE9CCA42F}

:: HP Remote Solution
start /wait msiexec /qn /norestart /x {C611CF88-969D-43E6-A877-D6D6439DD081}

:: HP Rescue and Recovery
start /wait msiexec /qn /norestart /x {C81D8576-F1B1-4E3A-9DC3-DF1B664962F0}

:: HP Setup
start /wait msiexec /qn /norestart /x {438363A8-F486-4C37-834C-4955773CB3D3}
start /wait msiexec /qn /norestart /x {F5E7D9AF-60F6-4A30-87E3-4EA94D322CE1}
start /wait msiexec /qn /norestart /x {5036764A-435D-40C9-869C-31085A3D741D}

:: HP SimplePass // Disabled by /u/kamakaze_chickn for Tron; "fingerprint reader driver and can produce an error code in DevMan if missing"
::start /wait msiexec /qn /norestart /x {314FAD12-F785-4471-BCE8-AB506642B9A1}
::start /wait msiexec /qn /norestart /x {F1390872-2500-4408-A46C-CD16C960C661}
::start /wait msiexec /qn /norestart /x {BBEB46E1-810D-449F-A9C5-4D60F3BF187D}
::start /wait msiexec /qn /norestart /x {30E20E5D-5E4E-4874-A35A-952DB3582C29}

:: HP Security Assistant 3.0.4
start /wait msiexec /qn /norestart /x {ED1BD69A-07E3-418C-91F1-D856582581BF}

:: HP Setup 9.1.15453.4066
start /wait msiexec /qn /norestart /x {42D10994-A566-495D-A5E7-D0C6B5C6B35C}

:: HP Setup Manager 1.1.13253.3682
start /wait msiexec /qn /norestart /x {AE2F1669-5B1F-47C5-B639-78D74DD0BCE4}

:: HP Shop for Supplies (HPSSupply)
start /wait msiexec /qn /norestart /x {AC35A885-0F8F-4857-B7DA-6E8DFB43E6B3}

:: HP SmartWebPrinting
start /wait msiexec /qn /norestart /x {8FF6F5CA-4E30-4E3B-B951-204CAAA2716A}
start /wait msiexec /qn /norestart /x {DC635845-46D3-404B-BCB1-FC4A91091AFA}

:: HP Status Alerts
start /wait msiexec /qn /norestart /x {9D1DE902-8058-4555-A16A-FBFAA49587DB}

:: HP SoftPaq Download Manager
start /wait msiexec /qn /norestart /x {3F019647-AC80-4859-B023-42D9DA71953F}
start /wait msiexec /qn /norestart /x {5B4F3B85-83F0-4BBF-9052-7A38B6B09634}
start /wait msiexec /qn /norestart /x {46235FF7-2CBE-4A84-BEDA-87348D1F7850}
start /wait msiexec /qn /norestart /x {20D6301E-0A14-4238-841D-45ECA567DB69}
start /wait msiexec /qn /norestart /x {FC3C2B77-6800-48C6-A15D-9D1031130C16}
start /wait msiexec /qn /norestart /x {34C821CA-6B55-44A0-8A9B-2EF471D6019E}
start /wait msiexec /qn /norestart /x {6821D775-9303-46DD-977A-2D97CA18B054}
start /wait msiexec /qn /norestart /x {2DA697D7-FED3-4DE2-A174-92A2A12F9688}

:: HP Software Framework
start /wait msiexec /qn /norestart /x {B6F5C6D8-C443-4B55-932F-AE11B5743FC4}
start /wait msiexec /qn /norestart /x {285F722C-0E45-47DE-B38E-5B3B10FA4A7C}
start /wait msiexec /qn /norestart /x {95EEB814-D454-4176-A6B5-D708CB48064F}
start /wait msiexec /qn /norestart /x {6663B59B-E9CE-44CA-8654-7BE9060D653D}
start /wait msiexec /qn /norestart /x {DAE3B13B-5097-4EAE-BC26-C463377BD80E}
start /wait msiexec /qn /norestart /x {DA200FDD-DE3D-4958-8465-C4FBC869544B}

:: HP Software Setup
start /wait msiexec /qn /norestart /x {B1AFAD6F-9192-421F-9DFF-60A59571366B}
start /wait msiexec /qn /norestart /x {65514800-1E09-48D6-B520-3DC70572E891}
start /wait msiexec /qn /norestart /x {D160035A-CFF0-49C6-BE19-B9EFDE4AEBF2}
start /wait msiexec /qn /norestart /x {7ED7BF91-D145-480A-B206-6891576F6935}
start /wait msiexec /qn /norestart /x {B1A4A13D-4665-4ED3-9DFE-F845725FBBD8}
start /wait msiexec /qn /norestart /x {741CFE3A-1C0B-4A7D-8E08-5D78C911C09D}
start /wait msiexec /qn /norestart /x {F4D304D9-7647-4253-957E-44286B8631F4}

:: HP Solution Center
start /wait msiexec /qn /norestart /x {BC5DD87B-0143-4D14-AAE6-97109614DC6B}
start /wait msiexec /qn /norestart /x {A36CD345-625C-4d6c-B3E2-76E1248CB451}


:: HP Support Information
start /wait msiexec /qn /norestart /x {B2B7B1C8-7C8B-476C-BE2C-049731C55992}

:: HP Support Solutions Framework
start /wait msiexec /qn /norestart /x {D7D5F438-26EF-45AB-AB89-C476FBCF8584}
start /wait msiexec /qn /norestart /x {348A1F5B-07B3-4436-9A47-FFE44EFE856E}
start /wait msiexec /qn /norestart /x {55065080-504F-43BB-BE00-36B80D7D39A5}

:: HP System Default Settings
start /wait msiexec /qn /norestart /x {5C90D8CF-F12A-41C6-9007-3B651A1F0D78}
start /wait msiexec /qn /norestart /x {28FE073B-1230-4BF6-830C-7434FD0C0069}
start /wait msiexec /qn /norestart /x {C422BF2C-E570-4D3E-8718-7C641B190DB2}
start /wait msiexec /qn /norestart /x {39011DEC-8956-401E-8369-421D402FFF52}

:: HP System Event Utility
start /wait msiexec /qn /norestart /x {8B4EE87E-6D40-4C91-B5E8-0DC77DC412F1}
start /wait msiexec /qn /norestart /x {D17A3B70-B75E-4C49-83D6-C17DDF65B35F}

:: hpStatusAlerts
start /wait msiexec /qn /norestart /x {7504A7B0-003E-4875-A454-B627E127E9D9}
start /wait msiexec /qn /norestart /x {06CE2B24-EC8C-4847-AF33-098255B5D32D}
start /wait msiexec /qn /norestart /x {44EB02F5-16E5-42BD-9183-C23EF7620CF3}
start /wait msiexec /qn /norestart /x {46A99EAE-98DA-4BE5-94C3-D41BA4C266DA}
start /wait msiexec /qn /norestart /x {B8DBED1E-8BC3-4d08-B94A-F9D7D88E9BBF}
start /wait msiexec /qn /norestart /x {6470E292-3B55-41DC-B5EB-91C34C5ACB5D}
start /wait msiexec /qn /norestart /x {7C960641-0A27-45C6-96F8-BE4E04A4CC2C}
start /wait msiexec /qn /norestart /x {092FCD1C-5203-4BD1-B4F4-0F0C6B237A6A}
start /wait msiexec /qn /norestart /x {0CCFF6E8-B4D1-416F-8198-B223BA8B1991}
start /wait msiexec /qn /norestart /x {25E11B5A-4817-4296-A260-235AE77B1708}
start /wait msiexec /qn /norestart /x {A1EF28FB-74A8-4157-91E9-9C164CAB10F8}
start /wait msiexec /qn /norestart /x {FDEA674C-478D-455F-9894-D6D4CD4BB304}
start /wait msiexec /qn /norestart /x {71677768-D5DA-4785-8A44-2DFFE33CF70A}
start /wait msiexec /qn /norestart /x {9652051B-BC94-4588-A84B-B9B34660FB5E}
start /wait msiexec /qn /norestart /x {456E4C16-227D-48E4-BA3B-52D1B15CB196}

:: HP Theft Recovery
start /wait msiexec /qn /norestart /x {B9A03B7B-E0FF-4FB3-BA83-762E58A1B0AA}
start /wait msiexec /qn /norestart /x {B1CB7E99-4685-45CB-867E-2FB58EDA0A39}
start /wait msiexec /qn /norestart /x {33C9F24B-1D92-4632-A915-81E3BB1D5D6B}

:: HP "Toolbox" (hidden)
start /wait msiexec /qn /norestart /x {A7D99092-CFCA-AF69-9B61-B4A8784B5F8C}
start /wait msiexec /qn /norestart /x {6BBA26E9-AB03-4FE7-831A-3535584CA002}
start /wait msiexec /qn /norestart /x {292F0F52-B62D-4E71-921B-89A682402201}
start /wait msiexec /qn /norestart /x {0F7C2E47-089E-4d23-B9F7-39BE00100776}
start /wait msiexec /qn /norestart /x {AC13BA3A-336B-45a4-B3FE-2D3058A7B533}

:: HP Total Care Advisor
start /wait msiexec /qn /norestart /x {f32502b5-5b64-4882-bf61-77f23edcac4f}
start /wait msiexec /qn /norestart /x {0DDA7620-4F8B-43B3-8828-CA5EE292FA3B}

:: HP TouchSmart Browser, Calendar, Canvas, Clock, Notes, RSS, Tutorials, Twitter and Weather
start /wait msiexec /qn /norestart /x {4127C2C0-0AC7-4947-9CC1-AACBEFC6EC02}
start /wait msiexec /qn /norestart /x {DE77FE3F-A33D-499A-87AD-5FC406617B40}
start /wait msiexec /qn /norestart /x {03D15668-8F54-47C0-BFF2-6F966E4DF052}
start /wait msiexec /qn /norestart /x {84814E6B-2581-46EC-926A-823BD1C670F6}
start /wait msiexec /qn /norestart /x {4EDBB1CC-C418-443B-A0B0-A94DEA1ED8B2}
start /wait msiexec /qn /norestart /x {55C48613-A2DF-4286-9467-E3BCB23CD8F4}
start /wait msiexec /qn /norestart /x {872B1C80-38EC-4A31-A25C-980820593900}
start /wait msiexec /qn /norestart /x {70F9BF10-3729-4333-BCBE-5218F69582FA}
start /wait msiexec /qn /norestart /x {A535F266-291E-447F-ABE6-0BE17D0CB036}
start /wait msiexec /qn /norestart /x {19484EF1-E27A-43D1-9EEB-685D41888AC8}

:: HP TrayApp (various versions)
start /wait msiexec /qn /norestart /x {FF075778-6E50-47ed-991D-3B07FD4E3250}
start /wait msiexec /qn /norestart /x {4D304678-738E-42a0-931A-2B022F49DEB8}
start /wait msiexec /qn /norestart /x {1EC71BFB-01A3-4239-B6AF-B1AE656B15C0}
start /wait msiexec /qn /norestart /x {1B57D761-768E-4FB8-A6BB-057A977A7C81}
start /wait msiexec /qn /norestart /x {5ACE69F0-A3E8-44eb-88C1-0A841E700180}

:: HP Trust Circles
start /wait msiexec /qn /norestart /x {C4E9E8A4-EEC4-4F9E-B140-520A8B75F430}
start /wait msiexec /qn /norestart /x {0DF3F266-B52E-4309-B3CC-233607DF4E50}

:: HP SolutionCenter
start /wait msiexec /qn /norestart /x {9603DE6D-4567-4b78-B941-849322373DE2}
start /wait msiexec /qn /norestart /x {4A70EF07-7F88-4434-BB61-D1DE8AE93DD4}
start /wait msiexec /qn /norestart /x {3C023AD6-4740-479A-8B7A-B5718F240268}
start /wait msiexec /qn /norestart /x {A5AB9D5E-52E2-440e-A3ED-9512E253C81A}

:: HP UnloadSupport (hidden)
start /wait msiexec /qn /norestart /x {E06F04B9-45E6-4AC0-8083-85F7515F40F7}

:: HP Update, various versions
start /wait msiexec /qn /norestart /x {787D1A33-A97B-4245-87C0-7174609A540C}
start /wait msiexec /qn /norestart /x {97486FBE-A3FC-4783-8D55-EA37E9D171CC}
start /wait msiexec /qn /norestart /x {117BBDE7-472E-4DCD-BAAE-410A0794A335}
start /wait msiexec /qn /norestart /x {6FE8E073-D159-4419-93E2-CE2C5B078562}
start /wait msiexec /qn /norestart /x {DCEA910B-3269-4F5B-A915-D59293004751}
start /wait msiexec /qn /norestart /x {AE856388-AFAD-4753-81DF-D96B19D0A17C}
start /wait msiexec /qn /norestart /x {85D645CF-0F3B-477A-A9C9-194917F1A75B}
start /wait msiexec /qn /norestart /x {2EA3D6B2-157E-4112-A3AB-BF17E16661C3}
start /wait msiexec /qn /norestart /x {6ECB39BD-73C2-44DD-B1A0-898207C58D8B}
start /wait msiexec /qn /norestart /x {962CB079-85E6-405F-8704-1C62365AE46F}
start /wait msiexec /qn /norestart /x {904822F1-6C7D-4B91-B936-6A1C0810544C}
start /wait msiexec /qn /norestart /x {8C6027FD-53DC-446D-BB75-CACD7028A134}

:: HP USB Docking Video (wtf?)
start /wait msiexec /qn /norestart /x {B0069CFA-5BB9-4C03-B1C6-89CE290E5AFE}

:: HP UserGuide, UserProfileManager SDK Snap-in
start /wait msiexec /qn /norestart /x {C23415D8-FE94-4F52-B5C4-0FFA2202C6D9}
start /wait msiexec /qn /norestart /x {F07C2CF8-4C53-4EC3-8162-A6221E36EB88}
start /wait msiexec /qn /norestart /x {8D4B1DDC-0CB5-4908-B740-A385C2F3B6A9}

:: HP Utility Center
start /wait msiexec /qn /norestart /x {B7B82520-8ECE-4743-BFD7-93B16C64B277}
start /wait msiexec /qn /norestart /x {35021DFB-F9CA-402A-89A2-47F91E506465}

:: HP Vision Hardware Diagnostics
start /wait msiexec /qn /norestart /x {D7670221-BF9B-4DFF-B26B-5BE55A87329F}

:: HP Wallpaper 3.0.0.1
start /wait msiexec /qn /norestart /x {11B83AD3-7A46-4C2E-A568-9505981D4C6F}

:: HP Web Camera
start /wait msiexec /qn /norestart /x {C6363DC5-17A4-4E36-B701-9EC719390D48}
start /wait msiexec /qn /norestart /x {C7AE4EC3-9C13-4213-8457-74D16B353F91}

:: HP WebReg
start /wait msiexec /qn /norestart /x {179C56A4-F57F-4561-8BBF-F911D26EB435}
start /wait msiexec /qn /norestart /x {8EE94FD8-5F52-4463-A340-185D16328158}
start /wait msiexec /qn /norestart /x {350C97B0-3D7C-4EE8-BAA9-00BCB3D54227}
start /wait msiexec /qn /norestart /x {29FA38B4-0AE4-4D0D-8A51-6165BB990BB0}
start /wait msiexec /qn /norestart /x {43CDF946-F5D9-4292-B006-BA0D92013021}
start /wait msiexec /qn /norestart /x {087A66B8-1F0F-4a8d-A649-0CFE276AA7C0}
start /wait msiexec /qn /norestart /x {06C4BA69-5210-4707-B5BE-E26D487E1854}
start /wait msiexec /qn /norestart /x {14CF9AF8-10A6-4FA7-9E57-D22DBD644C77}

:: HP Wireless Assistant // Wireless Button Driver // Wireless Hotspot
start /wait msiexec /qn /norestart /x {9AB1B6EC-AEA4-4D78-ADDB-0291BF7230F4}
start /wait msiexec /qn /norestart /x {547607B0-3294-4ECA-8F5E-921404676CBB}
start /wait msiexec /qn /norestart /x {13133E99-B0D5-4143-B832-AAD55C62A41C}
start /wait msiexec /qn /norestart /x {92F7E378-0F27-4D1E-ACAE-2AA7E546D082}
start /wait msiexec /qn /norestart /x {3082CB96-66E8-456D-8326-118A4F5DC0C6}
start /wait msiexec /qn /norestart /x {CFD917BE-F1F6-410E-ABEC-9EC819507D0D}
start /wait msiexec /qn /norestart /x {5601F151-A69F-4E30-8C60-37928124CD07}
start /wait msiexec /qn /norestart /x {EC720706-3F19-4B7F-BDDD-E31D9B3921D2}

:: HP Wolf Security
start /wait msiexec /qn /norestart /x {3F5C3ADE-01FF-11EC-A0D9-3863BB3CB5A8}



goto END

:END
exit