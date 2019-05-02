$ipConfiguredMainISP = (Resolve-DnsName sipfed.havra.me).IpAddress
$ipConfiguredSecondaryISP = (Resolve-DnsName vpn.havra.me).IpAddress
$ipMainISP = (Resolve-DnsName -Server 8.8.8.8 home-vivo.no-ip.info).IpAddress
$ipSecondaryISP = (Resolve-DnsName -Server 8.8.8.8 home-tim.no-ip.info).IpAddress
$ipns1= (Resolve-DnsName -Server 8.8.8.8 havranekns1.cloudapp.net).IpAddress
$ipns2= (Resolve-DnsName -Server 8.8.8.8 havranekns2.cloudapp.net).IpAddress
$iprp= (Resolve-DnsName -Server 8.8.8.8 havranekns1.cloudapp.net).IpAddress
Write-Host "Dyn Main IP: $ipMainISP " 
Write-Host "Dyn Secondary IP: $ipSecondaryISP " 
Write-Host "Configured Main IP: $ipConfiguredMainISP"
Write-Host "Configured Secondary IP: $ipConfiguredSecondaryISP"
 

if(($ipConfiguredMainISP -eq $ipMainISP) -and ($ipConfiguredSecondaryISP -eq $ipSecondaryISP))
{
Write-Host -ForegroundColor Green "No changes detected on both IP addresses... nothing to do."
}

else
{
Write-Host "IP has Changed... Updating records."

# ns1.havra.me --> havranekns1.cloudapp.net
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me sts A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me sts A $ipns1"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# ns2.havra.me --> havranekns2.cloudapp.net
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me sts A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me sts A $ipns2"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 


# sts.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me sts A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me sts A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# lyncdiscover.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me lyncdiscover A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me lyncdiscover A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# lyncfe01.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me lyncfe01 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me lyncfe01 A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# pool01.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me pool01 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me pool01 A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd

# cacti.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me cacti A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me cacti A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd

# rootca.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me rootca A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me rootca A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd


# fe2010.havra.me --> rp
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me fe2010 A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me fe2010 A $iprp"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# sipfed.havra.me --> vivo
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me sipfed A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me sipfed A $ipMainISP"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# access.havra.me --> vivo
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me access A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me access A $ipMainISP"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# av.havra.me --> vivo
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me av A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me av A $ipMainISP"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# webconf.havra.me --> vivo
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me webconf A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me webconf A $ipMainISP"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 

# vpn.havra.me --> tim
$cmdDelete = "dnscmd havranek-DC01 /RecordDelete havra.me vpn A /f"
$cmdAdd = "dnscmd havranek-DC01 /RecordAdd havra.me vpn A $ipSecondaryISP"
Write-Host "Running the following command: $cmdDelete" 
Invoke-Expression $cmdDelete 
Write-Host "Running the following command: $cmdAdd" 
Invoke-Expression $cmdAdd 
}
