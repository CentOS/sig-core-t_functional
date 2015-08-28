#!/usr/bin/python
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Karanbir Singh <kbsingh@karan.org>
# Test default CentOS repos
# Note: since the -qa and CI setup will modify the
#       local repos, we need to run this tests
#       before those changes are made

import yum
import sys 
import datetime
import os

yb = yum.YumBase()

try:
    fasttrack = int(os.environ['FASTTRACK'])
except KeyError:
    fasttrack = 0

if fasttrack:
    centos_default_repos = ['base','extras','updates','cr','fasttrack']
else:
    centos_default_repos = ['base','extras','updates','cr']

now = lambda: datetime.datetime.today().strftime("%c")
print "[+] %s -> Check if non default repo is enabled" % now() 
for repo in yb.repos.listEnabled():
    if not repo.id in centos_default_repos:
        print '%s is enabled, should be disabled at this stage' % repo.id
        print '[+] %s -> FAIL' % now()
        sys.exit(1)
print '[+] %s -> PASS' % now()
sys.exit(0)

