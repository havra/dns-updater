# Description 
This project is intended to run on Windows virtual machine with static IP and DNS authoritative for your zone and circumvent port limitations and dynamic ip issues imposed by ISPs.

# Pre requisites
- Valid DNS zone
- DNS server on Windows Server
- Dynu DNS - Dynamic DNS service

# How it works
The script is scheduled to run every minute or so.
It resolves the IP address of your home ISP based on the Dynu names you have in place and create entries on DNS server authoritive to your zone.

