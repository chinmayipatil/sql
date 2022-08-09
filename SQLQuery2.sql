use FISDB


create table tblEMP
(
empno int primary key, ename varchar(30), job varchar(30),mgrid int , hiredate date, sal float, comm int, deptno int references tbldept(deptno)
)

drop table tblEMP

insert into tblEMP values(7369,'SMITH','CLERK',7902,'17-DEC-80',800,20,null),
(7499,'ALLEN','SALESMAN',7698,'20-FEB-81',1600,300,30),
(7521,'WARD','SALESMAN',7698,'22-FEB-81',1250,500,30),
(7566,'JONES','MANAGER',7839,'02-APR-81',2975,null,20),
(7654,'MARTIN','SALESMAN',7698,'28-SEP-81',1250,1400,30),
(7698,'BLAKE','MANAGER',7839,'01-MAY-81',2850,null,30),
(7782,'CLARK','MANAGER',7839,'09-JUN-81',2450,null,10),
(7788,'SCOTT','ANALYST',7566,'19-APR-87',3000,null,20),
(7839,'KING','PRESIDENT',null,'17-NOV-81',5000,null,10),
(7844,'TURNER','SALESMAN',7698,'08-SEP-81',1500,0,30),
(7876,'ADAMS','CLERK',7788,'23-MAY-87',1100,null,20),
(7900,'JAMES','CLERK',7698,'03-DEC-81',950,null,30),
(7902,'FORD','ANALYST',7566,'03-DEC-81',3000,null,20),
(7934,'MILLER','CLERK',7782,'23-JAN-82',1300,null,10)




create table tbldept(deptno int primary key,dname varchar(30),loc varchar(30))

insert into tbldept values(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'), 
(30,'SALES','CHICAGO'), 
(40,'OPERATIONS','BOSTON') 

--1
select * from tblEMP

--2
select * from tblEMP where mgrid is null

--3
select empno,ename,sal from tblEMP where sal between 1200 and 1400

--4
update tblEMP set sal=(sal+sal*0.1) from tblEMP e left join tbldept d on e.deptno=d.deptno where d.dname='Research'


--5 
select count (job) as 'Number of clerks' from tblEMP where job='clerk' 

--6
select job,avg(sal) as 'Average salary',count(job) as 'No of employees' from tblEMP group by  job

--7
select min(sal) as 'Lowest salary',max(sal) as'Highest Salary' from tblEMP

--8
select * from tbldept where not exists (select deptno from tblEMP where tbldept.deptno=tblEMP.deptno)

--9
select ename,sal from tblEMP where sal>1200 and deptno=20 order by ename asc

--10
select d.dname, d.deptno,sum(e.sal) as 'Total Salary' from tbldept d left join tblEMP e on e.deptno=d.deptno group by d.deptno,dname

--11
select ename ,sal from tblEMP where ename in('miller','smith')

--12
select ename from tblEMP where ename like 'A%' or ename like 'M%'

--13
select ename, sal*12 as 'annual salary' from tblEMP where ename='Smith'

--14
select ename,sal from tblEMP where sal not between 1500 and 2850
