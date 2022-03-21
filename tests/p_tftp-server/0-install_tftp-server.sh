#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage tftp-server tftp
if [ "$centos_ver" -le "8" ] ; then
t_InstallPackage xinetd
fi

# Enable tftp
if [ "$centos_ver" -ge "8" ] ; then
cat <<__EOF__ >/etc/xinetd.d/tftp
service tftp
{
    socket_type		= dgram
    protocol		= udp
    wait			= yes
    user			= root
    server			= /usr/sbin/in.tftpd
    server_args		= -s /var/lib/tftpboot
    disable			= no
    per_source		= 11
    cps			= 100 2
    flags			= IPv4
}
__EOF__
else
sed -i 's/\(disable\s*=\ \)yes/\1no/' /etc/xinetd.d/tftp
fi

if [ "$centos_ver" -le "8" ] ; then
t_ServiceControl xinetd restart
else
service tftp start
fi
