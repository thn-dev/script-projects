-- call other script to create a database
source mysql-sys-db_create.sql

-- create and grant access local user
create user 'ctfs'@'localhost' identified by 'ctfs';
grant all privileges on torneio.* to 'ctfs'@'localhost' with grant option;
grant all privileges on passsalts.* to 'ctfs'@'localhost' with grant option;

-- create and grant access for remote user
create user 'ctfs'@'%' identified by 'ctfs';
grant all privileges on torneio.* to 'ctfs'@'%' with grant option;
grant all privileges on passsalts.* to 'ctfs'@'%' with grant option;
