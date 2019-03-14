#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Author: Christoph Galuschka <christoph.galuschka@chello.at>
# RRD-sample from http://oss.oetiker.ch/rrdtool/doc/rrdcreate.en.html

if [ $centos_ver -ge 6 ]
then
    t_Log "Running $0 - rrdtool: create rrd, write values and retrieve values test."

    # creating test RRD

    FILE="/var/tmp/temperature.rrd"

    rrdtool create $FILE --step 1 DS:temp:GAUGE:600:-273:5000 RRA:AVERAGE:0.5:1:1200

    # insert value
    rrdtool update $FILE N:30

    # retrieve value and check
    WORKING=$(rrdtool fetch $FILE AVERAGE -s -80 |grep -c '3.0000000000e+01')

    # if $WORKING > 0 -> update and retrieval works
    if [ $WORKING > 0 ]; then ret_val=0;
    fi

    #remove RRD-File
    /bin/rm $FILE

    t_CheckExitStatus $ret_val
else
    echo "Skipped on CentOS 5"
fi
