#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)
#	  Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install LAMP stack."

t_InstallPackage httpd mysql-server php
t_ServiceControl httpd restart
