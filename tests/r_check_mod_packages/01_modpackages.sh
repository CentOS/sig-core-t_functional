#!/bin/nash
# Author: Johnny Hughes <johnny@centos.org>
# Note: This test is only for Pre Updates testing prior to releasing on CentOS

if [ $SKIP_QA_HARNESS -eq 1 ] && [ "$PRE_UPDATES" != "1" ] ; then
    t_Log "Skip this test in non QA harness environment"
    ret_val=0
else
  ret_val=0
  if [ "$centos_ver" = "7" ] ; then
   t_Log "Checking current repositories for .el7.centos on modified files"
   yum clean all
    for pkg in PackageKit abrt apache-commons-net anaconda basesystem centos-indexhtml centos-logos centos-release chrony compat-glibc curl dhcp docker firefox glusterfs grub2 httpd initial-setup ipa-client kabi-yum-plugins kde-settings libreport ntp oscap-anaconda-addon openssl098e plymouth redhat-rpm-config redhat-lsb scap-security-guide shim-unsigned sos subscription-manager system-config-date system-config-kdump thunderbird xulrunner yum 
      do 
         has_centos=$(yum list $pkg | grep '.el7.centos')
         if [ "$has_centos" == "" ]; then 
           echo $pkg missing .el7.centos
           ret_val=1
         fi
      done
  else
    t_Log "This test only for CentOS-7, skipping Modified Packages test ..."
    ret_val=0
  fi


  t_CheckExitStatus $ret_val
fi
