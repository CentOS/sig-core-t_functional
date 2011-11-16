#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@tiwag.at>

# Install freeradius
# On C5 both freeradius and freeradius2 are provided, however only freeradius2-utils are provided as well
# so we will install freeradius2 on C5 and freeradius (being freeradius2) on C6
if (t_GetPkgRel basesystem | grep -q el6)
then
  #Install Freeradius (V2)
  t_InstallPackage freeradius
else
  #Install Freeradius2
  t_InstallPackage freeradius2
fi

# activate at boot
chkconfig radiusd on
# start daemon with default settings
if (t_GetPkgRel basesystem | grep -q el6)
then
  t_ServiceControl radiusd start
else
  # C5 has an eap-setting in radiusd.conf and 3 "sites-available" which prevent successfull start (probably missing some dep)
  # as the basic test works without these, the eap setting 2 sites-available will be removed for the test and later restored
  sed -i 's/.*INCLUDE\ eap\.conf/# INCLUDE eap.conf/g' /etc/raddb/radiusd.conf
  rm -rf /etc/raddb/sites-enabled/control-socket
  rm -rf /etc/raddb/sites-enabled/inner-tunnel
  # /etc/raddb/sites-configured will be changed to remove all traces of eap
  /bin/cp -a /etc/raddb/sites-available/default /etc/raddb/sites-available/default.orig
  head -n 138 /etc/raddb/sites-available/default.orig | grep -v eap > /etc/raddb/sites-available/default
  tail -n 416 /etc/raddb/sites-available/default.orig | grep -v eap >> /etc/raddb/sites-available/default
  sed -i 's/.*ok\ \=\ return/# ok = return/g' /etc/raddb/sites-available/default
  t_ServiceControl radiusd start
fi

