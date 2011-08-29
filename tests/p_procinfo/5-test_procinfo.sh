#!/bin/bash
# Author: Steve Barnes (steve@echo.id.au)

t_Log "Running $0 - checking procinfo runs and returns non-zero exit status."

PROCINFO=`which procinfo`

[ "$PROCINFO" ] || { t_Log "Failed to find procinfo binary. Cannot continue."; exit $FAIL; }

$PROCINFO &>/dev/null

[ $? -eq 0 ] || { t_Log "Procinfo exited with non-zero status. That ain't good..."; exit $FAIL; }
