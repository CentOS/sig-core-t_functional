#!/usr/bin/env python
import sys
import selinux.audit2why as audit2why

print "Testing audit2why for policy mismatch ..."

try:
  audit2why.init()
except:
  sys.exit(1)
  
sys.exit(0)

