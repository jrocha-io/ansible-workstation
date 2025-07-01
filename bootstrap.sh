#!/bin/bash

# This script prepares a new Debian/Ubuntu-based system to run the Ansible workstation playbook

# --- Exit on any error ---
set -e

echo "🚀 Setting up development workstation..."

echo "Updating package list and upgrading existing packages..."
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y \
    software-properties-common \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    pipx \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    unzip

echo "Install Ansible with pip (easiest for latest version)"
pipx install --include-deps ansible
pipx ensurepath
source ~/.bashrc

# Verify installations
echo "✅ Verification:"
echo "Git: $(git --version)"
echo "Python: $(python3 --version)"
echo "Ansible: $(ansible --version | head -n1)"

echo "Cloning ansible-workstation repository..."
git clone https://github.com/jrocha-io/forge-my-machine.git ~/forge-my-machine
cd ~/forge-my-machine
echo "🎉 Bootstrap complete! Ready for Ansible setup."
echo "Go to https://github.com/jrocha-io/forge-my-machine/ for more info.
