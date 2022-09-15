create database FIS
use FIS

create table air_flight
( 
flight_id varchar(10) primary key,
airline_id varchar(10),
airline_name varchar(30),
from_location varchar(20),
to_location varchar(20),
dept_time time,
arrival_time time,
dur time,
tseats int)


create table air_flight_details(
flight_id varchar(10) references air_flight(flight_id),
fdept_date date,
price decimal(8,2),
available_seats int)

create table air_passenger_profile(
profile_id varchar(10) primary key,
password varchar(10),
f_name varchar(10),
l_name varchar(10),
address varchar(100),
mblno bigint,
email_id varchar(30))

create table air_ticket_info(
ticket_id varchar(10) primary key,
profile_id varchar(10) references air_passenger_profile(profile_id),
flight_id varchar(10) references air_flight(flight_id),
fdept_date date,
status varchar(10))

create table air_credit_card_details(
profile_id varchar(10) references air_passenger_profile(profile_id),
cnumber bigint,
ctype varchar(10),
expiration_month int,
expiration_year int)

insert into air_flight values
('916','100000','ABC','chennai','hyderabad','19:55:00','21:00:00','01:05:00',40),
('289','100000','ABC','chennai','kochi','08:40:00','09:55:00','01:15:00',80),
('1011','100000','ABC','hyderabad','chennai','12:30:00','13:55:00','01:25:00',50),
('3004','100000','ABC','bengaluru','chennai','09:05:00','10:25:00','01:20:00',100),
('3307','100000','ABC','bengaluru','chennai','18:45:00','19:45:00','01:00:00',40),
('3013','100000','ABC','chennai','bengaluru','07:40:00','08:45:00','01:05:00',50),
('3148','100000','ABC','chennai','bengaluru','20:15:00','21:20:00','01:05:00',100)


insert into air_flight_details values
('916','2013-04-28','4086.00',40),
('916','2013-05-12','3023.00',40),
('289','2013-05-06','3603.00',80),
('289','2013-05-20','3052.00',80),
('1011','2013-05-09','4131.00',46),
('3004','2013-05-02','3603.00',97),
('3004','2013-05-19','3304.00',100),
('3307','2013-05-03','3603.00',40),
('3013','2013-05-22','3052.00',50),
('3013','2013-05-30','2773.00',50),
('3148','2013-06-01','2773.00',95)


insert into air_passenger_profile values
('PFL001','p001','Latha','Sarkar','123 broad chennai-48',12345,'pfl001@gmail.com'),
('PFL002','p002','Arun','Kumar','125 broad chennai-28',12245,'pfl002@gmail.com'),
('PFL003','p003','Amit','Kanchan','132 saint Kochi-48',19045,'pfl003@gmail.com'),
('PFL004','p004','Arti','Ramesh','343th street hyderabad-76',13345,'pfl004@gmail.com'),
('PFL005','p005','Siva','Kumar','123 street bengaluru-46',56745,'pfl005@gmail.com')

insert into air_ticket_info values
('TKT001','PFL001','3004','2013-05-02','booked'),
('TKT002','PFL001','1011','2013-05-09','booked'),
('TKT003','PFL002','3148','2013-06-01','booked'),
('TKT004','PFL002','3148','2013-06-01','booked'),
('TKT005','PFL002','3148','2013-06-01','booked'),
('TKT006','PFL003','289','2013-05-03','booked'),
('TKT007','PFL003','289','2013-05-03','booked'),
('TKT008','PFL004','3307','2013-05-20','booked'),
('TKT009','PFL004','3307','2013-05-29','booked'),
('TKT010','PFL005','1011','2013-05-09','booked')

truncate table air_ticket_info

insert into air_credit_card_details values
('PFL001',202256853490,'gold',04,2018),
('PFL002',102256353490,'instant',05,2022),
('PFL003',204225853456,'gold',08,2020),
('PFL004',892256853234,'paltinum',09,2018),
('PFL005',562678920140,'instant',01,2019)

select * from air_flight_details

--1
select f.flight_id,f.from_location,f.to_location,fp.month_name,fp.avg_price
from air_flight f,
(select flight_id,month(fdept_date) as month_name,
avg(price) as avg_price from air_flight_details group by flight_id,MONTH(fdept_date))fp
where f.flight_id=fp.flight_id
and f.airline_name='abc'
order by f.flight_id,fp.month_name

--2
select c.profile_id,c.f_name,c.address,m.No_of_tickets from air_passenger_profile c,
(select min(s.total) as No_of_tickets 
from(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id)s
)m,
(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id
)t
where m.No_of_tickets=t.total
and c.profile_id=t.profile_id
order by c.f_name

--3
select f.from_location,f.to_location,s.month_name ,sum(s.no_of_services) from air_flight f
join
(select flight_id,month(fdept_date) as month_name,count(fdept_date) as no_of_services
from air_flight_details
group by flight_id,MONTH(fdept_date ))s
on s.flight_id=f.flight_id 
group by f.from_location,f.to_location,s.month_name
order by f.from_location,f.to_location,s.month_name



--4
select c.profile_id,c.f_name,c.address,m.No_of_tickets from air_passenger_profile c,
(select max(s.total) as No_of_tickets 
from(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id)s
)m,
(select profile_id,count(ticket_id) as total from air_ticket_info group by profile_id
)t
where m.No_of_tickets=t.total
and c.profile_id=t.profile_id
order by c.f_name

--5
select p.profile_id,p.f_name,p.l_name,t.flight_id,t.fdept_date,t.no_of_tickets
from air_passenger_profile p join
(select profile_id,flight_id,fdept_date,count(ticket_id) as no_of_tickets
from air_ticket_info where flight_id in
(select flight_id from air_flight where from_location='chennai' and to_location='hyderabad')
group by profile_id,flight_id,fdept_date)t
on p.profile_id=t.profile_id
order by p.profile_id,t.flight_id,t.fdept_date

--6 
select fd.flight_id,f.from_location,f.to_location, fd.price from air_flight_details fd
join air_flight f on f.flight_id=fd.flight_id
where MONTH(fdept_date)=04 order by fd.flight_id,f.from_location

--7
select f.flight_id,f.from_location,f.to_location ,avg(fd.price) as Price from air_flight f
join air_flight_details fd 
on f.flight_id=fd.flight_id
group by f.flight_id,f.from_location,f.to_location

--8
select distinct p.profile_id,CONCAT(p.f_name,',',p.l_name) as Customer_Name,p.address
from air_passenger_profile p join air_ticket_info t 
on p.profile_id=t.profile_id
join air_flight f
on
f.flight_id=t.flight_id and f.from_location='chennai' and f.to_location='hyderabad'
order by p.profile_id

--9
select profile_id from air_ticket_info group by profile_id 
having count(profile_id)>= all
(select count(profile_id) from air_ticket_info group by profile_id)
order by profile_id

--10
select f.flight_id,f.from_location,f.to_location,count(t.ticket_id) as No_of_tickets
from air_flight f 
join air_ticket_info t
on f.flight_id=t.flight_id
where f.airline_name='abc'
group by f.flight_id,f.from_location,f.to_location having count(t.ticket_id)>=1
order by flight_id

--11
select * from air_flight_details


SELECT FLIGHT_ID,COUNT(fdept_date) AS NO_OF_SERVICES,SUM(PRICE) as TOTAL_PRICE
FROM air_flight_details
GROUP BY FLIGHT_ID ORDER BY TOTAL_PRICE DESC,FLIGHT_ID DESC;

--12
SELECT  flight_id,fdept_date,COUNT(ticket_id) AS NO_OF_PASSENGERS FROM air_ticket_info
GROUP BY flight_id,fdept_date ORDER BY flight_id,fdept_date

--13
SELECT PROFILE_ID FROM air_ticket_info 
GROUP BY PROFILE_ID HAVING COUNT(TICKET_ID) = 
(SELECT MIN(C) FROM ( SELECT COUNT(TICKET_ID) AS C 
FROM air_ticket_info GROUP BY PROFILE_ID)t 
) ORDER BY PROFILE_ID

--14
SELECT DISTINCT a.PROFILE_ID,a.f_name,a.mblno,a.EMAIL_ID FROM air_passenger_profile a JOIN air_ticket_info b 
ON a.PROFILE_ID = b.PROFILE_ID JOIN air_flight c ON b.FLIGHT_ID = c.FLIGHT_ID
WHERE c.FROM_LOCATION='Hyderabad' and c.TO_LOCATION='Chennai' ORDER BY a.PROFILE_ID;


--16
SELECT a.profile_id,a.f_name,a.address
AS BASE_LOCATION,COUNT(b.TICKET_ID) AS NO_OF_TICEKTS
FROM air_passenger_profile a JOIN air_ticket_info b ON a.PROFILE_ID = b.PROFILE_ID 
WHERE a.address like '%Kochi%' 
GROUP BY a.PROFILE_ID,a.f_name,a.address ORDER BY a.f_name

--17
SELECT a.FLIGHT_ID,a.FROM_LOCATION,a.TO_LOCATION,COUNT(b.fdept_date) 
AS NO_OF_SERVICES 
FROM air_flight a JOIN air_flight_details b ON a.FLIGHT_ID = b.FLIGHT_ID
WHERE MONTH(B.fdept_date)=5 GROUP BY a.FLIGHT_ID,a.FROM_LOCATION,
a.TO_LOCATION ORDER BY FLIGHT_ID;

--18a
SELECT PROFILE_ID,l_name,mblno,EMAIL_ID FROM air_passenger_profile 
WHERE ADDRESS LIKE '%Chennai%' ORDER BY PROFILE_ID;

--18b
SELECT COUNT(FLIGHT_ID) AS FLIGHT_COUNT FROM air_flight 
WHERE dept_time BETWEEN '06:00:00' AND '18:00:00' AND FROM_LOCATION='Chennai';

--19
SELECT DISTINCT a.PROFILE_ID,a.f_name,a.EMAIL_ID,a.mblno FROM air_passenger_profile a 
join air_ticket_info b ON a.PROFILE_ID = b.PROFILE_ID
WHERE b.FLIGHT_ID='3148' ORDER BY a.f_name;

--20
SELECT DISTINCT FLIGHT_ID,FROM_LOCATION,TO_LOCATION,dept_time,
CASE WHEN dept_time BETWEEN '05:00:01.0000000' AND '12:00:00.0000000' THEN 'Morning'
	 WHEN dept_time BETWEEN '12:00:01.0000000' AND '18:00:00.0000000' THEN 'Afternoon'
	 WHEN dept_time BETWEEN '18:00:01.0000000' AND '23:59:59.0000000' THEN 'Evening'
	 WHEN dept_time BETWEEN '00:00:01.0000000' AND '05:00:00.0000000' THEN 'Night' 
	 ELSE 'n/a' end 
as'TIME_OF_SERVICE'
FROM air_flight ORDER BY FLIGHT_ID;

--21
SELECT FLIGHT_ID , fdept_date,
CASE WHEN PRICE < 3000 THEN 'AIR PASSENGER'
	WHEN PRICE > 3000 AND PRICE < 4000 THEN 'AIR BUS'
	WHEN PRICE > 4000 THEN 'EXECUTIVE PASSENGER'
	ELSE 'NONE'
	END AS 'FLIGHT TYPE'
	FROM air_flight_details
	GROUP BY FLIGHT_ID, fdept_date, PRICE
ORDER BY FLIGHT_ID, fdept_date


--22
SELECT * FROM air_credit_card_details
SELECT ctype ,COUNT(ctype) AS 'CARD_COUNT' FROM 
air_credit_card_details GROUP BY ctype

--23
SELECT SUBSTRING(PROFILE_ID, 4,6) AS 'SERIAL_NO' ,f_name, 
mblno,EMAIL_ID FROM air_passenger_profile 
WHERE EMAIL_ID LIKE ('%GMAIL.COM%') ORDER BY f_name 

--25
SELECT FROM_LOCATION, COUNT(FROM_LOCATION) AS 'NO_OF_FLIGHTS' FROM air_flight
GROUP BY FROM_LOCATION


--26(NOT ACCURATE)
SELECT A.FLIGHT_ID, B.FROM_LOCATION, B.TO_LOCATION, A.fdept_date, 
COUNT(TICKET_ID) AS 'NO_OF_PASSENGERS' 
FROM air_ticket_info A JOIN air_flight B
ON A.FLIGHT_ID = B.FLIGHT_ID 
WHERE STATUS = 'BOOKED'
GROUP BY A.FLIGHT_ID, A.fdept_date,B.from_location,B.to_location


--27
SELECT B.FLIGHT_ID, B.FROM_LOCATION, B.TO_LOCATION, B.tseats, 
(B.tseats - A.AVAILABLE_SEATS) AS 'NO_OF_SEATS_BOOKED' 
FROM air_flight_details A JOIN air_flight B 
ON A.FLIGHT_ID = B.FLIGHT_ID 
WHERE A.AVAILABLE_SEATS < 0.1*B.tseats

--28
SELECT * FROM air_flight
SELECT A.FLIGHT_ID, B.fdept_date, A.FROM_LOCATION, A.TO_LOCATION, A.dur
FROM air_flight A JOIN air_flight_details B 
ON A.FLIGHT_ID = B.FLIGHT_ID AND A.dur < '01:10:00' 
ORDER BY B.FLIGHT_ID ASC

--GROUP BY A.FLIGHT_ID, B.fdept_date, A.FROM_LOCATION

--29

SELECT B.FLIGHT_ID, A.FROM_LOCATION,A.TO_LOCATION, 
PRICE AS AVERAGE_PRICE FROM air_flight A, air_flight_details B
	WHERE (SELECT AVG(PRICE) FROM air_flight_details) > ALL(SELECT AVG(PRICE) 
	FROM air_flight_details GROUP BY FLIGHT_ID)
	



