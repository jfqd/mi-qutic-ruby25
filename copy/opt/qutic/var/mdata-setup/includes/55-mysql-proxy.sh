if mdata-get proxy_source 1>/dev/null 2>&1; then
  PROXY_SOURCE=`mdata-get proxy_source`
  sed -i "s:PROXY_SOURCE:$PROXY_SOURCE:g" /opt/qutic/mysql-proxy/etc/my.cnf
  svcadm enable svc:/database/mysql-proxy:default
fi
