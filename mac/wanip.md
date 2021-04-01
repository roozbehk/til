I'd recommend getting it directly from a DNS server.

Most of the other answers below all involve going over HTTP to a remote server. Some of them required parsing of the output, or relied on the User-Agent header to make the server respond in plain text. Those change quite frequently (go down, change their name, put up ads, might change output format etc.).

The DNS response protocol is standardised (the format will stay compatible).
Historically, DNS services (OpenDNS, Google Public DNS, ..) tend to survive much longer and are more stable, more scalable, and generally more looked-after than whatever new hip whatismyip.com HTTP service is hot today.
This method is inherently faster (be it only by a few milliseconds!).
Using dig with OpenDNS as resolver:

```dig +short myip.opendns.com @resolver1.opendns.com```
Perhaps alias it in your bashrc so it's easy to remember

```alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'```
Responds with a plain ip address:

$ wanip
80.100.192.168 # or, 2606:4700:4700::1111
