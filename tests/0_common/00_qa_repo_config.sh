#!/bin/bash

# Disable the normal repositories and points to the QA repo
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.disabled
touch /etc/yum.repos.d/CentOS-Base.repo

cat >> /etc/yum.repos.d/CentOS-QA.repo << EOF
 
[QA-base]
name=CentOS-\$releasever - OS
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/os/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

[QA-updates]
name=CentOS-\$releasever - Updates
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/updates/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

[QA-extras]
name=CentOS-\$releasever - Extras
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/extras/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

[qa-centosplus]
name=CentOS-$releasever - CentOSPlus
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5

EOF

yum clean all
echo "Modifying yum repositories for QA purposes ..."
yum repolist

if [ $? -eq 0 ]; then 
  echo ' PASS'
else
  echo ' Fail'
  exit 1
fi 

