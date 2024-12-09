create database lab10;

drop database lab10;

create table Books(
     book_id int primary key,
     title varchar,
     author varchar,
     price decimal,
     quantity int
);

drop table Books;

create table Orders(
    order_id int primary key,
    book_id int references Books,
    customer_id int,
    order_date date,
    quantity int
);

drop table Orders cascade;

create table Customers(
    customer_id int primary key,
    name varchar,
    email varchar
);

drop table Customers cascade;

insert into Books (book_id, title, author, price, quantity)
values (1, ' Database 101', 'A. Smith', 40.00, 10),
       (2, 'Learn SQL', 'B.Johnson', 35.00, 15),
       (3, 'Advanced DB', 'C.Lee', 50.00, 5);

insert into Customers (customer_id, name, email)
values (101, 'John Doe', 'johndoe@example.com'),
       (102, 'Jane Doe',  'janedoe@example.com');

--1
begin;

insert into Orders (order_id, book_id, customer_id, order_date, quantity)
values (1, 1, 101, current_date, 2);

update Books
set quantity = quantity - 2
where book_id = 1;

commit;

select * from Orders where order_id = 1;
select * from Books where book_id = 1;

--2
begin;
do $$
begin
    if(select quantity from Books where book_id = 3) < 10 then
        RAISE EXCEPTION 'Not enough stock';
    else
        insert into Orders(order_id, book_id, customer_id, order_date, quantity)
        values (2, 3, 102, current_date, 10);

        update Books
        set quantity = quantity - 10
        where book_id = 3;

    end if;
end
$$;

rollback;

select * from Books where book_id = 3;


--3
begin transaction isolation level read committed;
update Books
set price = 34.00
where book_id = 1;

begin transaction isolation level read committed;
select price from Books where book_id = 1;

commit;

select price from Books where book_id = 1;

--4
begin;
update Customers
set email = 'newemail@example.com'
where customer_id = 101;
commit;


select email from Customers where customer_id = 101;