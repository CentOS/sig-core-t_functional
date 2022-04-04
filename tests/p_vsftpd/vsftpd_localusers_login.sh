#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - vsFTPd local user can login test."

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

# Add a test ftp user
{ userdel -rf ftptest; useradd ftptest && echo ftptest | passwd --stdin ftptest; } &>/dev/null

# Fix SELinux boolean
setsebool ftp_home_dir 1

echo -e "user ftptest\npass ftptest\nquit" | nc localhost 21 | grep -q "230 Login successful."

t_CheckExitStatus $?

userdel -rf ftptest
