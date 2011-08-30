#!/usr/bin/python
# Author: Athmane Madjoudj <athmanem@gmail.com>
# Test default CentOS repos

import yum
import sys 

yb = yum.YumBase()
centos_default_repos = ['base','extras','updates']
print "Check if non default repo is enabled"
for repo in yb.repos.listEnabled():
    if not repo.id in centos_default_repos:
        print '-> FAIL'
        sys.exit(1)
print '-> PASS'
sys.exit(0)

