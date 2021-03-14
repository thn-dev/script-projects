create user testuser with password 'testpwd';

grant all privileges on all tables in schema public to testuser;

grant usage, select on all sequences in schema public to testuser;

grant all privileges on database dbtest to testuser;
