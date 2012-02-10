#!/bin/bash
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_InstallPackage bind bind-utils

if (t_GetPkgRel basesystem | grep -q el5)
then
   cat > /etc/named.conf <<EOF
options {
        listen-on port 53 { 127.0.0.1; };
        listen-on-v6 port 53 { ::1; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        allow-query     { localhost; };
        recursion yes;

};

zone "." IN {
        type hint;
        file "named.root";
};

include "/etc/named.rfc1912.zones";

EOF


    cp /usr/share/doc/bind-*/sample/etc/named.rfc1912.zones /etc/
    cp -R /usr/share/doc/bind-*/sample/var/named/local* /var/named/
    cp -R /usr/share/doc/bind-*/sample/var/named/named.* /var/named/
    chown -R root:named /var/named/* /etc/named.*
fi

t_ServiceControl named start
