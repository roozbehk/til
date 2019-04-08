Here's how I do it:

First, SSH into the router and type:

configure
 To stop the ISP DNS servers from populating /etc/resolv.conf

set interfaces ethernet eth1 dhcp-options name-server no-update
 To tell DNSMasq to use OpenDNS

`edit service dns forwarding
```set name-server 208.67.222.222
```set name-server 208.67.220.220
```top
 To instruct the router to use DNSMasq for name resolution

```set system name-server 127.0.0.1
 To commit changes and save configuration

``commit
```save
```exit
 Finally, you need to renew your WAN IP to remove the ISP DNS entries from /etc/resolv.conf.

```renew dhcp interface eth1
 To confirm, type:

```show dns forwarding nameservers
 You should see

```
-----------------------------------------------
   Nameservers configured for DNS forwarding
-----------------------------------------------
208.67.222.222 available via 'statically configured'
208.67.220.220 available via 'statically configured'

-----------------------------------------------
 Nameservers NOT configured for DNS forwarding
-----------------------------------------------
127.0.0.1 available via 'system'
 ```
