--select master_create_distributed_table('mytable', 'id', 'hash');
select master_create_distributed_table('mytable', 'insert_time', 'hash');
