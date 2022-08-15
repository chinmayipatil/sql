create table books
(id int primary key,
title varchar(50),
author varchar(30),
isbn bigint unique,
published_date datetime)

insert into books values
(1,'My first SQL book','Mary Parker',981483029127,'2012-02-22 12:08:17'),
(2,'My second SQL book','John Mayer',857300923713,'1972-07-03 09:22:45'),
(3,'My third SQL book','Cary Flint',523120967812,'2015-10-18 14:05:44')

select * from books where author like'%er'

-------------------------------------------------------------------------------
--2nd Query

create table reviews
( id int primary key,
bookId int foreign key references books(id),
reviewer_name varchar(30),
content varchar(50),
rating int,
publish_date datetime)

insert into reviews values
(1,1,'John Smith','My first review',4,'2017-12-10 05:50:11'),
(2,2,'John Smith','My second review',5,'2017-10-13 15:05:12'),
(3,3,'Alive Review','Another review',1,'2017-10-22 23:47:10')
 

select b.title,b.author,r.reviewer_name from books b join reviews r 
on b.id=r.bookId

--------------------------------------------------------------------------
--3rd query
select reviewer_name from reviews
group by reviewer_name
having count(reviewer_name)>1

--------------------------------------------------------------------------
--4th query

create table customer
(id int primary key,
name varchar(30),
age int,
address varchar(30),
salary float )


insert into customer values
(1,'Ramesh',32,'Ahemdabad',2000.00),
(2,'Khilan',25,'Delhi',1500.00),
(3,'Kaushik',23,'Kota',2000.00),
(4,'Chaitali',25,'Mumbai',65000.00),
(5,'Hardik',27,'Bhopal',8500.00),
(6,'Komal',22,'MP',4500.00),
(7,'Muffy',24,'Indore',10000.00)


select name,address from customer 
where address like '%o%'

---------------------------------------------------------------------
--5th query
create table orders
(OId int primary key,
date datetime,
customerId int foreign key references customer(id),
amount float)

insert into orders values(102,'2009-10-08 00:00:00',3,3000),
(100,'2009-10-08 00:00:00',3,1500),
(101,'2009-11-20 00:00:00',2,1500),
(103,'2008-05-20 00:00:00',4,2060)

select * from customer

select date,count(customerId) as SameDateBuy from orders 
group by date
having count(customerId)>1

---------------------------------------------------------------
--6th query
create table employee
(id int primary key,
name varchar(30),
age int,
address varchar(30),
salary float )

insert into employee values
(1,'Ramesh',32,'Ahemdabad',2000.00),
(2,'Khilan',25,'Delhi',1500.00),
(3,'Kaushik',23,'Kota',2000.00),
(4,'Chaitali',25,'Mumbai',65000.00),
(5,'Hardik',27,'Bhopal',8500.00),
(6,'Komal',22,'MP',null),
(7,'Muffy',24,'Indore',null)

select LOWER(name) from employee where salary is null

-------------------------------------------------------------------
--7th query
create table studentDetails
(regno int primary key,
name varchar(30),
age int,
qualification varchar(20),
mobileNo bigint,
mailId varchar(30),
location varchar(30),
gender char(1))

insert into studentDetails values
(2,'Sai',22,'B.E',9952836777,'Sai@gmail.com','chennai','M'),
(3,'Kumar',20,'B.Sc',7890125648,'Kumar@gmail.com','Madurai','M'),
(4,'Selvi',22,'B.Tech',8904567342,'Selvi@gmail.com','Selam','F'),
(5,'Nisha',25,'M.E',7834672310,'Nisha@gmail.com','Theni','F'),
(6,'Saisaran',21,'BA',7890345678,'saran@gmail.com','Madurai','F'),
(7,'Tom',23,'BCA',8901234675,'Tomgmail.com','Pune','M')

select gender ,count(gender) counts from studentDetails
group by gender

----------------------------------------------------------------------
--9th query
create table customers
(customer_id int primary key,
fname varchar(20),
lname varchar(20))

insert into customers values(1,'George','Washinton'),
(2,'John','Adams'),
(3,'Thomas','Jefferson'),
(4,'James','Madison'),
(5,'James','Monroe')

create table tblorder
(id int primary key,
order_date date,
amount float,
custId int foreign key references customers(customer_id))

insert into tblorder values
(1,'1776-07-04',234.56,1),
(2,'1776-03-14',78.50,3),
(3,'1776-05-23',124.00,2),
(4,'1776-09-03',65.50,3)
--(5,'1776-07-21',26.50,10),
--(6,'1787-11-27',14.40,9)

select c.fname,c.lname from customers c
join tblorder o on c.customer_id=o.custId
group by c.fname,c.lname
having count(o.custId)=2

------------------------------------------------------------------
--10 th query
select reverse(name) as ReverseName,upper(location) as location 
from studentDetails

-------------------------------------------------------------------
--11th query
create view productInfo
as select O1.quantity,O2.ordernumber
from order O1
left join orderitem O2
on O1.id=O2.orderid

-------------------------------------------------------------------
--12th query
select cd.c_name from studentDetails st
join courseRegistration cr
on st.registerno=cr.registerno
join coursedetails cd
on cd.c_id=cr.cid
where st.name='Nisha'