set citus.shard_replication_factor = 1;
select master_create_worker_shards('mytable', 3, 1);