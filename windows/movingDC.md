Build the new server
Give it a temporary IP address
Join it to the domain
Promote it to DC (you could need some adprep if this hasn't already been done)
Add required additional services (DNS, etc.)
Move FSMO roles if required
Change the IP address of the old DC to a temporary one
Reboot the old DC two times
Wait some time for replication (an hour should be more than enough)
Give the IP address of the old DC to the new DC
Reboot the new DC two times
Wait some time for replication (an hour should be more than enough)
Demote the old DC
Leave the old DC in service if there are more data or services on it, otherwise just shut it down.
