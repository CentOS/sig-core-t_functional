#!/usr/bin/env bash

t_Log "$0 Remove sos package"
yum remove -y sos >/dev/null 2>&1
t_Log "$0 Remove all sos.* temporary directories"
rm -rf  /tmp/sos.*  >/dev/null
rm -rf /var/tmp/sos.*  >/dev/null
