<<<<<<< HEAD
# Realtek RTL8812AU Driver

# rtl8812au-wifi-adapter
The Linux wifi driver had to be searched on github for self-compile and install. This is for a wifi adapter that was bought on eBay with 5dB antenna and 802.11ac support. There was no such problem to use this on windows though.

Simply run the below as root:
sudo ./dkms-install.sh

If dkms not available, the script will automatically install a local .deb copy of dkms package.


## Removal of Driver
In order to remove the driver from your system open a terminal in the directory with the source code and execute the following command:
```
sudo ./dkms-remove.sh
```

## Note
For Ubuntu 17.04 add the following lines
```
[device]
wifi.scan-rand-mac-address=no
```
at the end of file /etc/NetworkManager/NetworkManager.conf and restart NetworkManager with the command:
```
sudo service NetworkManager restart
```
