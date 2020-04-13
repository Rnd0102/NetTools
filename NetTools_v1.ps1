
function Show-Menu
{
    param (
        [string]$Title = 'NETTOOLS'
    )
    Clear-Host

echo "===============================================================
 __   _ _______ _______ _______  _____   _____         _______
 I \  I I______    I       I    I     I I     I I      I______
 I  \_I I______    I       I    I_____I I_____I I_____ ______I

==================== V.1 Copyright @RnD0102 ==================="
echo ""
echo ""
Write-Host "Networking Tools"
echo ""
Write-Host "1: Ping Port"
Write-Host "2: Whois"
Write-Host "3: IP Public info"
Write-Host "4: Check Open Port&Services"
Write-Host "5: TraceTCP"
Write-Host "6: Quit"
}
Show-Menu –Title 'NETTOOLS'
echo ""
$selection = Read-Host "Please make a selection"
 switch ($selection)
 {
 
     '1' {($server = Read-Host "Masukan IP/DOMAIN Tujuan");($port = Read-Host "Masukan Port Tujuan");ps\psping $server":"$port }
	 '2' {($server = read-host "Masukan IP/DOMAIN Tujuan");whois\whois $server};
	 '3' {Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)} 
	 '4' {($server = Read-Host "Masukan IP/DOMAIN Tujuan");nmap\nmap -T4 -A -v $server}
     '5' {
$winver = $env:PROCESSOR_ARCHITECTURE
$server = Read-Host "Masukan IP/DOMAIN Tujuan";
$port = Read-Host "Masukan Port Tujuan";
if ($winver -eq "AMD64")
{Copy-Item -Path "tracetcp\$winver\*" -Destination "C:\Windows\SysWOW64\" -Recurse -force}
else
{Copy-Item -Path "tracetcp\$winver\*" -Destination "C:\Windows\SysWOW32\" -Recurse -force};
Copy-Item "tracetcp\driver\npf.sys" -Destination "C:\Windows\System32\drivers\" -Recurse -force;
sc.exe create npf binPath= system32\drivers\npf.sys type= kernel start= auto error= normal tag= no DisplayName= "WinPcap"
tracetcp\app\tracetcp $server":"$port;
sc.exe stop npf;
sc.exe delete npf;}
     '6' {exit}

 }
 Read-Host "Press any key to continue..."
 do {
 Show-Menu –Title 'NETTOOLS'
echo ""
$selection = Read-Host "Please make a selection"
 switch ($selection)
 {
 
     '1' {($server = Read-Host "Masukan IP/DOMAIN Tujuan");($port = Read-Host "Masukan Port Tujuan");ps\psping $server":"$port }
	 '2' {($server = read-host "Masukan IP/DOMAIN Tujuan");whois\whois $server};
	 '3' {Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)} 
	 '4' {($server = Read-Host "Masukan IP/DOMAIN Tujuan");nmap\nmap -T4 -A -v $server}
     '5' {
$winver = $env:PROCESSOR_ARCHITECTURE
$server = Read-Host "Masukan IP/DOMAIN Tujuan";
$port = Read-Host "Masukan Port Tujuan";
if ($winver -eq "AMD64")
{Copy-Item -Path "tracetcp\$winver\*" -Destination "C:\Windows\SysWOW64\" -Recurse -force}
else
{Copy-Item -Path "tracetcp\$winver\*" -Destination "C:\Windows\SysWOW32\" -Recurse -force};
Copy-Item "tracetcp\driver\npf.sys" -Destination "C:\Windows\System32\drivers\" -Recurse -force;
sc.exe create npf binPath= system32\drivers\npf.sys type= kernel start= auto error= normal tag= no DisplayName= "WinPcap"
tracetcp\app\tracetcp $server":"$port;
sc.exe stop npf;
sc.exe delete npf;}
     '6' {exit}

 }
 Read-Host "Press any key to continue... "
 }
 until ($selection -eq '5')