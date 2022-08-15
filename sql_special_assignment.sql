create table clients
(ClientId int primary key,
cname varchar(40) not null,
caddress varchar (30),
email varchar(30) unique,
phone bigint,
business varchar(20) not null)

create table departments
(
deptno int primary key,
dname varchar(15) not null,
loc varchar(20)
)


create table employees
( empno int primary key,
ename varchar(20) not null,
job varchar(15),
salary int check(salary>0),
deptno int foreign key references departments(deptno)
)

create table projects
(
projectId int primary key,
descr varchar(30) not null,
start_date date,
planned_end_date date,
actual_end_date date ,
check (actual_end_date>planned_end_date),
budget int check(budget>0),
ClientId int foreign key references clients(ClientId),
)



create table EmpProjectTasks
(
projectId int not null,
empno int not null,
start_date date,
end_date date,
task varchar(25) not null,
status varchar(15) not null
)

alter table EmpProjectTasks 
add constraint pk_ept primary key(projectId, empno)


alter table EmpProjectTasks 
add constraint fk_ept1 foreign key(projectId) references projects(projectId)
alter table EmpProjectTasks 
add constraint fk_ept2 foreign key(empno) references employees(empno)
 
alter table EmpProjectTasks 
drop constraint pk_ept
alter table EmpProjectTasks 
drop constraint fk_ept1

alter table EmpProjectTasks 
drop constraint fk_ept2



insert into clients values
(1001,'ACME Utlities','Noida','contact@acmeutil.com',9567880032,'Manufacturing'),
(1002,'Trackon Consultants','Mumbai','consult@trackon.com',8734210090,'Consultant'),
(1003,'MoneySaver Distributors','Kolkata','save@moneysaver.com',7799886655,'Reseller'),
(1004,'Lawful Corp','Chennai','justice@lawful.com',9210342219,'Professional')

select * from clients

insert into employees values(7001,'Sandeeep','Analyst',25000,10),
(7002,'Rajesh','Designer',30000,10),
(7003,'Madhav','Developer',40000,20),
(7004,'Manoj','Developer',40000,20),
(7005,'Abhay','Designer',35000,10),
(7006,'Uma','Tester',30000,30)

select * from employees

insert into departments values
(10,'Design','Pune'),
(20,'Development','Pune'),
(30,'Testing','Mumbai'),
(40,'Documnet','Mumbai')

select * from departments

insert into projects values
(401,'Inventory','2011-04-01','2011-10-01','2011-10-31',150000,1001),
(402,'Accounting','2011-08-01','2012-01-01',null,500000,1002),
(403,'Payroll','2011-10-01','2011-12-31',null,75000,1003),
(404,'Accounting','2011-11-01','2011-12-31',null,50000,1004)

select * from projects

insert into EmpProjectTasks values
(401,7001,'2011-04-01','2011-04-20','System Analysis','completed'),
(401,7002,'2011-04-21','2011-05-30','System design','completed'),
(401,7003,'2011-06-11','2011-07-15','Coding','completed'),
(401,7004,'2011-07-18','2011-09-01','Coding','completed'),
(401,7006,'2011-09-03','2011-09-15','Testing','completed')


insert into EmpProjectTasks values
(401,7009,'2011-09-18','2011-10-05','Code change','completed'),
(401,7008,'2011-10-06','2011-10-16','Testing','completed'),
(401,7007,'2011-10-06','2011-10-22','Documentation','completed'),
(401,7011,'2011-10-22','2011-10-31','sign off','completed'),
(402,7010,'2011-08-01','2011-08-20','System Analysis','completed'),
(402,7002,'2011-08-22','2011-09-30','System design','completed'),
(402,7004,'2011-10-01',null,'Coding','in progress')

select * from EmpProjectTasks