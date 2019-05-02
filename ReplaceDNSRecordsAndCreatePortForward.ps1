param (
    [Parameter(Mandatory=$false)][boolean]$Forceupdate
 )
#grab twitter
#$web = New-Object System.Net.WebClient
#($web.DownloadString("https://twitter.com/havra_me") | findstr /r '.*js-tweet-text.*</p>') > twitter.txt
#$tweet = Get-Content twitter.txt -First 1
#$tweet = [regex]::matches($tweet,"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+").Value
#$tweet

$ipconfiguredvivo = (Resolve-DnsName sipfed.havra.me).IpAddress
$ipvivo = (Resolve-DnsName havranek.dynu.net).IpAddress
$ipns1= (Resolve-DnsName -Server 8.8.8.8 havranekns1.cloudapp.net).IpAddress
$ipns2= (Resolve-DnsName -Server 8.8.8.8 havranekns2.cloudapp.net).IpAddress
Write-Host "Current At&t IP: $ipvivo " 
Write-Host "Configured At&t IP: $ipconfiguredvivo"
Write-Host "Configured NS1: $ipns1"
Write-Host "Configured NS2: $ipns2"
 
if(($ipconfiguredvivo -eq $ipvivo) -or !($Forceupdate))
{
Write-Host -ForegroundColor Green "No changes detected on both IP addresses... nothing to do."
}

else
{
Write-Host "IP have Changed... Starting to Update."
ipconfig /flushdns
Write-Host -ForegroundColor Green "Last port forward settings"
netsh interface portproxy show all
netsh interface portproxy reset
netsh interface portproxy add v4tov4 listenport=443 connectport=30443 connectaddress=$ipvivo
netsh interface portproxy add v4tov4 listenport=49443 connectport=49443 connectaddress=$ipvivo
netsh interface portproxy add v4tov4 listenport=80 connectport=30080 connectaddress=$ipvivo
netsh interface portproxy add v4tov4 listenport=5061 connectport=5061 connectaddress=$ipvivo
Write-Host -ForegroundColor Green "Current port forward settings"
netsh interface portproxy show all
\tools\sysint\sysint\psexec \\Havranek-DC02 netsh interface portproxy reset
\tools\sysint\sysint\psexec \\Havranek-DC02 netsh interface portproxy add v4tov4 listenport=443 connectport=40443 connectaddress=$ipvivo
\tools\sysint\sysint\psexec \\Havranek-DC02 netsh interface portproxy add v4tov4 listenport=80 connectport=40080 connectaddress=$ipvivo


# sts01.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me sts01 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me sts01 A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# lyncdiscover.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me lyncdiscover A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me lyncdiscover A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 


# fe01.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me fe01 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me fe01 A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# wac01.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me wac01 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me wac01 A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# mail.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me mail A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me mail A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 


# mail.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me exch01 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me exch01 A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# autodiscover.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me autodiscover A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me autodiscover A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# sip.havra.me --> at&t
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me sip A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me sip A $ipvivo"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# vpn.havra.me --> At&t
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me vpn A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me vpn A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

repadmin /syncall /AeD

}

