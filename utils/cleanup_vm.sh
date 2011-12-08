#!/bin/sh

# you will almost never want to run this script.
# $1 = file name ( full path ) with rpms to retain

rm /tmp/yum-cleanup

for f in `rpm -qa`; do 
  pn=$(rpm --qf "|%{name}|" -q $f)
  if [ `grep $pn $1 | wc -l ` -lt 1 ] ; then 
    echo 'erase ' $f  >> /tmp/yum-cleanup 
  fi
done
cat $1 | sed -e 's/|//g' | sed -e 's/^/install /' >> /tmp/yum-cleanup

if [ `uname -m` = 'x86_64' ]; then
  yum -y erase *.i?86
  yum -y --exclude=*.i?86 shell /tmp/yum-cleanup
else
  yum -y shell /tmp/yum-cleanup
fi

yum -y reinstall \*
cd /etc
for x in `find . -maxdepth 2 -type f -name \*.rpmnew`; do
  a=$( echo $x | sed -e 's/.rpmnew//' )
  rm -f $a
  mv $x $a
done

# Package specific cleanup 
# Clean pgsql data dir
(rpm -q postgresql | grep -q el6) && /bin/rm -rf /var/lib/pgsql/

# Keep yum cache
sed -i 's/keepcache=0/keepcache=1/' /etc/yum.conf

## EOF
