#!/bin/sh
# Author: Piyush Kumar <piykumar@gmail.com>
# Author: Munish Kumar <munishktotech@gmail.com>
# Author: Ayush Gupta <ayush.001@gmail.com>
# Author: Konark Modi <modi.konark@gmail.com>
# 	  Christoph Galuschka <tigalch@tigalch.org>


t_Log "Running $0 - bcc-tools: argdist test"

if [ -z "$CONTAINERTEST" ] && [ "$centos_ver" -ge 8 ]; then
    /usr/share/bcc/tools/argdist -i 1 -n 5 -C 'p:c:umask(u32 mask):u32:mask'
else
    t_Log "Running in container -> SKIP"
    exit 0
fi
