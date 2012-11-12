#!/bin/bash
# Author: Alice Kaerast <alice@kaerast.info>

t_Log "$0 test various hash sum tools"
echo "abcdefghijklmnopqrstuvwxyz1234567890" > /var/tmp/test-hashsums
/usr/bin/sha1sum /var/tmp/test-hashsums | grep -q f2cc9f1b642d1962f244ba7b0ab206649d5f153c
/usr/bin/sha224sum /var/tmp/test-hashsums | grep -q 00f95b5eb233164f4690f1963447fd42d2055ff6e660ee9b9a1943f4
/usr/bin/sha256sum /var/tmp/test-hashsums | grep -q e125e4eabe1eaac7988796098acb9e1eb8e81628ebf9937a4ec502411e461107
/usr/bin/sha384sum /var/tmp/test-hashsums | grep -q 8bfefc0ba5512fc53c55a99f2e5d686e3c63c33fb4553edb1ea8844543492d6db5845470e5d6366a09596fd5cbeffce9
/usr/bin/sha512sum /var/tmp/test-hashsums | grep -q 7ff71e3ce6dcabd62738506f37cba533fb42393981cb526c423ea24528a72d6561bc120eefbb679d831f49abc75de9c35829ea4ec2ea59f74903d15107f90b50
/usr/bin/md5sum /var/tmp/test-hashsums | grep -q 6c6506b6cb9e6d9a85ec9f8621d85864
t_CheckExitStatus $?

# Cleanup
rm /var/tmp/test-hashsums
