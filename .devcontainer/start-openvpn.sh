#!/usr/bin/env bash
set -e

# Switch to the .devcontainer folder
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Create a temporary directory
mkdir -p openvpn-tmp
cd openvpn-tmp

# Touch file to make sure this user can read it
touch openvpn.log

# If we are running as root, we do not need to use sudo
sudo_cmd=""
if [ "$(id -u)" != "0" ]; then
    sudo_cmd="sudo"
fi

# Create a file containing the username and password
echo -e "KTern\n3So05bdo3" > auth.txt
chmod 600 auth.txt  # Ensure only the owner can read and write the file

# Start up the VPN client using the config stored in vpnconfig.ovpn by save-config.sh
nohup ${sudo_cmd} /bin/sh -c "openvpn --config vpnconfig.ovpn --auth-user-pass auth.txt --log openvpn.log &" | tee openvpn-launch.log
