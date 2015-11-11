-- call other script to create a database
source mysql-sys-test-db_create.sql

-- create and grant local access
create user 'dbtest'@'localhost' identified by 'test';
grant all privileges on dbtest.* to 'dbtest'@'localhost' with grant option;

-- create and grant remote access
create user 'dbtest'@'%' identified by 'test';
grant all privileges on dbtest.* to 'dbtest'@'%' with grant option;
