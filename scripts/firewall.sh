#!/bin/bash
# firewall.sh - Configure NAT and Firewall rules for Laptop Router

set -e

echo "[*] Enabling IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1

echo "[*] Applying iptables rules..."

# NAT masquerading on Ethernet (eth0)
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Allow established/related connections back to wlan0
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow traffic from wlan0 to eth0
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

echo "[*] Firewall rules applied successfully."
