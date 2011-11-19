#!/bin/sh

# you will almost never want to run this script.

echo -n 'erase ' > /tmp/yum-cleanup 
for f in `rpm -qa`; do 
  pn=$(rpm --qf "%{name}\n" -q $f)
  if [ `grep $pn c5_req_list | wc -l ` -lt 1 ] ; then 
    echo -n $f ' ' >> /tmp/yum-cleanup 
  fi
done
echo >> /tmp/yum-cleanup
echo 'install ' >> /tmp/cleanp
cat req_list | tr '\n' ' ' >> /tmp/yum-cleanup

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
