Using DNS
```dig TXT +short o-o.myaddr.l.google.com @ns1.google.com```

Using Interface
```ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'```
