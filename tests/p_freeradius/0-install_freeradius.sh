#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>

# Install freeradius
t_InstallPackage freeradius

# activate at boot
chkconfig radiusd on
# start daemon with default settings
t_ServiceControl radiusd start

