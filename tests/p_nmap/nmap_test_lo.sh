#!/bin/sh
# Author: Christoph Galuschka <christoph.galuschka@chello.at>

t_Log "Running $0 - nmap querys loopback and checks for open ssh port"

nmap 127.0.0.1 | grep -qi ssh

t_CheckExitStatus $?
