#!/bin/bash
# Just a check to determine full version (example 5.8) or just dist (example 6)

export qa_dist=$(rpm -q --queryformat '%{version}\n' $vendor-release)
export qa_releasever=$(rpm -q --queryformat '%{version}.' $vendor-release ; rpm -q --queryformat '%{release}\n' $vendor-release|cut -f 1 -d '.')
