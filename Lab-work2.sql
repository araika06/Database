create database lab2;
create table countries(
    country_id serial,
    country_name varchar(255),
    region_id integer,
    population integer
);
drop database lab2;

drop table if exists countries cascade;

insert into countries(country_id, country_name, region_id, population)
VALUES (1,'Country1', 01, 1000000);

insert into countries(country_id, country_name)
VALUES (2, 'Country2');

insert into countries(country_name, region_id, population)
VALUES ('Country3', NULL,500000);

insert into countries(country_name, region_id, population)
VALUES
    ('Country4', 04, 300000),
    ('Country5', 05, 150000),
    ('Country6', 06, 320000);

alter table countries alter column country_name set default 'Kazakhstan';

select * from countries;

insert into countries(country_name, region_id, population)
VALUES(DEFAULT, 07, 340000);

insert into countries(country_name, region_id, population)
values (DEFAULT, DEFAULT, DEFAULT);

drop table if exists countries_new cascade;
create table countries_new(like countries including all);

insert into countries_new select * from countries;

update countries
set region_id = 1
where region_id is NULL;

update countries
set population = population * 1.1
where region_id > 01
returning country_name, population as "New_population";

delete from countries
where population<100000;

delete from countries_new
where country_id in(select country_id from countries)
returning *;

delete from countries returning *;
