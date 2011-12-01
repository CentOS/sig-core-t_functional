#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - crontab will run weekly jobs"

# Add a test cron
cat > /etc/cron.weekly/test.sh<<EOF
#!/bin/sh
echo 'test'
EOF

chmod +x /etc/cron.weekly/test.sh

run-parts /etc/cron.weekly | grep -q "test" 


t_CheckExitStatus $?
