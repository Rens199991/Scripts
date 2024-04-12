#Create a tag file just so Intune knows this was installed
If(-not(Test-Path -Path "$($env:ProgramData)\CXN\Scripts\CreateRDPShortcutToDesktop"))
    {
    New-Item -itemtype "directory" -path "$($env:ProgramData)\CXN\Scripts\CreateRDPShortcutToDesktop"
    Set-Content -Path "$($env:ProgramData)\CXN\Scripts\CreateRDPShortcutToDesktop\CreateRDPShortcutToDesktop.ps1.tag" -Value "Installed"
    }

#info over special folders in powershell: https://www.devguru.com/content/technologies/wsh/wshshell-specialfolders.html

$new_object = New-Object -ComObject WScript.Shell

#Hier de naam aanpassen van rdp file bij test.rdp

$destination = $new_object.SpecialFolders.Item("AllUsersDesktop") + "\test.rdp"
New-Item $destination

#Hieronder kunnen we de properties van de RDP bepalen, om de eigenschappen van een bestaande RDP te achterhalen kunnen we de RDP opendoen in Notepad
# Belangrijk, de tick moet na $Destinatinon komen, niet eronder!!!!

Set-Content $destination 'redirectclipboard:i:1
redirectprinters:i:0
redirectcomports:i:0
redirectsmartcards:i:1
devicestoredirect:s:*
drivestoredirect:s:*
redirectdrives:i:1
session bpp:i:32
prompt for credentials on client:i:1
server port:i:3389
allow font smoothing:i:1
promptcredentialonce:i:1
videoplaybackmode:i:1
audiocapturemode:i:1
gatewayusagemethod:i:2
gatewayprofileusagemethod:i:1
gatewaycredentialssource:i:0
full address:s:BEKABEBRGW01.BEKA-COOKWARE.COM
gatewayhostname:s:rdsgw.beka-cookware.com:9443
workspace id:s:BEKABEBRGW01.beka-cookware.com
use redirection server name:i:1
loadbalanceinfo:s:tsv://MS Terminal Services Plugin.1.RemoteDesktop
use multimon:i:0
alternate full address:s:BEKABEBRGW01.BEKA-COOKWARE.COM
signscope:s:Full Address,Alternate Full Address,Use Redirection Server Name,Server Port,GatewayHostname,GatewayUsageMethod,GatewayProfileUsageMethod,GatewayCredentialsSource,PromptCredentialOnce,RedirectDrives,RedirectPrinters,RedirectCOMPorts,RedirectSmartCards,RedirectClipboard,DevicesToRedirect,DrivesToRedirect,LoadBalanceInfo
signature:s:AQABAAEAAAA9GAAAMIIYOQYJKoZIhvcNAQcCoIIYKjCCGCYCAQExDzANBglghkgB  ZQMEAgEFADALBgkqhkiG9w0BBwGgghYsMIIEMjCCAxqgAwIBAgIBATANBgkqhkiG  9w0BAQUFADB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz  dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRl  ZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTA0MDEwMTAw  MDAwMFoXDTI4MTIzMTIzNTk1OVowezELMAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdy  ZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBwwHU2FsZm9yZDEaMBgGA1UECgwRQ29t  b2RvIENBIExpbWl0ZWQxITAfBgNVBAMMGEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNl  czCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL5AnfRu4ep2hxxNRUSO  vkbIgwadwSr+GB+O5AL686tdUIoWMQuaBtDFcCLNSS1UY8y2bmhGC1Pqy0wkwLxy  TurxFa70VJoSCsN6sjNg4tqJVfMiWPPe3M/vg4aijJRPn2jymJBGhCfHdr/jzDUs  i14HZGWCwEiwqJH5YZ92IFCokcdmtet4YgNW8IoaE+oxox6gmf049vYnMlhvB/Vr  uPsUK6+3qszWY19zjNoFmag4qMsXeDZRrOme9Hg6jc8P2ULimAyrL58OAd7vn5lJ  8S3frHRNG5i1R8XlKdH5kBjHYpy+g8cmez6KJcfA3Z3mNWgQIJ2P2N7Sw4ScDV7o  L8kCAwEAAaOBwDCBvTAdBgNVHQ4EFgQUoBEKIz6W8Qfs4q8p74Klf9AwpLQwDgYD  VR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wewYDVR0fBHQwcjA4oDagNIYy  aHR0cDovL2NybC5jb21vZG9jYS5jb20vQUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5j  cmwwNqA0oDKGMGh0dHA6Ly9jcmwuY29tb2RvLm5ldC9BQUFDZXJ0aWZpY2F0ZVNl  cnZpY2VzLmNybDANBgkqhkiG9w0BAQUFAAOCAQEACFb8AvCb6P+k+tZ7xkSAzk/E  xfYAWMymtrwUSWgEdujm7l3sAg9g1o1QGE8mTgHj5rCl7r+8dFRBv/38ErjHT1r0  iWAFf2C3BUrz9vHCv8S5dIa2LX1rzNLzRt0vxuBqw8M0Ayx9lt1awg6nCpnBBYur  DC/zXDrPbDdVCYfeU0BsWO/8tqtlbgT2G9w84FoVxp7Z8VlIMCFlA2zs6SFz7JsD  oeA3raAVGI/6ugLOpyypEBMs1OUIJqsil2D4kF501KKaU73yqWjgom7C12yxow+e  v+to51byrvLjKzg6CYG1a4XXvi3tPxq3smPi9WIsgtRqAEFQ8TmDn5XpNpaYbjCC  BYEwggRpoAMCAQICEDlyRDr5IrdR19NsEN0xNZUwDQYJKoZIhvcNAQEMBQAwezEL  MAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE  BwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNVBAMM  GEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczAeFw0xOTAzMTIwMDAwMDBaFw0yODEy  MzEyMzU5NTlaMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU  MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0  d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhv  cml0eTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAIASZRc2DsPbCLPQ  rFcNdu3NJ9NMrVCDYeKqIE0JLWQJ3M6Jn8w9qez2z8Hc8dOx1ns3KBErR9o5xrw6  GbRfpr19naNjQrZ28qk7K5H44m/Q7BYgkAk+4uh0yRi0kdRiZNt/owbxiBhqkCI8  vP4T8IcUe/bkH47U5FHGEWdGCFHLhhRUP7wz/n5snP8WnRi9UY41pqdmyHJn2yFm  sdSbeAPAUDrozPDcvJ5M/q8FljUfV1q3/875PbcstvZU3cjnEjpNrkyKt1yatLcg  Pcp/IjSufjtoZgFE5wFORlObM2D3lL5TN5BzQ/Myw1Pv26r+dE5px2uMYJPexMcM  3+EyrsyTO1F4lWeL7j1W/gzQaQ8bD/MlJmszbfduR/pzQ+V+DqVmsSl8MoRjVYnE  DcGTVDAZE6zTfTen6106bDVc20HXEtqpSQvf2ICKCZNijrVmzyWIzYS4sT+kOQ/Z  Ap7rEkyVfPNrBaleFoPMuGfi6BOdzFuC00yz7Vv/3uVzrCM7LQC/NVV0CUnYSVga  f5I25lGSDvMmfRxNF7zJ7EMm0L9BX0CpRET0medXh55QH1dUqD79dGMvsVBlCeZY  Qi5DGky08CVHWfoEHpPUJkZKUIGy3r54t/xnFeHJV4QeD2PW6WK61l9VLupcxigI  BCU5uA4rqfJMlxwHPw1S9e3vL4IPAgMBAAGjgfIwge8wHwYDVR0jBBgwFoAUoBEK  Iz6W8Qfs4q8p74Klf9AwpLQwHQYDVR0OBBYEFFN5v1qqK0rPVIDh2JvAnfKyA2bL  MA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MBEGA1UdIAQKMAgwBgYE  VR0gADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9B  QUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDA0BggrBgEFBQcBAQQoMCYwJAYIKwYB  BQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOC  AQEAGIdR3HQhPZyK4Ce3M9AuzOzw5steEd4ib5t1jp5y/uTW/qofnJYt7wNKfq70  jW9yPEM7wD/ruN9cqqnGrvL82O6je0P2hjZ8FODN9Pc//t64tIrwkZb+/UNkfv3M  0gGhfX34GRnJQisTv1iLuqSiZgR2iJFODIkUzqJNyTKzuugUGrxx8VvwQQuYAAoi  AxDlDLH5zZI3Ge078eQ6tvlFEyZ1r7uq7z97dzvSxAKRPRkA0xdcOds/exgNRc2T  hZYvXd9ZFk8/Ub3VRRg/7UqO6AZhdCMWtQ1QcydER38QXYkqa4UxFMToqWpMgLxq  eM+4f452cpkMnf7XkQgWoaNflTCCBhMwggP7oAMCAQICEH1bUSa0droR23QWC7xT  DacwDQYJKoZIhvcNAQEMBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg  SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJU  UlVTVCBOZXR3b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRp  b24gQXV0aG9yaXR5MB4XDTE4MTEwMjAwMDAwMFoXDTMwMTIzMTIzNTk1OVowgY8x  CzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV  BAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE3MDUGA1UEAxMu  U2VjdGlnbyBSU0EgRG9tYWluIFZhbGlkYXRpb24gU2VjdXJlIFNlcnZlciBDQTCC  ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANZzM9bXPCDQANIXRbjWPgei  P8dB7jIwybBs/fSfyxKYDy0/jU0BDIIPF39iLum4SHn7FoNOrdcyJZO3B7+5UD+p  TMNAKuk5/9mByh8WMkHagCa5I3qHIB7j/yCaPJVEb4d1BpBAtDKTFgkQCCM+0t2H  D29dURRqCmnFTwFyac/Tk0xtBKCjG4J+sZq57cWexTd4n5oINPtWLljECQ4GZFu8  N9zxnyhoqFawkqNcn7uImAgbJB2rMIWur7AunnqdwcBCHOIC8OrgStLvkA60wUAW  8G+FQkpk96QwoP6/LqMnWo6LWLitwxkXhGPtb1b9g8tgNMR0vuad2+Hk5coMXxUC  AwEAAaOCAW4wggFqMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G  A1UdDgQWBBSNjF7EVK2K4Xfpm/mbBeG4AY1h4TAOBgNVHQ8BAf8EBAMCAYYwEgYD  VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIw  GwYDVR0gBBQwEjAGBgRVHSAAMAgGBmeBDAECATBQBgNVHR8ESTBHMEWgQ6BBhj9o  dHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNhdGlv  bkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNodHRw  Oi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5jcnQw  JQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcN  AQEMBQADggIBADK/Yb0OSMNPx7pHTficeBkB3BMdgG/8w3C0UpoxM5pXUvsxnmuk  71SqiY1AF2j4ERB80sqx8VWGx+6zNpGG9jlRv0a/D6C6tPd+ScQqNhee5Gg5eq+U  TlZvsns7vwqGvc3FdxwDuDixoh9fftuK3EZItmgKz7K1tOI05GepOGYJXtK4/J0o  OhdAJ8JyTin9ITx8zxP7lizFMUT9E+3Vm6lpaHd87uH/pPk2OAhTOaKENJwZ874O  rNUkN+sjqHjQ0+fvkkdkYjki78b3Eb4ihcZmRCQmjhAyjciTrgeegz4v2fn1Ro5j  vsHmtNymzSGohgqV2S6FJhr9/LG2V0JtldEz9jkUBoJBOPWPWNyAW6TVfZV4/aeb  //3FqGmrJuenpAWHW6m3uKMgC5epRYXds4vliTeOKQ38Bhf2OEAOQuQSBvt788YR  aGLf45j0E9gVT4uxadkQYLxkKuoxt+S1ozoUmybjC3v9Ao62mcE4l1k29qh0ooa2  XuvGZOrPoKP5bp66LRG2hpgIWC3JrCVk8l51tDjBrn9aRoPqUcq28ZkRNWulanvG  ALDn+L5ksq3IwvGs41HqpJPgecjhgUDJClvhEjzBYCrjl8CJQsqUz0aYEmm7mNDC  0w1yS0du5ZPEMihjh0PksDI+CtNLvyObFClBK5oEH5Mt8cc5SDytWhJ/MIIGVjCC  BT6gAwIBAgIRAN6PxK5DBuxwd22SKj0giXMwDQYJKoZIhvcNAQELBQAwgY8xCzAJ  BgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcT  B1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE3MDUGA1UEAxMuU2Vj  dGlnbyBSU0EgRG9tYWluIFZhbGlkYXRpb24gU2VjdXJlIFNlcnZlciBDQTAeFw0y  MDA1MTgwMDAwMDBaFw0yMjA1MTkyMzU5NTlaMCIxIDAeBgNVBAMTF3Jkc2d3LmJl  a2EtY29va3dhcmUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA  t9Wik4s5i9fDb+49n4ONB9ovGIiFynXE+YBIxIuU4vYFD8PMHzB2I+CsQaCWq3k1  RB56OuAtMi9NGws/8f8g4Vy7LND5t/foBWsdjdWk1gH3HsN+YJhD1NuaHqH/NSxX  eCWB7gSDfxiUTXC4LXdTA2vPCiZvTAhXC1vXGMHSFeVyBuaY9KZEv2lINN4PEU98  bbOYtGHTnVNzYdk54usafmVR9ltwAPwKerfRicKC4MDU+b7cwYFncs9Id6NZAMfO  iOGihB869QwLQ7AqhLSwWPcDcf+7fKqZcWustoozKY+fzUQ2j3FAesoVS8Nkx/9G  fYio6OvF3Lls9AEqFlXwjQIDAQABo4IDFzCCAxMwHwYDVR0jBBgwFoAUjYxexFSt  iuF36Zv5mwXhuAGNYeEwHQYDVR0OBBYEFBhe80EctCTomYrY9nq1G+jdYME4MA4G  A1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMB  BggrBgEFBQcDAjBJBgNVHSAEQjBAMDQGCysGAQQBsjEBAgIHMCUwIwYIKwYBBQUH  AgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMAgGBmeBDAECATCBhAYIKwYBBQUH  AQEEeDB2ME8GCCsGAQUFBzAChkNodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3Rp  Z29SU0FEb21haW5WYWxpZGF0aW9uU2VjdXJlU2VydmVyQ0EuY3J0MCMGCCsGAQUF  BzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTA/BgNVHREEODA2ghdyZHNndy5i  ZWthLWNvb2t3YXJlLmNvbYIbd3d3LnJkc2d3LmJla2EtY29va3dhcmUuY29tMIIB  fwYKKwYBBAHWeQIEAgSCAW8EggFrAWkAdwBGpVXrdfqRIDC1oolp9PN9ESxBdL79  SbiFq/L8cP5tRwAAAXImqkZDAAAEAwBIMEYCIQCRDwBwJIfIJ2gWexcdGh3sApvN  aGHYpNi2zzBNL3o9tAIhALPrHPem6H7gLkr8q5U8cIhLeUnveIoDkJH/7Umary4U  AHYA36Veq2iCTx9sre64X04+WurNohKkal6OOxLAIERcKnMAAAFyJqpGawAABAMA  RzBFAiB0rnOV5KjVPO/nNeE6F1chU/cyGAZAeT3OERLA1CXgTgIhAIavDo1ppxac  /7fRSoM+kRC+/awtp29+XTTVDgLrcgd5AHYAb1N2rDHwMRnYmQCkURX/dxUcEdkC  wQApBo2yCJo32RMAAAFyJqpGPAAABAMARzBFAiAKvzUQxHgsW1MQlZ2ArNmb2nV3  ka15QkeVGyZH3N+JkAIhALjDkTLdStauWocSh6MpU917CG4VTxqPdFNjniECjAPZ  MA0GCSqGSIb3DQEBCwUAA4IBAQAsSUZvm/wihWIfX4xtDGeRIDRilqUvKmIT1JtR  o/pw43vDb9onqjeiqhPIqIS0EPrTcrPiPsa7lXKpJgIn6Q6a1Vmn3bgqhWCboTfo  AZazdenTcaedHcw/4zslCV9GQ7ThryG5UuzW4jCKbaUGhBKFB4gSnGySjClyPDJn  4/29WiSSj0wCNqKElvU9q1bShtKkj4IWSae2Lb6jR1Gr3qtb6ewI8hHky/b9d10i  NOjmzonWEykVARP1cwAmSZ1iux0IMcVUacXFWrCxSOJ56blLrrgTNHFwSkXJ94Q+  hcP8q0MqwE/A+ROTOkiY9B7rl7FENuUPCKWcXE1PmM2ORXzvMYIB0TCCAc0CAQEw  gaUwgY8xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx  EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE3MDUG  A1UEAxMuU2VjdGlnbyBSU0EgRG9tYWluIFZhbGlkYXRpb24gU2VjdXJlIFNlcnZl  ciBDQQIRAN6PxK5DBuxwd22SKj0giXMwDQYJYIZIAWUDBAIBBQAwDQYJKoZIhvcN  AQEBBQAEggEAZNP1AsCBsRB5gS7AeFHbQdpO/L2ah3AEonlbBfC143on0egB/3U5  E+Sk/fd8PKDAGPRVNNsQWvYGRhGoz+b+B1NXBt21FLR2wSMcgzUvJ8SnpxrGWcj5  O55m19mGpt0vyAnKwNEUgBJ0C+VkSO/kQF2LaPWkqRvH7NjUgIedDIU4Y3WrRuh8  QTPBjEG2DHSrR8sY2WIXkkw0rgTCTKK/iTmCGpmga+7UVDjPw1KSkunjTjv5SvF7  ni/lc5AxMOtwyOCiwycd2aLorfZOydMNxPSeq9GedKvd5+SzuPaN4e29xd4RuzkU  ZgbF52G+fhKq58N94zqMUgapEt6KgOUhYA==  
screen mode id:i:2
desktopwidth:i:2256
desktopheight:i:1504
winposstr:s:0,3,0,0,800,600
compression:i:1
keyboardhook:i:2
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1'
    
    

