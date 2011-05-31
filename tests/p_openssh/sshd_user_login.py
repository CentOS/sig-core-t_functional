#!/usr/bin/python
# Author: Athmane Madjoudj <athmanem@gmail.com>

import os,sys

def install_pexpect():
    if os.system("rpm -q pexpect") == 0:
        return 0
    else:
        return os.system("yum -y install pexpect")

def ssh_command (user, host, password, command):
    import pexpect
    ssh_newkey = 'Are you sure you want to continue connecting'
    child = pexpect.spawn('ssh -l %s %s %s'%(user, host, command))
    i = child.expect([pexpect.TIMEOUT, ssh_newkey, 'password: '])
    if i == 0: # Timeout
        print child.before, child.after
        return None
    if i == 1: # SSH does not have the public key. Just accept it.
        child.sendline ('yes')
        child.expect ('password: ')
        i = child.expect([pexpect.TIMEOUT, 'password: '])
        if i == 0: # Timeout
            print child.before, child.after
            return None       
    child.sendline(password)
    child.expect(pexpect.EOF)
    print child.before
    return child.before

if __name__ == '__main__':
    if not os.geteuid()==0:
        sys.exit("root privileges are required to run this script")
    else:
        print "[INFO] Trying to install pexpect ..."
        if install_pexpect() != 0:
            sys.exit("[FAIL] pexpect installation failed")
        print "[INFO] Adding new user ..."
        if os.system("userdel -rf sshtest; useradd sshtest && echo sshtest | passwd --stdin sshtest") != 0:
            sys.exit("[FAIL] can't add new user")
        try:
            ssh_command('sshtest','localhost','sshtest','/bin/ls')
        except Exception, e:
            sys.exit("[FAIL] SSH could not login")
        else:
            print "[INFO] SSH user login test: PASS"



