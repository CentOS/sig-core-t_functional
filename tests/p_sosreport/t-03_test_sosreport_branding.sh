#!/usr/bin/env bash

# Author: Alex Baranowski <aleksander.baranowski@yahoo.pl>
# This test makes sosreport. Then checks for branding.

export SOS_REPORT_LOG="/tmp/sos-report-test.log"
export DISTRONAME="CentOS"
export SUPPORT_URL="https://wiki.centos.org/"

t_Log "$0 start sos branding test"

cleanup(){
    t_Log "Removing the sosreport files"
    rm -f /tmp/sosreport*${MY_ID}*tar*  >/dev/null
    rm -f /var/tmp/sosreport*${MY_ID}*tar*  >/dev/null
    rm -f $SOS_REPORT_LOG
}

tests_el6(){
    t_Log "$0 Running sosreport branding tests for CentOS 6"
    MY_ID="${RANDOM}-$$"
    MY_STATUS=0
    yes "$MY_ID"| sosreport  | tee  $SOS_REPORT_LOG
    # CentOS 6 has redhat url :((.
    grep -qvi 'red hat' $SOS_REPORT_LOG 
    MY_STATUS+=$((MY_STATUS+$?))
    grep -qi $DISTRONAME $SOS_REPORT_LOG 
    MY_STATUS+=$((MY_STATUS+$?))
    cleanup
    t_CheckExitStatus $MY_STATUS
}

tests_el7_plus(){
    t_Log "$0 Running sosreport branding tests for CentOS 7+"
    MY_ID="${RANDOM}-$$"
    MY_STATUS=0
    yes "$MY_ID"| sosreport  | tee  $SOS_REPORT_LOG
    # CentOS 7 and 8 have fully patched sos branding.
    grep -qvi 'red hat' $SOS_REPORT_LOG
    MY_STATUS+=$((MY_STATUS+$?))
    grep -qvi 'redhat' $SOS_REPORT_LOG
    MY_STATUS+=$((MY_STATUS+$?))
    grep -qi $DISTRONAME $SOS_REPORT_LOG
    MY_STATUS+=$((MY_STATUS+$?))
    grep -qi $SUPPORT_URL $SOS_REPORT_LOG
    MY_STATUS+=$((MY_STATUS+$?))
    cleanup
    t_CheckExitStatus $MY_STATUS
}

if [ "$centos_ver" -gt 6 ]; then 
    tests_el7_plus /var/tmp
else
    tests_el6 /tmp
fi
