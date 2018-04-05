#!/bin/bash

filename="$(realpath $0)"

if [[ $EUID -ne 0 ]]; then
  echo "You must run this with superuser priviliges.  Re-running with sudo. " 2>&1
  sudo bash "$filename"
  exit 1
else
  echo "About to run dkms install steps..."
fi

cd rtl8812au
# Harish: to install dkms if missing
if [[ "$(command -v dkms)" == "" ]]; then
sudo dpkg -i dkms*.deb
fi

DRV_DIR=rtl8812au
DRV_NAME=rtl8812au
DRV_VERSION=5.1.5

sudo cp -r ../${DRV_DIR} /usr/src/${DRV_NAME}-${DRV_VERSION}

sudo dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms install -m ${DRV_NAME} -v ${DRV_VERSION}

#Harish: add the driver to the list of services to be autoloaded at startup
# This solves a big issue with wifi after everything is done..
if [[ "$(grep -i 8812au /etc/modules)" == "" ]]; then 
echo 8812au  | sudo tee -a /etc/modules  # echo 8812au | sudo tee -a /etc/modules
fi

# Harish: Most important to avoid physical replugging in the usb antenna
# All below solutions found after searching for "restart usb port/power-on/off usb port/ avoid pluggingin etc"
# The final solution turned out by "experiment" (no web resource helped) is: ">> modprobe 8812au"
# NOT WORKING:
# sudo nmcli networking on
# sudo nmcli networking off
# sudo service network-manager restart
# sudo nmcli radio wifi off
# WORKING:
sudo modprobe 8812au

RESULT=$?

echo "Finished running dkms install steps."

exit $RESULT

