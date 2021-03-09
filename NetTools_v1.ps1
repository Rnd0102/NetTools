do {
 echo "===============================================================
 __   _ _______ _______ _______  _____   _____         _______
 I \  I I______    I       I    I     I I     I I      I______
 I  \_I I______    I       I    I_____I I_____I I_____ ______I

==================== V.1 Copyright @RnD0102 ==================="
 echo ""
 echo ""
 Write-Host "Networking Tools"
 echo ""
 Write-Host "1: PsPing | Check koneksi tcp ke port tertentu"
 Write-Host "2: Whois | Mencari informasi pemilik domain"
 Write-Host "3: IpInfo | Mencari informasi pemilik IP Publik"
 Write-Host "4: Nmap | Melacak informasi suatu host"
 Write-Host "5: TraceTCP | Melacak Jalur Data TCP"
 Write-Host "6: TCP Listener | Membuka port untuk testing"
 Write-Host "7: Quit"
 echo ""
 $selection = Read-Host "Please make a selection"

 switch ($selection){
     '1' {
           ($server = Read-Host "Target IP");($port = Read-Host "Target Port");ps\psping -n 10 -f $server":"$port
         }
     '2' {
           ($server = read-host "Target Domain");whois\whois $server
         }
     '3' {
          $inputip = Read-Host "Target IP"
          Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$inputip"
         } 
     '4' {
           ($server = Read-Host "Target IP/Domain");nmap\nmap -T4 -A -v $server
         }
     '5' {
           $winver = $env:PROCESSOR_ARCHITECTURE
           $server = Read-Host "Target IP/Domain";
           $port = Read-Host "Target Port";
           Write-Host "PLEASE DO NOT CLOSE THE PROCESS UNTIL FINISH...!" -ForegroundColor Green 
           if ($winver -eq "AMD64")
           {Copy-Item -Path "tracetcp\$winver\*" -Destination "C:\Windows\SysWOW64\" -Recurse -force}
           else
           {Copy-Item -Path "tracetcp\$winver\*" -Destination "C:\Windows\SysWOW32\" -Recurse -force};
           Copy-Item "tracetcp\driver\npf.sys" -Destination "C:\Windows\System32\drivers\" -Recurse -force;
           sc.exe create npf binPath= system32\drivers\npf.sys type= kernel start= auto error= normal tag= no DisplayName= "WinPcap"
           tracetcp\app\tracetcp $server":"$port;
           sc.exe stop npf;
           sc.exe delete npf;
         }
     '6' {
           $port = Read-Host "Port"
           $endpoint = new-object System.Net.IPEndPoint ([system.net.ipaddress]::any, $port)    
           $listener = new-object System.Net.Sockets.TcpListener $endpoint
           $listener.server.ReceiveTimeout = 3000
           $listener.start()    
     
           Write-Host "Listening on port $port , Press any key to stop...!"
     
           $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
           $Listener.Stop();
           Write-Host "Listening on port $port has been stop"
         }
     '7' {exit}
 }
 Read-Host "Press any key to continue..."
 clear
}
until ($selection -eq '7')