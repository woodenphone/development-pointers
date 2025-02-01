sudo iftop -f 'not broadcast and not multicast
 and (not dst net 10.0.0.0/8 or dst net 172.16.0.0/20 or dst net 192.168.0.0/16) 
 and (not src net 10.0.0.0/8 or src net 172.16.0.0/20 or src net 192.168.0.0/16)
 '






 # Skip traffic to LAN
 and (outbound and (not dst net 10.0.0.0/8 or dst net 172.16.0.0/20 or dst net 192.168.0.0/16) )

 # Skip traffic from LAN
 and (outbound and(not src net 10.0.0.0/8 or src net 172.16.0.0/20 or src net 192.168.0.0/16))

# 
(src net 10.1.1.81 or dst net 10.1.1.81)



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
* https://linux.die.net/man/7/pcap-filter
* https://www.man7.org/linux/man-pages/man5/ethers.5.html
* https://robertodip.com/blog/inspecting-network-traffic-with-iftop/
* https://www.configserverfirewall.com/linux-tutorials/iftop-network-traffic-monitoring/
* https://kb.gtkc.net/what-are-the-rfc1918-address-ranges/
* https://community.spiceworks.com/topic/2048194-a-wireshark-filter-to-eliminate-local-lan-traffic
