#!/bin/bash

# Function to detect the operating system
detect_os() {
    if [ "$(uname)" == "Darwin" ]; then
        echo "macos"
    elif [ -f "/etc/os-release" ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

# Install Ansible based on the detected OS
install_ansible() {
    local os
    os=$(detect_os)

    case "$os" in
        'macos')
            echo "Installing Ansible on macOS..."
            sudo easy_install pip
            sudo pip install ansible --quiet
            ;;
        'ubuntu')
            echo "Installing Ansible on Ubuntu..."
            sudo apt update
            sudo apt install -y software-properties-common
            sudo add-apt-repository --yes --update ppa:ansible/ansible
            sudo apt install -y ansible
            ;;
        'fedora')
            echo "Installing Ansible on Fedora..."
            sudo dnf install -y ansible
            ;;
        'opensuse-leap' | 'opensuse-tumbleweed')
            echo "Installing Ansible on openSUSE..."
            sudo zypper install -y ansible
            ;;
        *)
            echo "Unsupported OS detected: $os"
            exit 1
            ;;
    esac
}

install_ansible
