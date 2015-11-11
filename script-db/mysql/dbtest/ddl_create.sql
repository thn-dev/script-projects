-- select database
use dbtest;

create table Person
(
    PersonID integer not null primary key auto_increment,
    PersonName varchar(128) not null,
    Email varchar(128) default 'unknown' not null,
    Phone varchar(25) default '555-1212' not null,
    Status smallint default 1 not null
);

-- alter table Person
--    add (constraint pk_person01 primary key (PersonID));

-- alter table Person
--    modify PersonID integer not null auto_increment;

create table Address
(
    AddressID integer not null primary key auto_increment,
    PersonID integer not null,
    Street varchar(255) not null,
    City varchar(128) default 'unknown' not null,
    Country varchar(128) default 'unknown' not null,
    Status smallint default 1 not null
);

alter table Address
    add (constraint fk_address01 foreign key (PersonID) references Person(PersonID));

