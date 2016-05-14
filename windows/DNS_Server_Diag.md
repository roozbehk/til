```
net stop net logon & net start net logon
ipconfig /flushdns & ipconfig /registerdns
dcdiag /test:dns /v /s:<DCName>
```
Check DC List
`nltest /dclist:DOMAINNAME`

Operations master test
```cmd
dcdiag /s:DCNAME /test:knowsofroleholders /v
dcdiag /s:DCNAME /test:knowsofroleholders /ve
```

operations masters are functioning properly and are available on the network
```cmd
dcdiag /s:DCNAME  /test:fsmocheck
dcdiag /s:DCMANE  /test:fsmocheck
```

To uninstall Active Directory
repoint DC DNS to another DC IP.
https://technet.microsoft.com/en-us/library/cc737258(v=ws.10).aspx
Delete a Server object from a site
