#!/bin/bash
# Author: Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 -  install package enscript, ghostscript and pdftotext"

# Workarround for post scriptlet non-fatal errors
yum -y remove bitstream-vera* liberation*
#
t_InstallPackage fontconfig @fonts
t_InstallPackage enscript ghostscript poppler-utils

