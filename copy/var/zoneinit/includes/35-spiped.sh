if mdata-get spiped_key 1>/dev/null 2>&1; then
  SPIPED_KEY=`mdata-get spiped_key`
  echo "$SPIPED_KEY" | tr -d '\n' > /etc/ssh/spiped.key

  if mdata-get spiped_redis_host 1>/dev/null 2>&1; then
    SPIPED_REDIS_HOST=`mdata-get spiped_redis_host`
    sed -i "s/-t 127.0.0.1:26379/-t $SPIPED_REDIS_HOST:26379/g" /opt/local/lib/svc/manifest/spiped-redis.xml
    svccfg import /opt/local/lib/svc/manifest/spiped-redis.xml
  fi
  
  if mdata-get spiped_percona_host 1>/dev/null 2>&1; then
    SPIPED_PERCONA_HOST=`mdata-get spiped_percona_host`
    sed -i "s/-t 127.0.0.1:23306/-t $SPIPED_PERCONA_HOST:23306/g" /opt/local/lib/svc/manifest/spiped-percona.xml
    svccfg import /opt/local/lib/svc/manifest/spiped-percona.xml
  fi
  
  if mdata-get spiped_percona_host 1>/dev/null 2>&1; then
    SPIPED_MEMCACHED_MASTER_HOST=`mdata-get spiped_memcached_master_host`
    sed -i "s/-t 127.0.0.1:23306/-t $SPIPED_MEMCACHED_MASTER_HOST:23306/g" /opt/local/lib/svc/manifest/spiped_memcached_master.xml
    svccfg import /opt/local/lib/svc/manifest/spiped_memcached_master.xml
  fi
  
  if mdata-get spiped_percona_host 1>/dev/null 2>&1; then
    SPIPED_MEMCACHED_FALLBACK_HOST=`mdata-get spiped_memcached_fallback_host`
    sed -i "s/-t 127.0.0.1:23306/-t $SPIPED_MEMCACHED_FALLBACK_HOST:23306/g" /opt/local/lib/svc/manifest/spiped_memcached_fallback.xml
    svccfg import /opt/local/lib/svc/manifest/spiped_memcached_fallback.xml
  fi

fi