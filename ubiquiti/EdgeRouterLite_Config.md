## Boot File final_zone_policy_v3.boot

`save` content below to `final_zone_policy_v3.boot`

`winscp` sftp/ssh to /home/ubnt and upload final_zone_policy_v3.boot`

`ssh` into ubnt

> `configure`

> `load /home/ubnt/final_zone_policy_v3.boot`

```
firewall {
    all-ping enable
    broadcast-ping disable
    ipv6-name allow-all-6 {
        default-action accept
    }
    ipv6-name allow-est-drop-inv-6 {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
            state {
                established enable
                related enable
            }
        }
        rule 2 {
            action drop
            log enable
            state {
                invalid enable
            }
        }
        rule 100 {
            action accept
            protocol ipv6-icmp
        }
    }
    ipv6-name lan-local-6 {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
            state {
                established enable
                related enable
            }
        }
        rule 2 {
            action drop
            log enable
            state {
                invalid enable
            }
        }
        rule 100 {
            action accept
            protocol ipv6-icmp
        }
        rule 200 {
            action accept
            description "Allow HTTP/HTTPS"
            destination {
                port 80,443,8443
            }
            protocol tcp
        }
        rule 600 {
            action accept
            description "Allow DNS"
            destination {
                port 53
            }
            protocol tcp_udp
        }
        rule 700 {
            action accept
            description "Allow DHCP"
            destination {
                port 67,68
            }
            protocol udp
        }
        rule 800 {
            action accept
            description "Allow SSH"
            destination {
                port 22,8022
            }
            protocol tcp
        }
    }
    ipv6-receive-redirects disable
    ipv6-src-route disable
    ip-src-route disable
    log-martians enable
    name allow-all {
        default-action accept
    }
    name allow-est-drop-inv {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
            state {
                established enable
                related enable
            }
        }
        rule 2 {
            action drop
            log enable
            state {
                invalid enable
            }
        }
    }
    name lan-local {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
            state {
                established enable
                related enable
            }
        }
        rule 2 {
            action drop
            log enable
            state {
                invalid enable
            }
        }
        rule 100 {
            action accept
            protocol icmp
        }
        rule 200 {
            action accept
            description "Allow HTTP/HTTPS"
            destination {
                port 80,443,8443
            }
            protocol tcp
        }
        rule 600 {
            action accept
            description "Allow DNS"
            destination {
                port 53
            }
            protocol tcp_udp
        }
        rule 700 {
            action accept
            description "Allow DHCP"
            destination {
                port 67,68
            }
            protocol udp
        }
        rule 800 {
            action accept
            description "Allow SSH"
            destination {
                port 22,8022
            }
            protocol tcp
        }
    }
    name local-lan {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
            state {
                established enable
                related enable
            }
        }
        rule 2 {
            action drop
            log enable
            state {
                invalid enable
            }
        }
        rule 100 {
            action accept
            description tftp
            destination {
                port 69
            }
            protocol udp
        }
    }
    receive-redirects disable
    send-redirects enable
    source-validation disable
    syn-cookies enable
}
interfaces {
    ethernet eth0 {
        address dhcp
        duplex auto
        speed auto
    }
    ethernet eth1 {
        address 10.10.2.1/24
        description LAN
        duplex auto
        speed auto
    }
    ethernet eth2 {
        duplex auto
        speed auto
    }
    loopback lo {
    }
}
service {
    dhcp-server {
        disabled false
        hostfile-update disable
        shared-network-name LAN {
            authoritative disable
            subnet 10.10.2.0/24 {
                default-router 10.10.2.1
                dns-server 10.10.2.1
                lease 86400
                start 10.10.2.50 {
                    stop 10.10.2.254
                }
            }
        }
    }
    dns {
        forwarding {
            cache-size 150
            listen-on eth1
        }
    }
    gui {
        http-port 80
        https-port 8443
        older-ciphers enable
    }
    nat {
        rule 5010 {
            description "Masquerade for WAN"
            outbound-interface eth0
            type masquerade
        }
    }
    ssh {
        port 8022
        protocol-version v2
    }
}
system {
    host-name ubnt
    login {
        user ubnt {
            authentication {
                encrypted-password $1$zKNoUbAo$gomzUbYvgyUMcD436Wo66.
            }
            level admin
        }
    }
    ntp {
        server 0.ubnt.pool.ntp.org {
        }
        server 1.ubnt.pool.ntp.org {
        }
        server 2.ubnt.pool.ntp.org {
        }
        server 3.ubnt.pool.ntp.org {
        }
    }
    syslog {
        global {
            facility all {
                level notice
            }
            facility protocols {
                level debug
            }
        }
    }
    time-zone UTC
}
zone-policy {
    zone LAN {
        default-action drop
        from WAN {
            firewall {
                ipv6-name allow-est-drop-inv-6
                name allow-est-drop-inv
            }
        }
        from local {
            firewall {
                ipv6-name allow-est-drop-inv-6
                name local-lan
            }
        }
        interface eth1
    }
    zone WAN {
        default-action drop
        from LAN {
            firewall {
                ipv6-name allow-all-6
                name allow-all
            }
        }
        from local {
            firewall {
                ipv6-name allow-all-6
                name allow-all
            }
        }
        interface eth0
    }
    zone local {
        default-action drop
        from LAN {
            firewall {
                ipv6-name lan-local-6
                name lan-local
            }
        }
        from WAN {
            firewall {
                ipv6-name allow-est-drop-inv-6
                name allow-est-drop-inv
            }
        }
        local-zone
    }
}


/* Warning: Do not remove the following line. */
/* === vyatta-config-version: "config-management@1:conntrack@1:cron@1:dhcp-relay@1:dhcp-server@4:firewall@5:ipsec@5:nat@3:qos@1:quagga@2:system@4:ubnt-pptp@1:ubnt-util@1:vrrp@1:webgui@1:webproxy@1:zone-policy@1" === */
/* Release version: v1.8.5.4884695.160608.1057 */

```
