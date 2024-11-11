create database lab7;

create table countries(
    country_id serial primary key,
    name varchar(25)
);

insert into countries(name) values('USA'),
                                  ('Canada'),
                                  ('Mexico'),
                                  ('France'),
                                  ('Germany');

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget int
);

insert into departments(department_name, budget)  values('Engineering', 500000),
                                                        ('Marketing', 300000),
                                                        ('Sales', 400000),
                                                        ('HR', 200000),
                                                        ('Finance', 250000);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    salary integer,
    department_id integer references departments
);

insert into employees(first_name, last_name, salary, department_id) values('John', 'Doe', 60000, 1),
                                                                          ('Jane', 'Smith', 65000, 2),
                                                                          ('Sam', 'Brown', 50000, 3),
                                                                          ('Emma', 'Davis', 55000, 4),
                                                                          ('Oliver', 'Wilson', 70000, 1),
                                                                          ('Ava', 'Johnson', 48000, 5);

--1
create index idx_countries_name on countries(name);

--2
create index idx_employees_name_surname on employees(first_name, last_name);

--3
create unique index idx_salary on employees(salary);

--4
create index idx_sub_name on employees(substring(first_name from 1 for 4));


--5
create index idx_depatrments_budget_salary on employees(department_id, salary);
create index idx_departments_budget on departments(budget);


drop database lab7;
drop table countries;
drop table departments;
drop table employees;
