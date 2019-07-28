#!/bin/bash
# Author: Dries Verachtert <dries.verachtert@dries.eu>

t_Log "Running $0 - test python-iniparse"

if [ "$centos_ver" -ge 8 ] ; then
PYTHON=python3
else
PYTHON=python
fi

TESTINI=`mktemp`

# Test contents: a part of /etc/yum.conf
cat > $TESTINI <<'EOF'
[main]
cachedir=/var/cache/yum/$basearch/$releasever
keepcache=0
debuglevel=2
logfile=/var/log/yum.log
EOF

cat << EOF | $PYTHON - $TESTINI | grep -q '/var/log/yum.log'
import sys
from iniparse import INIConfig

cfg = INIConfig(open(sys.argv[1]))
print (cfg.main.logfile)
EOF
t_CheckExitStatus $?

# A second test with multiple sections
cat > $TESTINI <<'EOF'
# comment 1
[section1]
# comment 2
section1var1=val1
[section2]
# comment 3
[section3]
section3var1=val2
section3var2=val3
EOF

cat << EOF | $PYTHON - $TESTINI | grep -q "\['section1', 'section2', 'section3'\] val1 val2 val3"
import sys
from iniparse import INIConfig

cfg = INIConfig(open(sys.argv[1]))
print (str(list(cfg)) + ' ' + cfg.section1.section1var1 + ' ' + cfg.section3.section3var1 + ' ' + cfg.section3.section3var2)
EOF

t_CheckExitStatus $?

rm -f $TESTINI
