#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - curl can access http-host and retrieve index.html."


if [ $SKIP_QA_HARNESS -eq 1 ]; then
  CHECK_FOR="CentOS CI test page"
  URL="http://ci.dev.centos.org/cstatic/"
else
  CHECK_FOR="Index of /srv"
  URL="http://repo.centos.qa/srv/CentOS/"
fi

t_Log "Querying ${URL}"
curl -s ${URL} | grep -q "${CHECK_FOR}"

t_CheckExitStatus $?
