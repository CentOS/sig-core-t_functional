#!/bin/bash

t_Log "Running $0 - checking if file package is installed"

t_InstallPackage file

t_Assert "rpm -q file"
