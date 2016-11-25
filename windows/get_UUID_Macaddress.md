In the event that you’re using UUID or MAC Address to uniquely identify servers in the a database (the MDT database for example) you might want a quick and easy way of getting these values from the Command Prompt on the target server/client…

```
UUID

wmic csproduct get "UUID" > C:\UUID.txt
MAC Address

wmic nic get "MACAddress" > C:\MAC.txt
or

ipconfig /all | find /i "phy" > C:\MAC.txt

```
