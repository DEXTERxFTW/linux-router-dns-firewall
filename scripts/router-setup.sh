#!/bin/bash
# router-setup.sh - Start all services for Laptop Router

set -e

echo "[*] Starting Laptop Router Setup..."

# Enable IP forwarding
echo "[*] Enabling IP forwarding..."
sudo sysctl -w net.ipv4.ip_forward=1

# Apply firewall rules
echo "[*] Applying firewall rules..."
bash "$(dirname "$0")/firewall.sh"

# Restart dnsmasq
echo "[*] Restarting dnsmasq..."
sudo systemctl restart dnsmasq

# Start hostapd
echo "[*] Starting hostapd..."
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl restart hostapd

# Start unbound
echo "[*] Starting Unbound DNS resolver..."
sudo systemctl enable unbound
sudo systemctl restart unbound

echo "[*] Router setup complete. Wi-Fi router is now active."
