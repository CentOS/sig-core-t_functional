#!/bin/bash
# determining which packages we need to install from Base+Updates before trying the update against CR

# generate local cache
/tmp/t_functional/tests/0_common/00_qa_repo_config.sh
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.disabled
yum --enablerepo=qa-cr list >/dev/null 2>&1 
sqlite3 $(find /var/cache/yum/$(t_GetArch)/$(t_DistCheck)/qa-cr/ -iname '*.sqlite*') 'select name from packages;' > /tmp/packages.list
t_Log "Installing needed packages from Base"
yum install -y -d0 $(cat /tmp/packages.list) 1>/dev/null
t_CheckExitStatus $?
# remove centos-release-cr from the packages list
yum remove -y -d0 centos-release-cr

t_Log "Updating packages with the CR repo"
t_InstallPackage yum-presto
yum install --enablerepo=qa-cr -y -d0 $(cat /tmp/packages.list) 
t_CheckExitStatus $?
yum remove -y -d0 centos-release-cr
mv /etc/yum.repos.d/CentOS-Base.repo.disabled /etc/yum.repos.d/CentOS-Base.repo
mv /etc/yum.repos.d/CentOS-QA.repo /etc/yum.repos.d/CentOS-QA.repo.disabled
