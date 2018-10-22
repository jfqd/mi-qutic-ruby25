# Get internal ip of the vm
IP_INTERNAL=$(mdata-get sdc:nics | /usr/bin/json -ag ip -c 'this.nic_tag === "admin"' 2>/dev/null);

# Workaround for using DHCP so IP_INTERNAL or IP_EXTERNAL is empty
if [[ -z "${IP_INTERNAL}" ]]; then
  IP_INTERNAL="127.0.0.1"
fi

gsed -i \
     -e "s/# maxmemory <bytes>/maxmemory 256mb/" \
     -e "s/# maxmemory-policy noeviction/# maxmemory-policy allkeys-lfu/" \
     -e "s/# unixsocket \/tmp\/redis.sock/unixsocket \/var\/tmp\/redis.sock/" \
     -e "s/bind 127.0.0.1/bind ${IP_INTERNAL}/" \
     /opt/local/etc/redis.conf

touch /var/log/redis/redis.log
