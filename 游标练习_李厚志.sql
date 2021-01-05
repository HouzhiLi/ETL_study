--1、用游标显示所有部门编号与名称，以及其所拥有的员工人数。
declare
cursor cur is select d.deptno dno, d.dname, count(1) nums from dept d, emp e where d.deptno = e.deptno(+) group by d.deptno, d.dname;
v cur%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    exit when cur%notfound;
    dbms_output.put_line(v.dno|| ', ' || v.dname|| ', ' || v.nums);
    end loop;
    close cur;
    end;
    
--2、用游标属性%rowcount实现输出前十个员工的信息。

declare
cursor cur is select * from emp;
v cur%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.deptno|| ', ' || v.mgr|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.hiredate);
    exit when cur%rowcount = 10;
    end loop;
    close cur;
    end;
    
--3、通过使用游标来显示dept表中的部门名称，及其相应的员工列表（提示：可以使用双重循环）。
declare
cursor cur1 is select deptno, dname from dept;
begin
  for v in cur1 loop
     dbms_output.put_line(v.dname);
     for m in (select * from emp where deptno = v.deptno) loop
       dbms_output.put_line(m.empno|| ', ' || m.ename|| ', ' || m.deptno);
       end loop;
       end loop;
       end;
       ------------------
declare
cursor cur1 is select deptno, dname from dept;
cursor cur2 (dno number) is select * from emp where deptno = dno;
begin
  for v in cur1 loop
    dbms_output.put_line(v.dname);
    for m in cur2(v.deptno) loop
       dbms_output.put_line(m.empno|| ', ' || m.ename|| ', ' || m.deptno);
      end loop;
      end loop;
      end;
      
--4、接受一个部门号，使用For循环，从emp表中显示该部门的所有雇员的姓名，工作和薪水。
declare
v_dno number := &dno;
cursor cur is select ename, job, sal from emp where deptno = v_dno;
begin
  for v in cur loop
    dbms_output.put_line(v.ename|| ', ' || v.job|| ', ' || v.sal);
    end loop;
    end;


--5、编写一个程序块，将emp表中前5人的名字，及其出的工资等级（salgrade）显示出来。
declare
cursor cur is select e.ename, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;
v cur%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    dbms_output.put_line(v.ename || ', ' ||  v.grade);
    exit when cur%rowcount = 5;
    end loop;
    close cur;
    end;

--6、用带参数的游标输出部门编号为10， 30的员工信息。
declare 
cursor cur(dno number) is select * from emp where deptno = dno;
begin
  for v in cur(10) loop
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.mgr|| ', ' || v.deptno|| ', ' || v.hiredate);
    end loop;
    
    for v in cur(30) loop
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.mgr|| ', ' || v.deptno|| ', ' || v.hiredate);
    end loop;
    end;
    
--7、使用带参数的游标，实现接受一个部门名称，从emp表中显示该部门的所有雇员的姓名，工作和薪水。
declare
v_dname dept.dname%type := '&dname';
cursor cur(dept_name v_dname%type) is select e.ename, e.job, e.sal from emp e, dept d where e.deptno(+) = d.deptno and d.dname = dept_name;
begin
  for v in cur(v_dname) loop
    dbms_output.put_line(v.ename|| ', ' || v.job|| ', ' || v.sal);
    end loop;
    end;

--8、用游标获取所有收入超过2000的 salesman.
declare
cursor cur(v_sal number, v_job emp.job%type) is select * from emp where sal > v_sal and job = v_job;
begin
  for v in cur(2000, 'SALESMAN') loop
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.mgr|| ', ' || v.deptno|| ', ' || v.hiredate);
    end loop;
    end;

--9、编写一个PL/SQL程序块，从emp表中对名字以"A"或"S"开始的所有雇员按他们基本薪水的10%给他们加薪。
declare
cursor cur is select * from emp where instr(ename, 'A') = 1 or instr(ename, 'S') = 1;
begin
  for v in cur loop
    update emp set sal = sal * 1.1 where empno = v.empno;
    end loop;
    end;
    select * from emp;
  
--10、按照salgrade表中的标准，给员工加薪，1：5%，2：4%，3：3%，4：2%，5：1%， 
--并打印输出每个人，加薪前后的工资。
declare
cursor cur is select * from emp e, salgrade s where e.sal between s.losal and s.hisal;
v_emp emp%rowtype;
begin
   for v in  cur loop
     if v.grade = 1 then
       update emp set sal = sal * 1.05 where empno = v.empno;
       elsif v.grade = 2 then
         update emp set sal = sal * 1.04 where empno = v.empno;
         elsif v.grade = 3 then
           update emp set sal = sal * 1.03 where empno = v.empno;
           elsif v.grade = 4 then
             update emp set sal = sal * 1.02 where empno = v.empno;
             else
               update emp set sal = sal * 1.01 where empno = v.empno;
               end if;
               select * into v_emp from emp where empno = v.empno;
               dbms_output.put_line(v.empno || ', before: ' || v.sal || ', after: ' || v_emp.sal);
               end loop;
               rollback;
               end;
               
