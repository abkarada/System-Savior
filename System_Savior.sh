#!/bin/bash

set -e  # Exit immediately on error

# Colored output
info()    { echo -e "\e[36m[INFO]\e[0m $1"; }
success() { echo -e "\e[32m[SUCCESS]\e[0m $1"; }
warn()    { echo -e "\e[33m[WARN]\e[0m $1"; }
error()   { echo -e "\e[31m[ERROR]\e[0m $1"; }

clear
info "SystemSaver starting..."
sleep 1

info "Creating mount directories..."
sudo mkdir -p /mnt/recovery /mnt/usb

ROOT_DEV=$(lsblk -pn -o NAME,FSTYPE | grep -E 'ext4|btrfs' | grep -vE 'boot|live|squashfs' | awk '{print $1}' | head -n 1)
if [ -z "$ROOT_DEV" ]; then
  error "Root partition not found."
  exit 1
fi
success "Root partition detected: $ROOT_DEV"

sudo mount "$ROOT_DEV" /mnt/recovery || {
  error "Failed to mount root partition."; exit 1;
}
success "Root partition mounted at /mnt/recovery."

USERNAME=$(ls /mnt/recovery/home | head -n 1)
if [ -z "$USERNAME" ]; then
  error "No user found in /home."; exit 1
fi
success "User detected: $USERNAME"

USB_DEV=$(lsblk -pn -o NAME,FSTYPE | grep -E 'fat|vfat|exfat|ext4' | grep -v "$ROOT_DEV" | awk '{print $1}' | head -n 1)
if [ -z "$USB_DEV" ]; then
  error "No USB device detected."
  exit 1
fi
success "USB device found: $USB_DEV"

sudo mount "$USB_DEV" /mnt/usb || {
  error "Failed to mount USB device."; exit 1;
}
success "USB mounted at /mnt/usb."

info "Starting backup from /home/$USERNAME..."
sudo rsync -aP "/mnt/recovery/home/$USERNAME/" "/mnt/usb/$USERNAME/" || {
  error "Backup failed."; exit 1;
}
success "Backup completed successfully."

info "Starting HTTP server at http://<your-ip>:8080"
cd /mnt/usb
python3 -m http.server 8080

sync
sudo umount /mnt/usb
sudo umount /mnt/recovery
success "SystemSaver finished successfully. You can now remove your USB device."

exit 0
