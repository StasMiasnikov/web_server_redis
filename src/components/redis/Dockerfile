FROM redis:7.2
ADD data.rdb /data/data.rdb
ADD redis.conf /etc/redis/redis.conf
ENTRYPOINT ["redis-server"]
CMD ["/etc/redis/redis.conf"]