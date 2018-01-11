#!/bin/bash
# Author Br1an6
# Visit: https://github.com/Br1an6/CS-port-forwarding-for-MacOS

echo "[*] Check for homebrew"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "[*] Not found_Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else    
    echo "[*] Found Homebrew and Updating"
    brew update
    brew upgrade
    brew clean
fi

echo "[*] Check for upnpc"
if [[ $(which upnpc) == "upnpc not found" ]] ; then
    # Install Upnp client
    echo "[*] Not found_Installing Upnp client"
    brew install miniupnpc
fi

myip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
echo "[*] Start adding rules with IP: $myip"
# edit this part if needed
# upnpc -a IP port external-port protocal
upnpc -a $myip 27015 27015 TCP
upnpc -a $myip 27015 27015 UDP

# for removing rules uncommented the following two lines
# upnpc -d 27015 TCP
# upnpc -d 27015 UDP

echo "[*] Done"
