Does anyone know how to clear DHCP registered DNS names from the USG?  
The only options I see for clearing are those from the forwarding cache.  It also appears that a USG reboot doesnt clear it either.  

Remove them from the vi /etc/hosts file on the USG.



sudo /etc/init.d/dnsmasq force-reload

