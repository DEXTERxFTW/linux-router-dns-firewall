# From Laptop to Router: A Practical Project on Network Sharing and DNS Management

## Authors
- **Nihal Pirjade**
  - Email: nihalpirjade.clg@gmail.com
  - LinkedIn: [linkedin.com/in/nihal-pirjade](https://www.linkedin.com/in/nihal-pirjade)
  - GitHub: [github.com/DEXTERxFTW](https://github.com/DEXTERxFTW)

- **Siddhant Kadam**
  - Email: sidddhantkadam@gmail.com
  - LinkedIn: [linkedin.com/in/siddhant-kadam-895b2b237](https://www.linkedin.com/in/siddhant-kadam-895b2b237)
  - GitHub: [github.com/smartytinker](https://github.com/smartytinker)

---

##  Abstract
This project demonstrates how to repurpose an old laptop into a Linux-based Wi-Fi router. 
It uses a USB Wi-Fi adapter, hostapd, dnsmasq, and iptables to provide network sharing, 
DHCP/DNS services, and firewall/NAT rules. For enhanced privacy, Unbound with DNS-over-TLS (DoT) 
is integrated to encrypt DNS queries. 

---

##  Objectives
- Convert an old laptop into a Wi-Fi router and access point.
- Provide DHCP and DNS services for clients.
- Implement firewall and NAT rules for secure routing.
- Run entirely on Ubuntu Server (CLI-only).
- Integrate DNS-over-TLS for secure DNS queries.

---

##  Tools and Technologies Used
- **OS**: Ubuntu Server 22.04 LTS (CLI-only)
- **Wi-Fi Driver**: Realtek rtl8188fu via DKMS
- **hostapd**: For Wi-Fi AP configuration
- **dnsmasq**: DHCP and DNS services
- **iptables**: Firewall and NAT
- **Unbound + DNS-over-TLS**: Secure DNS resolution
- **SSH**: Remote management

---
##  Repository Structure
```bash
.
├── README.md                # Main documentation
├── configs/
│   ├── hostapd.conf         # Wi-Fi AP config
│   ├── dnsmasq.conf         # DHCP & DNS config
│   ├── unbound.conf         # Unbound + DoT config
├── scripts/
│   ├── setup-driver.sh      # Install Realtek Wi-Fi driver
│   ├── firewall.sh          # NAT + firewall rules
│   ├── router-setup.sh      # Start all services
├── docs/
│   ├── Report.pdf           # Full research report
│   └── troubleshooting.md   # Errors & fixes
```

##  Hardware Setup
- **Laptop**: Old laptop with working Ethernet port
- **Wi-Fi Adapter**: Realtek RTL8188FTV (USB)
- **Ethernet**: Connected to upstream Internet source

---

##  System Architecture
- **eth0** → Internet connection (Ethernet)
- **wlan0** → Wireless Access Point for clients
- NAT and firewall rules secure traffic flow.
- Clients get IPs via dnsmasq and route traffic via eth0.

---

##  Implementation Steps
1. Install Realtek Wi-Fi Driver (rtl8188fu)
2. Enable IP Forwarding (`net.ipv4.ip_forward=1`)
3. Configure **hostapd** for Wi-Fi AP
4. Configure **dnsmasq** for DHCP + DNS
5. Configure **iptables** for NAT + firewall
6. Integrate **Unbound + DNS-over-TLS**

---

##  Troubleshooting
- Ensure DHCP client (`isc-dhcp-client`) is installed.
- Bring up missing network interfaces with `ip link set eth0 up`.
- Start DBus if hostapd/dnsmasq fail.
- Verify firewall rules with `iptables -L`.

---

##  Firewall & DNS Example
```bash
# Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# Firewall rules
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

# Sample dnsmasq.conf
interface=wlan0
dhcp-range=192.168.10.10,192.168.10.50,12h
server=1.1.1.1
server=8.8.8.8
no-resolv
```

---

##  Testing and Results
- Devices connected successfully to the new SSID.
- Internet accessible via laptop-router.
- DNS resolution via dnsmasq + Unbound (DoT) worked correctly.
- Traffic properly NAT-ed and encrypted DNS confirmed.

---

##  Future Scope
- Add VPN server (WireGuard/OpenVPN)
- IDS/IPS integration (Snort/Suricata)
- Web-based GUI for easier management
- Port setup to Raspberry Pi for compact solution

---

##  Conclusion
This project proves that an old laptop can be repurposed into a fully functional Linux router. 
With hostapd, dnsmasq, iptables, and Unbound (DNS-over-TLS), it offers a secure and privacy-focused 
networking solution, acting as a low-cost alternative to commercial routers.

---

##  References
1. [Router-DNS GitHub Repository](https://github.com/siddhantkadam/router-dns)
2. [hostapd Documentation](https://w1.fi/hostapd/)
3. [dnsmasq Documentation](http://www.thekelleys.org.uk/dnsmasq/doc.html)
4. [iptables Manual](https://ipset.netfilter.org/iptables.man.html)
5. [Ubuntu Server Guide](https://ubuntu.com/server/docs)
6. [Realtek RTL8188fu Driver](https://github.com/kelebek333/rtl8188fu)
7. [Unbound DNS Resolver](https://nlnetlabs.nl/documentation/unbound/)
8. [RFC 7858 - DNS-over-TLS](https://datatracker.ietf.org/doc/html/rfc7858)
9. [RFC 8484 - DNS-over-HTTPS](https://datatracker.ietf.org/doc/html/rfc8484)
