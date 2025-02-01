# Netowrking
Ethernet, TCP/IP, and the like.

# Links
## Designated IP Address ranges (IPv4 and IPv6)
* Brief overview of reserved IP address ranges: ["Reserved IP addresses" (Wikipedia)](https://en.wikipedia.org/wiki/Reserved_IP_addresses)
* Current best-practice listing of IP ranges: ["Special-Purpose IP Address Registries" (RFC-6890)](https://datatracker.ietf.org/doc/html/rfc6890)


## Cabling and connectors
Cabling, connectors, etc. for wired ethernet.

Basic cabling advice
------
As of 2025:

Continue using existing Cat5/Cat5e for `10/100/1000BASE-T` (Cat5 was depricated back in 2001 and replaced with Cat5e).

Avoid buying new cables lower than Cat6.

Use Cat6e or better for new fixed runs (e.g. in walls anc ceilings).

Bascially all copper ethernet cables you buy should be Cat6e (as of 2025).

Be suspicioius of cabling claiming to be better than Cat6 (e.g. Cat7, Cat8) as it's a common scam to print a higher number to a lower-spec cable;

The official length limit is 100m max wire length for 10/100/1000BASE-T, after which it requires active circuitry of some sort; the in general the more data you want to push through the better your cabling needs to be.

Tip: For modern home use throwing in (a) simple network switch(es) between runs is enough to bypass the 100m maximum wire length. (5-port 1000BASE-T switches are pretty cheap.)

Distances and speeds for types of cable
------
- Cat5 - `100m @ 1000BASE‑T (1Gbit/sec)`
- Cat5e - `DISTm @ RATESPEC (nGbit/sec) `
- Cat6 - `55m @10GBASE-T (10Gbit/sec)`, `100m @ 10/100/1000BASE-T (10M/100M/1G bit/sec)` 
- Cat6A - `100m @10GBASE-T (10Gbit/sec)`, `100m @ 10/100/1000BASE-T (10M/100M/1G bit/sec)` 

------
* <https://en.wikipedia.org/wiki/Gigabit_Ethernet#Copper>
* <https://en.wikipedia.org/wiki/Category_3_cable>
* <https://en.wikipedia.org/wiki/Category_5_cable>
* <https://en.wikipedia.org/wiki/Category_6_cable>
* <https://en.wikipedia.org/wiki/Ethernet_over_twisted_pair>
* <https://en.wikipedia.org/wiki/2.5GBASE-T_and_5GBASE-T>
* Why de don't see Cat7 or Cat8 much: <https://en.wikipedia.org/wiki/ISO/IEC_11801#Category_7> and <https://en.wikipedia.org/wiki/ISO/IEC_11801#Category_8>
* Relevant spec `"Commercial Building Telecommunications Cabling Standard" "ANSI/TIA-568"`
 ["ANSI/TIA-568" (Wikipedia)](https://en.wikipedia.org/wiki/ANSI/TIA-568)
 <https://tekdataco.com/wp-content/uploads/2020/02/TIA-568-C.2-64_2_Compressed.pdf>
 <https://img.antpedia.com/standard/files/pdfs_ora/20230614/TIA/ANSI%20TIA-568-C.1-2009.pdf>
* ["TIA-102 series standards documents " (Internet archive)](https://archive.org/details/TIA-102_Series_Documents/)
* `ISO/IEC 11801 - "Information technology — Generic cabling for customer premises` "<https://en.wikipedia.org/wiki/ISO/IEC_11801>
* ["AMP NETCONNECT Guide to ISO/IEC 11801 2 nd Edition Including Amendment 1" (2008) (wayback machine)](https://web.archive.org/web/20140203153656/https://www.lanster.com/pub/files/file/okablowanie_normy/Guide_ISO_11801_2nd_Amendment1.pdf)

------


## Switching, routing, etc (Ethernet)
The active parts of a typical ethernet network.

* TODO: Explaination: Router - simple minimal case (Inter-network packet movement).
* TODO: Explaination: Router - virtual.
* TODO: Explaination: Router - Typical homelan case (DHCP, firewall, NAT, etc).
* TODO: Explaination: Router - network rack case (Integrated service routers; backbone routers; Complex redundant topologies; etc.).
* TODO: Explaination: Hub, incl. why we don't use them (shared medium).
* TODO: Explaination: Switch  - Typical homelan case.
* TODO: Explaination: Switch  - Virtual case.
* TODO: Explaination: Network bridge, both physical and virtual.
* TODO: Explaination: Tunnel/VPN  - Virtual case incl. tun devices, inspection and management; both wireguard and ssh.



## Guides and tutorials

### NAT (Network Address Translation)
* ["How NAT traversal works" (tailscale)](https://tailscale.com/blog/how-nat-traversal-works)


## RFCs
Genrerally considered to be authoratative enough.
* ["Special-Purpose IP Address Registries" (RFC-6890)](https://datatracker.ietf.org/doc/html/rfc6890)
* ["IPv4 Address Blocks Reserved for Documentation" (RFC-5737)](https://datatracker.ietf.org/doc/html/rfc5737)
* ["IPv6 Address Prefix Reserved for Documentation" (RFC-3849)](https://datatracker.ietf.org/doc/html/rfc3849)
* ["Expanding the IPv6 Documentation Space" (RFC-9637)](https://datatracker.ietf.org/doc/html/rfc9637)
* ["Address Allocation for Private Internets" (RFC-1918)](https://datatracker.ietf.org/doc/html/rfc1918)
* ["Unique Local IPv6 Unicast Addresses" (RFC-4193)](https://datatracker.ietf.org/doc/html/rfc4193)


## Wifi / 802.11 / wlan



# Unsorted links

* ["How NAT traversal works" (tailscale)](https://tailscale.com/blog/how-nat-traversal-works)
