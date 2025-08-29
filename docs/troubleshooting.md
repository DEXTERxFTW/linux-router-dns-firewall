# Troubleshooting Guide

This document lists common problems you may encounter while setting up the Laptop Router project, along with their solutions.

1. Wi-Fi Adapter Not Detected
Error: No such device: wlan0 or iwconfig does not list the adapter.
Solution:
- Ensure the Realtek driver (rtl8188fu) was installed correctly (lsmod | grep 8188).
- Reboot after running scripts/setup-driver.sh.
- Check with ip a to confirm wlan0 exists.

2. DHCP Client Missing
Error: dhclient: command not found
Solution:
sudo apt install isc-dhcp-client -y

3. Ethernet Interface Not Recognized
Error: eth0: Device not found
Solution:
- Run ip link to find the actual interface name (may be enp3s0, etc.).
- Update firewall.sh to match the correct interface.

4. Hostapd Fails to Start
Error: nl80211: Could not configure driver
Solution:
- Verify your Wi-Fi adapter supports AP mode: iw list | grep "AP"
- Ensure no other network manager (like NetworkManager) is controlling wlan0.
- Edit /etc/default/hostapd to point to the correct hostapd.conf.

5. Clients Cannot Access Internet
Symptom: Clients connect to Wi-Fi but have no internet.
Solution:
- Check firewall rules: iptables -t nat -L -v and iptables -L -v
- Ensure MASQUERADE is applied on the correct outbound interface (eth0).
- Run ping 8.8.8.8 from the router laptop to test connectivity.

6. DNS Not Resolving
Symptom: Internet works with IPs but not with domain names.
Solution:
- Restart dnsmasq and unbound: sudo systemctl restart dnsmasq && sudo systemctl restart unbound
- Check if Unbound is listening on 127.0.0.1#5353: netstat -tulnp | grep 5353

7. DBus Errors on Start
Error: Failed to connect to bus
Solution:
sudo systemctl start dbus
sudo systemctl enable dbus

8. Persistent iptables Rules Not Saving
Symptom: Rules are lost after reboot.
Solution:
sudo apt install iptables-persistent -y
sudo netfilter-persistent save

9. Weak Wi-Fi Signal
Solution:
- Change channel in configs/hostapd.conf.
- Place laptop in a central location.
- Use a high-gain USB Wi-Fi adapter.

10. Debugging Tips
- View logs: journalctl -u hostapd, journalctl -u dnsmasq, journalctl -u unbound
- Test DNS: dig example.com @127.0.0.1 -p 5353, nslookup example.com 127.0.0.1
