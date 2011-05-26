#!/bin/bash

t_Log "Running $0 - checking procinfo runs and returns non-zero exit status."

PROCINFO=`which procinfo`

[ -z "${PROCINFO}" ] && { t_log "Failed to find procinfo binary. Cannot continue."; exit $FAIL; }

${PROCINFO} &>/dev/null

[ $? -eq 0 ] || { t_log "Procinfo exited with non-zero status. That ain't good..."; exit $FAIL; }
