--1
create database lab8;

--2
create table salesman(
    salesman_id integer primary key,
    name varchar(50),
    city varchar(50),
    commision decimal(5, 2)
);

insert into salesman(salesman_id, name, city, commision) values
                                                             (5001, 'James Hoog', 'New York', 0.15),
                                                             (5002, 'Nail Knite', 'Paris', 0.13),
                                                             (5005, 'Pit Alex', 'London', 0.11),
                                                             (5006, 'MC Lyon', 'Paris', 0.14),
                                                             (5003, 'Lauson Hen', null, 0.12),
                                                             (5007, 'Paul Adam', 'Rome', 0.13);


create table customers(
    customer_id integer primary key,
    cust_name varchar(50),
    city varchar(50),
    grade integer,
    salesman_id integer
);

insert into customers(customer_id, cust_name, city, grade, salesman_id) values
                                                               (3002, 'Nick Rimando', 'New York', 100, 5001),
                                                               (3005, 'Graham Zusi', 'California', 200, 5002),
                                                               (3001, 'Brad Guzan', 'London', null, 5005),
                                                               (3004, 'Fabian Johns', 'Paris', 300, 5006),
                                                               (3007, 'Brad Davids', 'New York', 200, 5001),
                                                               (3009, 'Geoff Camero', 'Berlin', 100, 5003),
                                                               (3008, 'Julian Green', 'London', 300, 5002);

create table orders(
    ord_no integer primary key,
    purch_amt decimal(10, 2),
    ord_date date,
    customer_id integer,
    salesman_id integer
);

insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id) values
                                                                              (70001, 150.5, '2012-10-05', 3005, 5002),
                                                                              (70009, 270.65, '2012-09-10', 3001, 5005),
                                                                              (70002, 65.26, '2012-10-05', 3002, 5001),
                                                                              (70004, 110.5, '2012-08-17', 3009, 5003),
                                                                              (70007, 948.5, '2012-09-10', 3005, 5002),
                                                                              (70005, 2400.6, '2012-07-27', 3007, 5001),
                                                                              (70008, 5760, '2012-09-10', 3002, 5001);

--3
create role junior_dev login;

--4
create view ny_salesman as
select * from salesman
where city = 'New York';

--5
create view orders_show as
select s.name as salesman_name, c.cust_name as customer_name
from orders o
join customers c on o.customer_id = c.customer_id
join salesman s on o.salesman_id =  s.salesman_id;

drop view orders_show;

grant all privileges on orders_show to junior_dev;

--6
create view highest_grade as
select * from customers
where grade = (select max(grade) from customers);

grant select on highest_grade to junior_dev;

--7
create view num_salesman as
select city, count(*) as number_salesman
from salesman
group by city;

--8
create view multiple_salesman as
select s.name as salesman_name, count(c.customer_id) as customer_count
from salesman s
join orders o on s.salesman_id = o.salesman_id
join customers c on o.customer_id = c.customer_id
group by s.name
having count(c.customer_id) > 1;

--9
create role intern;
grant junior_dev to intern;

drop role intern;



drop table salesman;
drop table customers;
drop table orders;

select * from salesman;
select * from customers;