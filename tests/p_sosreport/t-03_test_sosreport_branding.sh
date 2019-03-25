#!/usr/bin/env bash
export SOS_REPORT_LOG="/tmp/sos-report-test.log"
export DISTRONAME="CentOS"
export SUPPORT_URL="https://wiki.centos.org/"

t_Log "$0 dupa"

cleanup(){
  t_Log "Removing the sosreport files"
  rm -f /tmp/sosreport*${MY_ID}*tar*  >/dev/null
  rm -f /var/tmp/sosreport*${MY_ID}*tar*  >/dev/null
  rm -f $SOS_REPORT_LOG
}

tests_el6(){
  t_Log "$0 Running sos branding tests for CentOS 6"
  MY_ID="${RANDOM}-$$"
  yes "$MY_ID"| sosreport  | tee  $SOS_REPORT_LOG
  # CentOS 6 has redhat url :((.
  grep -qvi 'red hat' $SOS_REPORT_LOG 
  t_CheckExitStatus $?
  grep -qi $DISTRONAME $SOS_REPORT_LOG 
  t_CheckExitStatus $?
}

tests_el7_plus(){
  t_Log "$0 Running sos branding tests for CentOS 7+"
  MY_ID="${RANDOM}-$$"
  yes "$MY_ID"| sosreport  | tee  $SOS_REPORT_LOG
  # CentOS 7 has fully patched sos branding.
  grep -qvi 'red hat' $SOS_REPORT_LOG
  t_CheckExitStatus $?
  grep -qvi 'redhat' $SOS_REPORT_LOG
  t_CheckExitStatus $?
  grep -qi $DISTRONAME $SOS_REPORT_LOG
  t_CheckExitStatus $?
  grep -qi $SUPPORT_URL $SOS_REPORT_LOG
  t_CheckExitStatus $?
}

if [ "$centos_ver" -gt 6 ]; then 
  tests_el7_plus /var/tmp
else # EL6
  tests_el6 /tmp
fi
cleanup
