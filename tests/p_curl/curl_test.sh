#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - curl can access http-host and retrieve index.html."

CHECK_FOR="CentOS Wiki"

if [ $SKIP_QA_HARNESS ]; then
  URL="http://wiki.centos.org/"
else
  URL="http://repo.centos.qa/srv/CentOS/"
fi

t_Log "Querying ${URL}"
curl -s ${URL} | grep -q "${CHECK_FOR}"

t_CheckExitStatus $?
