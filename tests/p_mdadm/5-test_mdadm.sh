#!/bin/bash

t_Log "Running $0 - checking mdadm utility works and returns non-zero exit status."

# mdadm utility only available to root
[ ${EUID} -eq 0 ] || { t_Log "Not running as root, skipping this test. Non-fatal."; exit $PASS; }

MDADM=`which mdadm`

[ -z "${MDADM}" ] && { t_Log "Failed to find mdadm binary. That ain't good...."; exit $FAIL; }

# even with no meta devices available, this should still return a 0 exit status
${MDADM} --detail --scan &>/dev/null

[ $? -eq 0 ] || { t_Log "mdadm exited with non-zero status. That ain't good..."; exit $FAIL; }
