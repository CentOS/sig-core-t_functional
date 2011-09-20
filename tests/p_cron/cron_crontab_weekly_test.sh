#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - crontab test."

# Add a test cron
cat > /etc/cron.weekly/test.sh<<EOF
#!/bin/sh
echo 'test'
EOF

chmod +x /etc/cron.weekly/test.sh

run-parts /etc/cron.weekly
tail /var/log/cron | grep -q 'run-parts(/etc/cron.weekly)'


t_CheckExitStatus $?
