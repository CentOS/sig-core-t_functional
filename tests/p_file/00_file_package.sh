#!/bin/bash

t_Log "Running $0 - checking if file package is installed"

t_Assert "rpm -q file"
