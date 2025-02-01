# iftop - Basic guide



## Filtering (pcap)
iftop filters use the [pcap-filter(7)](https://linux.die.net/man/7/pcap-filter) syntax.
```bash
sudo iftop -f "not broadcast and not multicast
 and (not dst net 10.0.0.0/8 or dst net 172.16.0.0/20 or dst net 192.168.0.0/16) 
 and (not src net 10.0.0.0/8 or src net 172.16.0.0/20 or src net 192.168.0.0/16) "
```

IPv4 LAN address ranges are specified in ["RFC 1918" - "Address Allocation for Private Internets"](https://www.rfc-editor.org/rfc/rfc1918)

Skip traffic to LAN
```bash
sudo iftop -f "not broadcast and not multicast \
and (outbound and (not dst net 10.0.0.0/8 or dst net 172.16.0.0/20 or dst net 192.168.0.0/16) ) "
```

Skip traffic from LAN
```bash
sudo iftop -f "not broadcast and not multicast
and (outbound and (not src net 10.0.0.0/8 or src net 172.16.0.0/20 or src net 192.168.0.0/16)) "
```

```bash
sudo iftop -f "not broadcast and not multicast
and (src net 10.1.1.81 or dst net 10.1.1.81) "
```


## Useful iftop invocations
Download rate from internet only:
```bash
sudo iftop -f 'not broadcast and not multicast and (inbound and (not src net 10.0.0.0/8 or src net 172.16.0.0/20 or src net 192.168.0.0/16))'
```

Upload rate to internet only:
```bash
sudo iftop -f 'not broadcast and not multicast and (outbound and (not dst net 10.0.0.0/8 or dst net 172.16.0.0/20 or dst net 192.168.0.0/16))'
```

Upload and download to/from internet only:
```bash
sudo iftop -f 'not broadcast and not multicast and ( (outbound and (not dst net 10.0.0.0/8 or dst net 172.16.0.0/20 or dst net 192.168.0.0/16)) or (inbound and (not src net 10.0.0.0/8 or src net 172.16.0.0/20 or src net 192.168.0.0/16)) )'
```


## Links
* ["RFC 1918" - "Address Allocation for Private Internets"](https://www.rfc-editor.org/rfc/rfc1918)
* https://en.wikipedia.org/wiki/Private_network
* https://linux.die.net/man/7/pcap-filter
* https://www.man7.org/linux/man-pages/man5/ethers.5.html
* https://robertodip.com/blog/inspecting-network-traffic-with-iftop/
* https://www.configserverfirewall.com/linux-tutorials/iftop-network-traffic-monitoring/
* https://kb.gtkc.net/what-are-the-rfc1918-address-ranges/
* https://community.spiceworks.com/topic/2048194-a-wireshark-filter-to-eliminate-local-lan-traffic
