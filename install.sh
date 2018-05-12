#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	command -v curl >/dev/null 2>&1 || {
		echo >&2 "Installing Curl..."
		sudo apt-get install -y curl 2>&1 >/dev/null
	}

	read -p 'Username: ' username
	read -sp 'Password: ' password

	sudo cp autologin /etc/network/if-up.d

	sudo sed -i "s/yourusername/${username}/g" /etc/network/if-up.d/autologin
	sudo sed -i "s/yourpassword/${password}/g" /etc/network/if-up.d/autologin

	sudo chmod +x /etc/network/if-up.d/autologin

	echo
fi
