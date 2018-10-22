# add passenger related cronjobs
CRON='0 3 * * * rm /var/tmp/buffer.* 2>/dev/null || true
0,10,20,30,40,50 * * * * /usr/bin/mv /tmp/passenger-error* /var/tmp 2>/dev/null || true
0 4 * * * /usr/bin/find /var/tmp/ -mmin +1440 | /opt/local/bin/grep passenger-error | /usr/bin/xargs /usr/bin/rm
15 3  * * 0 /usr/sbin/svcadm restart apache
'
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab
