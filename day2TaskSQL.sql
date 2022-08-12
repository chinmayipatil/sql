--Day2 Task 1
select * from tblEMP

--1. Retrieve a list of MANAGERS. 
select * from tblemp where job='manager'

--2. Find out the names and salaries of all employees earning more than 1000 per month. 
select ename, sal from tblemp where sal>1000

--3. Display the names and salaries of all employees except JAMES. 
select ename,sal from tblemp where ename!='James'

--4. Find out the details of employees whose names begin with ‘S’. 
select * from tblemp where ename like 'S%'

--5. Find out the names of all employees that have ‘A’ anywhere in their name
select ename from tblemp where ename like '%A%'

--6. Find out the names of all employees that have ‘L’ as their third character in their name.
select ename from tblemp where ename like '__L%'

--7. Compute daily salary of JONES. 
select (sal*12/365) as DailySalary from tblemp where ename='jones'

--8 Calculate the total monthly salary of all employees. 
select sum(sal) as'Total salary' from tblemp

--9 Print the average annual salary . 
select avg(sal*12) as AvgAnualSalary from tblemp

--10. Select the name, job, salary, department number of all employees except 
--SALESMAN from department number 30. 
select ename,job,sal,deptno from tblemp where job!='salesman' and deptno=30

--11. List unique departments of the EMP table. 
select distinct(deptno) as uniqueDept from tblemp 

--12. List the name and salary of employees who earn more than 1500 
--	and are in department 10 or 30.
--	Label the columns Employee and Monthly Salary respectively.
select * from tblemp
select ename as Employee,sal as 'Monthly Salary' from tblemp 
where sal>1500 and deptno in(10,30)
 
 --13. Display the name, job, and salary of all the employees whose job is MANAGER or 
--ANALYST and their salary is not equal to 1000, 3000, or 5000. 
select ename,job,sal from tblemp 
where job in('manager','analyst') and sal not in(1000,3000,5000)

--14. Display the name, salary and commission for all employees whose commission 
-- amount is greater than their salary increased by 10%
select ename,sal,comm from tblemp where comm>(sal+sal*0.1) 

--15. Display the name of all employees who have two Ls in their name and are in 
-- department 30 or their manager is 7782. 
select ename from tblemp where ename like '%LL%' and (deptno=30 or mgrid=7782)

--16. Display the names of employees with experience of over 10 years and under 20 yrs.
 -- Count the total number of employees.
 select ename from tblemp where datediff(MONTH,hiredate,GETDATE())/12 between 10 and 20

 --17 
 select e.ename,d.dname from tblemp e join tbldept d on e.deptno=d.deptno 
 order by d.dname,e.ename desc

 --18 
 select datediff(month,hiredate,getdate())/12 as experience from tblemp
where ename='miller'