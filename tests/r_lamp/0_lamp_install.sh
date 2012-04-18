#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

t_InstallPackage httpd mysql-server php
t_ServiceControl httpd restart
