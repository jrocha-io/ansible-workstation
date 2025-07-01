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
#python3 -m pip install --user ansible

# Verify installations
echo "✅ Verification:"
echo "Git: $(git --version)"
echo "Python: $(python3 --version)"
echo "Ansible: $(ansible --version | head -n1)"

# Add ~/.local/bin to PATH if needed
echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
source ~/.bashrc

echo "🎉 Bootstrap complete! Ready for Ansible setup."
echo "Next steps:"
echo "1. Cloning ansible-workstation repository"
git clone https://github.com/jrocha-io/ansible-workstation.git ~/ansible-workstation
echo "2. Run: ansible-playbook setup.yml"
cd ~/ansible-workstation
ansible-playbook playbook.yml --ask-become-pass

curl -sL https://raw.githubusercontent.com/yourusername/bootstrap/main/bootstrap.sh | bash
