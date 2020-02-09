#https://loganmarchione.com/2017/04/duckdns-on-edgerouter/

Web setup
Head over to the DuckDNS website and setup an account. Interestingly, DuckDNS only offers oAuth logins (e.g., through Google, Facebook, Reddit, etc…). This is so they don’t have to worry about storing usernames/passwords themselves and can leave it to the professionals.

Next, enter your domain in the box and click Add domain. If the domain is available, it will be registered to your account. While you’re on this same screen, make note of your account token.

Router setup
EdgeOS only supports a handful of pre-configured DNS service providers by default (shown below).

ubnt@erl# set service dns dynamic interface eth0 service
afraid       dslreports   easydns      noip         zoneedit
dnspark      dyndns       namecheap    sitelutions
To use DuckDNS, we need to setup a custom service provider. Substitute your interface, hostname, and password as needed.

set service dns dynamic interface eth0 service custom-duckdns
set service dns dynamic interface eth0 service custom-duckdns host-name loganmarchione
set service dns dynamic interface eth0 service custom-duckdns login nouser
set service dns dynamic interface eth0 service custom-duckdns password your-token-here
set service dns dynamic interface eth0 service custom-duckdns protocol dyndns2
set service dns dynamic interface eth0 service custom-duckdns server www.duckdns.org
commit
save
exit
A couple notes on the options:

the hostname is the prefix to your domain (e.g., loganmarchione.duckdns.org)
the username is nouser (don’t use your account name)
the password is your account token (that long string of numbers/letters)
Verify setup
Trigger a manual update. EdgeOS will only update the dynamic DNS provider when your IP address actually changes.

update dns dynamic interface eth0
You can show the status with the command below.

show dns dynamic status
Here, you can see the successful update.

interface    : eth0
ip address   : XX.XX.XX.XX
host-name    : loganmarchione
last update  : Tue Apr 25 22:13:09 2017
update-status: good
SSL settings
Also, just so you know, EdgeOS uses ddclient for the dynamic DNS updates. The configuration file is located at /etc/ddclient.conf, but there is a directory at /etc/ddclient with a configuration file for each interface. By default, ddclient is setup to use SSL, as shown below.

root@erl:~# grep ssl /etc/ddclient/ddclient_eth*.conf
ssl=yes
 

Hope this helps!
