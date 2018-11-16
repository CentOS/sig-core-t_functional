#!/usr/bin/python -tt
'''
Author: Brian Stinson <brian@bstinson.com>
Check rpminfo attributes that must be set before release in the repositories (e.g. Vendor, Packager)
'''

from __future__ import print_function, with_statement
import os
import sys
import yum

from datetime import datetime
from fnmatch import fnmatch


def log(methodstring):
    localtime = datetime.now()
    print("[+] {0} -> {1}".format(localtime.strftime("%a %b %e %H:%M:%S %Z %Y"), methodstring))


def fail(failstring):
    log('FAIL {0}'.format(failstring))


def skip(skipstring):
    log('SKIP {0}'.format(skipstring))

log('Running check-rpminfo.py - Check rpminfo Attributes')

# Set the required attributes and their values here. You may use shell-style
# globs in the value if necessary.
required_attrs = {
    'vendor': 'CentOS',
    'packager': '*centos.org*',
    }

# special_overrides is a dictionary of packages and a list of attributes
# to ignore for that package. When updating this list add a comment to
# the line describing why the override is in place
special_overrides = {
    'epel-release': ['vendor', 'packager'],                   #Rebuilt directly from Fedora, so the vendor remains Fedora Project
    'redhat-support-lib-python': ['vendor'],
    'redhat-support-tool': ['vendor'],
    }

# you can also add the NVR, and the attribute to ignore to the special_overrides.txt file
with open(os.path.join(sys.path[0],'special_overrides.txt'),'r') as thefile:
    for line in thefile.readlines():
        if not line.strip() or line.startswith('#'):
            continue
        pkg, ignoreattr = map(str.strip,line.split(':'))
        special_overrides.setdefault(pkg, []).append(ignoreattr)

yb = yum.YumBase()
yb.conf.cache = 0

yb.repos.doSetup()
log("Checking repos: {0}".format(', '.join([r.name for r in yb.repos.listEnabled()])))

sack = yb.pkgSack

finalret = 0
for pkg in sack:
    for attr, val in required_attrs.iteritems():
        nvr = '{0}-{1}-{2}'.format(pkg['name'], pkg['version'], pkg['release'])
        nvra = '{0}-{1}-{2}.{3}'.format(pkg['name'], pkg['version'], pkg['release'], pkg['arch'])
        if pkg.name in special_overrides:
            if attr in special_overrides[pkg.name]:
                skip('{0}: {1} listed in special_overrides'.format(pkg.remote_path, attr))
                continue
        elif nvr in special_overrides:
            if attr in special_overrides[nvr]:
                skip('{0}: {1} listed in special_overrides'.format(pkg.remote_path, attr))
                continue
        elif nvra in special_overrides:
            if attr in special_overrides[nvra]:
                skip('{0}: {1} listed in special_overrides'.format(pkg.remote_path, attr))
                continue

        if not pkg[attr]:
            fail('{0}: Missing {1}'.format(pkg.remote_path, attr))
            finalret = 1
            continue

        if not fnmatch(str.upper(pkg[attr]), str.upper(val)):
            fail('{0}: {1}: {2} does not match {3}'.format(pkg.remote_path, attr, pkg[attr], val))
            finalret = 1

sys.exit(finalret)
