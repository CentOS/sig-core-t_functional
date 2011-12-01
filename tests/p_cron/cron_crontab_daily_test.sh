#!/bin/sh
# Author: Athmane Madjoudj <athmanem@gmail.com>

t_Log "Running $0 - crontab will run daily jobs."

# Add a test cron
cat > /etc/cron.daily/test.sh<<EOF
#!/bin/sh
echo 'test'
EOF
chmod +x /etc/cron.daily/test.sh


run-parts /etc/cron.daily | grep -q "test"


t_CheckExitStatus $?
