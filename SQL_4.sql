--1
/*Find all employees earning the minimal salary in the firm.*/
select *
from emp
where sal=( select min(sal)
            from emp);
            
--2
/*Find all people who work at the same position as BLAKE.*/
select *
from emp
where ename!='BLAKE' and job=(select job
           from emp
           where ename='BLAKE');
           
--3
/*Find all people who earn salaries from the list of" lowest salary earned by departments".*/
select * 
from emp
where sal in (select min(sal)
              from emp
              group by deptno);
              

--4
/*Find employees earning the lowest salaries in their own department.*/
select * 
from emp
where (deptno,sal) in(select deptno, min(sal)
                      from emp
                      group by deptno);
                
select *
from emp e
where sal=(select min(sal) from emp where deptno=e.deptno);

--5   
/*Using operator "ANY" choose people earning more than the lowest salary in department 30.*/                   
select * 
from emp
where sal > any(select Distinct sal
                from emp
                where deptno=30);
                
                
--6
/*Find people who earn more than everybody from dep 30.*/
select * 
from emp
where sal > all(select Distinct sal
                from emp
                where deptno=30);
                
--7
/*Find departments with average salaries higher than average salary from dep 30.*/
select deptno,avg(sal) 
from emp
group by deptno
having avg(sal)>(select avg(sal) from emp where deptno=30);

--8
/*Find the job with the highest average salary.*/
select job
from emp
group by job
having avg(sal)=(
select max(avg(sal))
from emp
group by job);

--9
/*Give names and salaries of all employees who earn more than the highest salary in department SALES.*/
select ename,sal
from emp
where sal >(select max(sal) from emp,dept where emp.deptno=dept.deptno and dname='SALES');

--10
/*Find people who earn more than the average for their own departments.*/
select *
from emp e
where sal > (select avg(sal) from emp where deptno=e.deptno);

--11
/*Find people who supervise some (use operator others EXISTS).*/
select *
from emp e
where exists(select mgr from emp where mgr=e.empno);

--12
/*Find people working in department not described in the table DEPT.*/
select *
from emp
where deptno not in(select deptno from dept);

--13
/*Find people earning maximal salaries for their jobs. Present data by decreasing salaries.*/
select *
from emp 
where (job,sal) in (select job,max(sal)
                    from emp
                    group by job)
order by sal DESC;
                    
select *
from emp e
where sal=(select max(sal) from emp where job=e.job)
order by sal DESC;

--14
/*Find people earning minimal salary for their departments. Order by names.*/
select *
from emp e
where sal=(select min(sal) from emp where deptno=e.deptno)
order by ename;

--15
/*For each department find the person employed as the last one. Order by the date of employment.*/
select * from emp e
where hiredate=(select max(hiredate) from emp where deptno=e.deptno);

--16
/*Show ENAME,SALARY,DEPTNO for people who earn more than the average for their departments.*/
select ename,sal,deptno from emp e
where sal>(select avg(sal) from emp where deptno=e.deptno);

--17
/*Find all departments where nobody is employed.*/
select deptno
from dept
where deptno not in (select distinct deptno from emp);

--18
/*Find names and salaries for 3 employees earning the highest salaries in the firm.*/
select ename,sal
from emp
where ROWNUM <= 3
order by sal DESC;

--19
/*Find the department where the greatest number of people was employed.*/
select deptno,count(empno)
from emp
group by deptno
having count(empno)=(
select max(count(empno))
from emp
group by deptno);

--20
/*Show ENAME, SALARY, DEPTNO and for people earning more than the average for their departments.*/
select ename, deptno,sal
from emp e
where sal > (select avg(sal) from emp where deptno=e.deptno);






