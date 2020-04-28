Setup Time
Setup time on on PDC (WALDORF) and allow sync to peers with UCLA Time  

net stop w32time
w32tm /unregister
w32tm /register
net start w32time
w32tm /config /syncfromflags:manual /manualpeerlist:"time1.ucla.edu time2.ucla.edu time3.ucla.edu time4.ucla.edu" /reliable:yes /update
W32tm /resync /rediscover
net stop w32time && net start w32time


Setup time on other DCs

net stop w32time
w32tm /unregister
w32tm /register
net start w32time
w32tm /config /syncfromflags:domhier /update
W32tm /resync /rediscover
net stop w32time && net start w32time


Test Time

w32tm /query /source
w32tm /query /status
w32tm /query /configuration
w32tm /monitor
