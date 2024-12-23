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

SELECT * FROM countries WHERE name = 'USA';

explain analyze SELECT * FROM countries WHERE name = 'USA';

drop index idx_countries_name;

--2
create index idx_employees_name_surname on employees(first_name, last_name);

SELECT * FROM employees WHERE first_name = 'Oliver'
AND last_name = 'Wilson';

drop index idx_employees_name_surname;

--3
create unique index idx_salary on employees(salary);

SELECT * FROM employees WHERE salary < 70000
AND salary > 55000;

drop index idx_salary;

--4
create index idx_sub_name on employees(substring(first_name from 1 for 4));

SELECT * FROM employees WHERE substring(first_name
from 1 for 4) = 'Oliv';

drop index idx_sub_name;

--5
create index idx_depatrments_budget_salary on employees(department_id, salary);
create index idx_departments_budget on departments(budget);

SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id WHERE
d.budget > 55000 AND e.salary < 200000;

drop index idx_depatrments_budget_salary;
drop index idx_departments_budget;

drop database lab7;
drop table countries;
drop table departments;
drop table employees;
