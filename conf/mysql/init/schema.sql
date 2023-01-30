CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitor123';
GRANT SELECT on sys.* to 'monitor'@'%';
FLUSH PRIVILEGES;

create database test;

use test;

create table person (
    person_id int not null auto_increment,
    name varchar(50) not null,
    title varchar(50) not null,
    phone_no varchar(50) not null,
    primary key (person_id)
);

create user test@'%' identified with mysql_native_password by 'abc123';

grant all privileges on test.* to test@'%';
