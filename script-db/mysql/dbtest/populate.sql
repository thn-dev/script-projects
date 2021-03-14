use dbtest;

delete from Address;
delete from Person;

-- Person
insert into Person (PersonName, Email, Phone, Status)
  values ('John Smith', 'john.smith@smith.com', '703-555-1212', 1);

insert into Person (PersonName, Email, Phone, Status)
  values ('Jones Smith', 'jones.smith@smith.com', '703-555-1213', 1);

insert into Person (PersonName, Email, Phone, Status)
  values ('Abu Okolada', 'abu.okolada@abu.com', '707-555-1214', 1);

insert into Person (PersonName, Email, Phone, Status)
  values ('Noah Lock', 'noah.lock@lock.com', '890-555-1212', 1);

insert into Person (PersonName, Email, Phone, Status)
  values ('Zico Tacoram Alcoduma', 'zico.alco@alco.com', '450-555-1212', 1);

-- Address
insert into Address (PersonID, Street, City, Country, Status)
  values (1, '239 Luthkia Blvd', 'Buckingham', 'Hungary', 1);

insert into Address (PersonID, Street, City, Country, Status)
  values (2, '8 Listco Ave', 'Colide, UT', 'US', 1);

insert into Address (PersonID, Street, City, Country, Status)
  values (1, '3901 Cocacola Dr', 'Albama', 'Norway', 0);

insert into Address (PersonID, Street, City, Country, Status)
  values (3, '32 Bolacia Blve', 'Knox, TX', 'US', 1);

insert into Address (PersonID, Street, City, Country, Status)
  values (4, '54/2 Tran Van Khon', 'Bac Lieu, Q4', 'Vietnam', 1);

commit;
