# Linux-Based Wireless Router with Custom DNS & Firewall

##  Project Overview
This project demonstrates how an **old laptop** was converted into a fully functional **Linux-based Wi-Fi Access Point** with a **custom DNS server** and **firewall rules**.  
Since the **inbuilt Wi-Fi card of the laptop was not working**, we connected an **external USB Wi-Fi adapter (Realtek RTL8188FTV)** to enable wireless access point functionality.  
It was built on **Ubuntu Server (CLI-only)** and includes step-by-step configuration of **network drivers, DHCP, Hostapd, Dnsmasq, and Iptables firewall**.
The aim was to repurpose legacy hardware into a **secure and educational networking appliance**, gaining hands-on experience with system administration, networking, and troubleshooting.

---

##  Features
- Wireless Access Point using **Hostapd**
- DHCP & DNS services with **Dnsmasq**
- Custom **DNS blocking & redirection**
- **Firewall & NAT** setup using Iptables
- Logs of **errors and troubleshooting**
- Repurposed old hardware into a **working router**

---

##  Tools & Technologies
- **Ubuntu Server 24.04 LTS (CLI-only)**
- **Hostapd** – Wireless Access Point service
- **Dnsmasq** – Lightweight DNS & DHCP server
- **Iptables** – Firewall and NAT
- **Systemd / Netplan** – Network configuration

---

##  Setup Process (Simplified)
1. Installed Ubuntu Server 24.04 LTS (CLI)  
2. Resolved **ethernet driver issues** and installed missing packages  
3. Installed and configured `hostapd` for Wi-Fi AP  
4. Configured `dnsmasq` for DHCP + custom DNS  
5. Applied **iptables firewall rules** for NAT and traffic filtering  
6. Documented troubleshooting for errors like:  
   - *"Failed to connect to bus"*  
   - *"Network unreachable"*  
   - DHCP not starting on boot  
   - Wi-Fi stuck at *"Obtaining IP"*  

---

##  Documentation
A detailed **report with errors, fixes, and final working setup** is available in this repository.  
👉 [Read the Full Report](./Report.md)  

---

##  Contributors
- **Nihal Pirjade**  
- **SmartyTinker**   

---

##  Future Improvements
- Add **Web UI** for configuration  
- Implement **Suricata / Snort IDS** for intrusion detection  
- Automate firewall setup with **scripts**  
- Containerize services with **Docker**  

---

##  Repository Structure
```
/docs → Report, Diagrams, Notes
/configs → Hostapd, Dnsmasq, Netplan, Iptables configs
/scripts → Automation scripts for firewall/DNS
README.md → Project overview
```
---

##  License
This project is open-source under the **MIT License**.  
Feel free to use and improve it!  
