#!/bin/bash

t_Log "Running $0 - modifying yum repositories for QA purposes."

# Disable the normal repositories and points to the QA repo
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.disabled
sed -i s#gpgcheck=1#gpgcheck=1\\nenabled=0#g /etc/yum.repos.d/CentOS-Base.repo



cat << EOF > /etc/yum.repos.d/CentOS-QA.repo
 
[QA-base]
name=CentOS-\$releasever - OS
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/os/\$basearch/
gpgcheck=0
enabled=1
igpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever

[QA-updates]
name=CentOS-\$releasever - Updates
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/updates/\$basearch/
gpgcheck=0
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever

[QA-extras]
name=CentOS-\$releasever - Extras
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/extras/\$basearch/
gpgcheck=0
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever

[qa-centosplus]
name=CentOS-\$releasever - CentOSPlus
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/centosplus/\$basearch/
gpgcheck=0
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever

[qa-cr]
name=CentOS-\$releasever - CR
baseurl=http://repo.centos.qa/srv/CentOS/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever


EOF

yum clean all
yum repolist >/dev/null 2>&1

t_CheckExitStatus $?

