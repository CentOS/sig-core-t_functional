#!/bin/sh

if [ "$CONTAINERTEST" -eq "1" ]; then
    t_Log "Running in container -> SKIP"
    exit 0
fi

keytypes="rsa"
if [ "$centos_ver" -lt 8 ] ; then
keytypes="$keytypes dsa"
fi

for KeyType in $keytypes; do
	userdel -rf sshtest; useradd sshtest && echo sshtest | passwd --stdin sshtest
	if [ $centos_ver -ge 8 ]; then
		runuser -l sshtest -c "echo | ssh-keygen -q -t ${KeyType} -b 2048 -f ~/.ssh/id_${KeyType}" > /dev/null
	else
		runuser -l sshtest -c "echo | ssh-keygen -q -t ${KeyType} -b 1024 -f ~/.ssh/id_${KeyType}" > /dev/null
	fi
	runuser -l sshtest -c "cat ~/.ssh/*pub > ~/.ssh/authorized_keys && chmod 600 ~/.ssh/*keys" > /dev/null
	cp ./tests/p_openssh/_helper_sshd_user_login-with-key.expect /home/sshtest/ && chmod +x /home/sshtest/*.expect

	# Create a test file
	TestString=$( mktemp -u )
	echo $TestString > /home/sshtest/ssh_test_file

	t_Log "Running $0 - SSH User can login using ${KeyType} key."
	runuser -l sshtest -c "~/_helper_sshd_user_login-with-key.expect" | grep ${TestString}  > /dev/null 2>&1
	t_CheckExitStatus $?
	userdel -rf sshtest
done
