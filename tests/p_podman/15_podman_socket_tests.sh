#!/bin/bash

# Author: Carlos Rodriguez-Fernandez <carlosrodrifernandez@gmail.com>

t_Log "Running $0 - podman socket tests"

if [ "$centos_ver" -lt 8 ] ; then
  t_Log "SKIP $0: only run on centos stream 8 or greater"
  exit 0
fi

useradd podman-remote-test
loginctl enable-linger podman-remote-test
output_file=$(mktemp)
trap "loginctl terminate-user podman-remote-test && loginctl disable-linger podman-remote-test && sleep 1 && userdel -r podman-remote-test && rm -f ${output_file}" EXIT

# give time to loginctl linger
sleep 3

su -l podman-remote-test > ${output_file} 2>&1 <<EOF
set -e
export XDG_RUNTIME_DIR=/run/user/\$(id -u)
systemctl --user enable --now podman.socket
podman --url unix://run/user/\$(id -u)/podman/podman.sock run --name simple-test-with-port-mapping -d -p 8080:80 docker.io/nginx
pid=\$(systemctl --user show --property MainPID --value podman.service)
while [ "\${pid}" -ne 0 ] && [ -d /proc/\${pid} ]; do sleep 1; echo "Waiting for podman to exit"; done
echo "Continuing"
podman --url unix://run/user/\$(id -u)/podman/podman.sock ps | grep -q -e simple-test-with-port-mapping
podman --url unix://run/user/\$(id -u)/podman/podman.sock container rm -f simple-test-with-port-mapping
systemctl --user disable --now podman.socket
EOF

if [ "$?" -ne 0 ]; then
  cat ${output_file}
  t_CheckExitStatus 1
fi
t_CheckExitStatus 0
