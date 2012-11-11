#! /bin/bash

# author: Christoph Galuschka <christoph.galuschka@chello.at>
# This script will create a file with all packages which get installed by the tests

grep t_InstallPackage ../*/*/* | grep -v export | grep -v functions | egrep -v '.*\$.*' |\
cut -d ':' -f 2 | sed 's/^ *//g' | tr -s ' ' | sed 's/t_InstallPackage/yum\ install\ \-y\ \-d0/g' > /var/tmp/t_functional_packagelist

# running the resulting file with '/bin/bash /var/tmp/t_functional_packagelist' will install all packages required by the current tests.
