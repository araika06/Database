create database lab1;

create table users(
    id serial,
    firstname varchar(50),
    lastname varchar(50)
);
drop table users;
alter table users
    add column isadmin integer;
alter table users
    alter column isadmin set data type boolean using isadmin::boolean;

select * from users;

alter table users
    alter column isadmin set default FALSE;

alter table users add primary key (id);

create table tasks(
    id serial,
    name varchar(50),
    user_id integer
);

drop table tasks;
drop database lab1;