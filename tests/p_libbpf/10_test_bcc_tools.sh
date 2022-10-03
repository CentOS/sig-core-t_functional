#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>
# 	  Christoph Galuschka <tigalch@tigalch.org>

t_Log "Running $0 - bcc-tools: argdist test"

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

/usr/share/bcc/tools/argdist -i 1 -n 5 -C 'p:c:umask(u32 mask):u32:mask'
