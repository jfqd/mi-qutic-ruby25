if mdata-get proxysql_admin_uid 1>/dev/null 2>&1; then
  if mdata-get proxysql_admin_pwd 1>/dev/null 2>&1; then
    PROXY_UID=`mdata-get proxysql_admin_uid`
    PROXY_PDW=`mdata-get proxysql_admin_pwd`
    sed -i "s#admin_credentials=\"admin:admin\"#admin_credentials=\"${PROXY_UID}:${PROXY_PDW}\"#" /opt/local/etc/proxysql.cnf
    svcadm enable svc:/pkgsrc/proxysql:default
  fi
fi
