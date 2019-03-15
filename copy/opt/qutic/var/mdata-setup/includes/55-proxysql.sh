#!/bin/bash

if mdata-get proxysql_monitor_pwd 1>/dev/null 2>&1; then
  MONITOR_PWD=`mdata-get proxysql_monitor_pwd`
  sed -i "s#monitor_password=\"monitor\"#monitor_password=\"${MONITOR_PWD}\"#" /opt/local/etc/proxysql.cnf
fi

if mdata-get proxysql_admin_pwd 1>/dev/null 2>&1; then
  PROXY_ADMIN_PWD=`mdata-get proxysql_admin_pwd`
  sed -i "s#admin_credentials=\"admin:admin\"#admin_credentials=\"admin:${PROXY_ADMIN_PWD}\"#" /opt/local/etc/proxysql.cnf
  cat >> /root/.my.cnf << EOF
[client]
host = localhost
port = 3307
user = admin
password = ${PROXY_ADMIN_PWD}
prompt = 'Admin> '
EOF
chmod 0400 /root/.my.cnf
fi

if mdata-get proxysql_database_user 1>/dev/null 2>&1; then
  PROXY_DB_USER=`mdata-get proxysql_database_user`
  sed -i "s#db-username#${PROXY_DB_USER}#" /opt/local/etc/proxysql.cnf
fi

if mdata-get proxysql_database_pwd 1>/dev/null 2>&1; then
  PROXY_DB_PWD=`mdata-get proxysql_database_pwd`
  sed -i "s#db-password#${PROXY_DB_PWD}#" /opt/local/etc/proxysql.cnf
fi

svcadm enable svc:/pkgsrc/proxysql:default
