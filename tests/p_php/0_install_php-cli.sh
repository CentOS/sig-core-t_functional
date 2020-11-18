#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - attempting to install php-cli."
t_SkipReleaseGreaterThan 7 'use module-aware tests instead'
t_InstallPackage php-cli

