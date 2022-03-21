#!/usr/bin/python
# Author: Athmane Madjoudj <athmanem@gmail.com>
# A script that search for CentOS branding issues in installed rpm
from __future__ import print_function
    
import rpm
import sys
import re
    
def is_valid_changelog_entry(entry):
    regex = re.compile(r"\w+\ ?\w*\ ?<\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b>\ ?-?\ ?[\w_\.]+-[\w_\.]+")
    if regex.match(entry) is None:
        return False
    else:
        return True

def main():
    ts=rpm.ts()
    mi=ts.dbMatch()
    # Comment the following line to check all rpms
    mi.pattern("release", rpm.RPMMIRE_GLOB, "*centos*")
    ret=True
    print("Searching for CentOS branding issues in installed rpm...")
    for hdr in mi:
        if hdr['buildhost'][-11:] != '.centos.org':
            print("  Build host is not centos.org machine in: %s" % hdr['name'])
            ret=False
        if hdr['vendor'] != 'CentOS':
            print("  Vendor is not CentOS in: %s" % hdr['name'])
            ret=False
        if hdr['packager'] != 'CentOS BuildSystem <http://bugs.centos.org>':
            print("  Packager is not CentOS BuildSystem in: %s" % hdr['name'])
            ret=False
        try:
            changelog = hdr['changelogname'][0]
            if not is_valid_changelog_entry(changelog):
                 print("  Bad changelog entry in: %s" % hdr['name'])
                 ret=False
        except Exception, e:
            print("  Errors found when reading changelog entry of: %s" % hdr['name'])
            ret=False
    return ret
    
if __name__ == "__main__":
    if main():  
        print "All tests PASSED"
        sys.exit(0)
    else:
        print "Some tests FAILED"
        sys.exit(1)
