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
echo >> /tmp/yum-cleanup
echo 'install ' >> /tmp/cleanp
cat req_list | sed -e 's/^/install /' >> /tmp/yum-cleanup

yum -y shell /tmp/yum-cleanup
yum -y reinstall \*
if [ `uname -m` = 'x86_64' ]; then
  yum -y erase *.i?86
fi

cd /etc
for x in `find . -maxdepth=2 -type f -name \*.rpmnew`; do
  a=$( echo $x | sed -e 's/.rpmnew//' )
  rm -f $a
  mv $x $a
done
