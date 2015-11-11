-- mysql <my_db_name> -u<user_name> -p<password> < mysql.sql
create user 'admin'@'localhost' identified by 'admin';
grant all privileges on *.* to 'admin'@'localhost' with grant option;