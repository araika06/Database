create database lab9;

--1
create or replace function increase_value(a integer) returns integer as
$$
begin
return a+10;
end;
$$
language plpgsql;

select increase_value(increase_value(5));

--2
create or replace function compare_numbers(in a int, in b int) returns varchar(10) as
$$
begin
    if a > b then
        return 'Greater';
    elseif a < b then
        return 'Lesser';
    else
        return 'Equal';
    end if;
end;
$$
language plpgsql;

select compare_numbers(3, 3);

--3
create or replace function number_series(in n integer) returns text as
$$
declare
    i int:=1;
    result text := '';
begin
    while i <= n loop
        result := result || i || ' ';
        i:=i+1;
        end loop;
    return result;
end;
$$
language plpgsql;

select number_series(9);

--4
create or replace function find_employee(in employee_name varchar(255))
    returns table (
        id int,
        name varchar)
as
$$
begin
    return query
    select id, name
    from employees
    where name = employee_name;
end;
$$
language plpgsql;

drop function find_employee;
select find_employee('John');

--5
create table products
(
    id int,
    name varchar(100),
    price int
);

create or replace function list_products(category_name varchar)
returns table
    (
        id int,
        name varchar(100),
        price int
    )
as
$$
begin
    return query
    select id, name, price
    from products
    where name = category_name;
end;
$$
language plpgsql;



--6
create or replace function calculate_bonus(id int) returns decimal as
$$
declare
    salary decimal;
    bonus decimal;
begin
    select id into salary from employees where employee_id =id;
    bonus := salary * 0.10;
    return bonus;
end;
$$
language plpgsql;

create or replace function update_salary(id int) returns void as
$$
declare
    bonus decimal;
begin
    bonus:=calculate_bonus(id);
    update employees set salary = salary+bonus where employee_id=id;
end;
$$
language plpgsql;


--7
create or replace function complex_calculation(num int, str varchar) returns text as
$$
declare
    num_result int;
    square_res int;
    cube_res int;
    reserved_text varchar(255);
    str_result varchar(255);

begin
    <<main_block>>
        begin
        <<first_block>>
            begin
            square_res := num * num;
            cube_res := num * num * num;
            num_result := square_res + cube_res;
            raise notice 'The numeric result is %', num_result;
        end first_block;

        <<second_block>>
            begin
            reserved_text := reverse(str);
            str_result := reserved_text;
            raise notice 'The string result is %', str_result;
        end second_block;
    end main_block;
    return concat('Numeric Result: ', num_result, ' | String Result: ', str_result);
end;
$$
language plpgsql;

select complex_calculation(3, 'hello world');

drop function complex_calculation(num int, str varchar);