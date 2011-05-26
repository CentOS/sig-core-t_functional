#!/bin/bash

t_Log "Running $0 - checking strace runs and returns non-zero exit status."

STRACE=`which strace`

[ -z "${STRACE}" ] && { t_log "Failed to find strace. Cannot continue."; exit $FAIL; }

${STRACE} ls &>/dev/null

[ $? -eq 0 ] || { t_log "Strace exited with non-zero status. That ain't good..."; exit $FAIL; }
