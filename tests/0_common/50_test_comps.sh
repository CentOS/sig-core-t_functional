#!/bin/bash
# Author: Alex Iribarren <Alex.Iribarren@cern.ch>

t_Log "Running $0 - testing comps.xml groups"

# Get **all** the group IDs
ALL_GROUPS=`dnf group list -v --hidden | grep '^   ' | sed 's/.*(\(.*\))$/\1/'`

for GROUP in $ALL_GROUPS; do
    t_Log " - testing group $GROUP"

    # Pretend to install the group, but all we really want is the solver debug data
    dnf --installroot=/tmp group --releasever $centos_ver install --assumeno --debugsolver $GROUP >/dev/null

    # Check the solver results to see if there are problems
    grep -qw '^problem' debugdata/rpms/solver.result
    RES=$?

    # Clean up the debugdata
    rm -rf debugdata/

    # If 'problem' was not found in the results, grep returns 1 and we're happy
    if [[ $RES -eq 1 ]]; then
        t_CheckExitStatus 0
    else
        t_CheckExitStatus 1
    fi
done
