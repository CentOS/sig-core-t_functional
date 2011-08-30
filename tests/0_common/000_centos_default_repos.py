#!/usr/bin/python
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Karanbir Singh <kbsingh@karan.org>
# Test default CentOS repos

import yum
import sys 

yb = yum.YumBase()
centos_default_repos = ['base','extras','updates']
print "Check if non default repo is enabled"
for repo in yb.repos.listEnabled():
    if not repo.id in centos_default_repos:
        print '%s is enabled, should be disabled at this stage' % repo.id
        print '-> FAIL'
        sys.exit(1)
print '-> PASS'
sys.exit(0)

