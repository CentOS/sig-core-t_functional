#!/usr/bin/python
# Author: Athmane Madjoudj <athmanem@gmail.com>
#         Karanbir Singh <kbsingh@karan.org>
# Test default CentOS repos
# Note: since the -qa and CI setup will modify the
#       local repos, we need to run this tests
#       before those changes are made
from __future__ import print_function

import sys 
import datetime
import os

repos = []

try:
    import yum
    base = yum.YumBase()
    repos = base.repos.listEnabled()
except Exception:
    import dnf
    base = dnf.Base()
    base.read_all_repos()
    repos = list(base.repos.iter_enabled())


def getEnvironOpt(varname,defval):
    global now
    val=defval
    try:
        val = int(os.environ[varname])
    except KeyError:
        pass
    print("[+] %s -> %s:%d" % (now(),varname,val))
    return val

now = lambda: datetime.datetime.today().strftime("%c")
centos_default_repos = ['base']

with open('/etc/centos-release') as x:
    f = x.read()
    if 'Stream' in f:
        centos_default_repos = ['appstream', 'baseos', 'extras-common']


if getEnvironOpt('UPDATES',1):
    centos_default_repos.append('updates')
if getEnvironOpt('EXTRAS',1):
    centos_default_repos.append('extras')
if getEnvironOpt('CR',1):
    centos_default_repos.append('cr')
if getEnvironOpt('CENTOS_KERNEL',1):
    centos_default_repos.append('centos-kernel')
if getEnvironOpt('FASTTRACK',0):
    centos_default_repos.append('fasttrack')
if getEnvironOpt('CENTOSPLUS',0):
    centos_default_repos.append('centosplus')

print("[+] %s -> Check if non default repo is enabled" % now()) 
print(repos)
for repo in repos:
    if not repo.id in centos_default_repos:
        print('%s is enabled, should be disabled at this stage' % repo.id)
        print('[+] %s -> FAIL' % now())
        sys.exit(1)
print('[+] %s -> PASS' % now())
sys.exit(0)

