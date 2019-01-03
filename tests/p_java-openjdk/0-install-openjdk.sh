#!/bin/bash
# Author: Pablo Greco <pablo@fliagreco.com.ar>
# Based on java-1.6.0-openjdk test from Christoph Galuschka <christoph.galuschka@chello.at>

. $(dirname "$0")/p_java-openjdk-common

t_Log "Running $0 - installing openjdk runtime/development environment."

for i in $JAVA_VERSIONS;do
	t_InstallPackage java-$i-openjdk java-$i-openjdk-devel
done
