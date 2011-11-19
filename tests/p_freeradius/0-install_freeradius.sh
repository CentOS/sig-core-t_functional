#!/bin/bash
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

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
  # as the basic test works without these, the eap settings and 2 sites-available will be removed for the test and later restored
  # Check if we allready did this
  if [ ! -e /etc/raddb/radiusd.conf.orig ]
    then
    # File not yet copied
    /bin/cp -a /etc/raddb/radiusd.conf /etc/raddb/radiusd.conf.orig
    grep -iv eap /etc/raddb/radiusd.conf.orig > /etc/raddb/radiusd.conf
  fi
  rm -rf /etc/raddb/sites-enabled/control-socket
  rm -rf /etc/raddb/sites-enabled/inner-tunnel
  # /etc/raddb/sites-configured will be changed to include only basic files-authentication
  # Check if we allready did this
  if [ ! -e /etc/raddb/sites-available/default.orig ]
    then
    # File not yet copied
    /bin/cp -a /etc/raddb/sites-available/default /etc/raddb/sites-available/default.orig
  fi
cat > /etc/raddb/sites-available/default <<EOF
authorize {
        files
}
authenticate {
}
EOF
fi

#  t_ServiceControl radiusd start
