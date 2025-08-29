#!/bin/bash
# setup-driver.sh - Install Realtek RTL8188FU Wi-Fi Driver

set -e

echo "[*] Updating system..."
sudo apt update

echo "[*] Installing required packages..."
sudo apt install --reinstall -y build-essential dkms git

echo "[*] Cloning Realtek driver repository..."
git clone https://github.com/kelebek333/rtl8188fu
cd rtl8188fu

echo "[*] Adding driver to DKMS..."
sudo dkms add .

echo "[*] Building driver..."
sudo dkms build rtl8188fu/1.0

echo "[*] Installing driver..."
sudo dkms install rtl8188fu/1.0

echo "[*] Copying firmware..."
sudo cp ./firmware/rtl8188fufw.bin /usr/lib/firmware/rtlwifi/

echo "[*] Blacklisting conflicting drivers..."
echo "blacklist r8188eu" | sudo tee -a /etc/modprobe.d/blacklist.conf
echo "rtl8188fu" | sudo tee -a /etc/modules

echo "[*] Installation complete. Please reboot your system."
