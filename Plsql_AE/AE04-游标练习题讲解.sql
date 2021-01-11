--1、用游标显示所有部门编号与名称，以及其所拥有的员工人数。

select t1.deptno, t1.dname, count(t2.empno)
  from dept t1
  left join emp t2
    on t1.deptno = t2.deptno
 group by t1.deptno, t1.dname;
 
declare
   --定义一个游标
   cursor cur is select t1.deptno,t1.dname,count(t2.empno) a from dept t1 left join emp t2 on t1.deptno=t2.deptno group by t1.deptno,t1.dname;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --遍历游标
   loop
     --fetch into
     fetch cur into v;
     --退出条件
     exit when cur%notfound;
     --循环体语句
     dbms_output.put_line(v.deptno||','||v.dname||','||v.a);
   end loop;
   --关闭游标
   close cur;
end;

--查询出部门信息，根据部门编号，查询该部门的人数
declare
   --定义一个游标
   cursor cur is select * from dept;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
   --声名一个变量保存员工人数
   n number;
begin
   --使用游标获取到部门信息
   --打开游标
   open cur;
   --遍历
   fetch cur into v;
   while cur%found loop
     --根据部门编号查询部门下的员工人数
     select count(*) into n from emp where deptno=v.deptno;
     --打印信息
     dbms_output.put_line(v.deptno||','||v.dname||','||n);
     --fetch into
     fetch cur into v;
   end loop;
   --关闭游标
   close cur;
end;

--2、用游标属性%rowcount实现输出前十个员工的信息。

declare
   --定义一个游标
   cursor cur is select * from emp;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --遍历
   loop
      --fetch into
      fetch cur into v;
      --退出循环语句
      exit when cur%notfound or cur%rowcount>=11;
      --循环体语句
      dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   
   end loop;
   --关闭游标
   close cur;
end;

declare
   --定义游标
   cursor cur is select * from emp;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --遍历
   fetch cur into v;
   while cur%found and cur%rowcount<=10 loop
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
     fetch cur into v;
   end loop;
   --关闭游标
   close cur;
end;

declare
   --定义一个游标
   cursor cur is select * from emp;
begin
   for v in cur loop
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
     exit when cur%rowcount>=10;  
   end loop;
end;
--3、通过使用游标来显示dept表中的部门名称，及其相应的员工列表（提示：可以使用双重循环）。
declare
   --定义一个游标，用来遍历dept表中的部门信息
   cursor c1 is select * from dept;
   --定义一个游标，根据部门编号查询部门下的员工信息
   cursor c2(dno number) is select * from emp where deptno=dno; 
begin
   for v1 in c1 loop
      --遍历获取部门信息
      dbms_output.put_line('部门名称:'||v1.dname);
      --根据部门编号查询出部门下的员工信息
      for v2 in c2(v1.deptno) loop
        dbms_output.put_line(v2.ename);
      end loop;
      
      ---打个分隔线
      dbms_output.put_line(rpad('-',50,'-'));
   end loop;
end;

select t1.dname,t2.ename from dept t1 left join emp t2 on t1.deptno=t2.deptno order by t1.dname;

declare
   --定义一个游标
   cursor cur is select t1.dname,t2.ename from dept t1 left join emp t2 on t1.deptno=t2.deptno order by t1.dname;
   --定义两个变量，保存部门名称,v_old和v_new是用来判断是否是一个新的部门，如果是新的部门则打印部门信息，如果相同表示部门信息已经打印，不需要再次打印，只需要打印员工姓名
   v_old varchar2(30):='';
   v_new varchar2(30):='';
begin
   for v in cur loop
     --将部门名称放入变量v_new中
     v_new:=v.dname;
     --判断v_new和v_old是否相同
     if v_new != v_old or v_old is null then
        --将v_new保存的部门放入v_old中
        v_old:=v_new;
        dbms_output.put_line(rpad('-',50,'-'));
        --打印部门名称
        dbms_output.put_line('部门名称:'||v_new);
        --打印员工姓名
        dbms_output.put_line(v.ename);
     else
       --表示 v_new=v_old,只打印员工姓名
        dbms_output.put_line(v.ename);
     end if;
   
   end loop;
end;

--4、接受一个部门号，使用For循环，从emp表中显示该部门的所有雇员的姓名，工作和薪水。
declare
   --定义一个游标
   cursor cur is select ename,job,sal from emp where deptno=&部门编号;
begin
   for v in cur loop
      dbms_output.put_line(v.ename||','||v.job||','||v.sal);
   end loop;
end;
declare
   --定义一个游标
   cursor cur(dno number) is select ename,job,sal from emp where deptno=dno;
begin
   for v in cur(&部门编号) loop
      dbms_output.put_line(v.ename||','||v.job||','||v.sal);
   end loop;
end;


--5、编写一个程序块，将emp表中前5人的名字，及其出的工资等级（salgrade）显示出来。
select ename,grade from emp join salgrade on sal between losal and hisal where rownum<=5;
declare
   --定义一个游标
   cursor cur is select ename,grade from emp join salgrade on sal between losal and hisal where rownum<=5;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --遍历
   loop
     --fetch into
     fetch cur into v;
     --退出循环语句
     exit when cur%notfound;
     --打印结果
     dbms_output.put_line(v.ename||','||v.grade);
   end loop;
   --关闭游标
   close cur;
  
end;

declare
   --定义一个游标
   cursor cur is select ename,grade from emp join salgrade on sal between losal and hisal;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --遍历
   loop
     --fetch into
     fetch cur into v;
     --退出循环语句
     exit when cur%notfound or cur%rowcount>=6;
     --打印结果
     dbms_output.put_line(v.ename||','||v.grade);
   end loop;
   --关闭游标
   close cur;
end;

declare
   --定义一个游标
   cursor cur is select ename,sal from emp where rownum<=5;
   --声名一个变量保存员工的工资等级
   s number;
   
begin
   for v in cur loop
     --先查询前5个员工信息
   
     --根据员工的工资在salgrade表中查询员工的工资等级
     select grade into s from salgrade where v.sal between losal and hisal;
     --打印结果
     dbms_output.put_line(v.ename||','||s);
   end loop;
end;

--6、用带参数的游标输出部门编号为10， 30的员工信息。
declare
    --定义一个游标，传入部门编号，根据部门编号查询员工信息
    cursor cur(dno number) is select * from emp where deptno=dno;
    --声名一个变量保存游标的一条记录
    v cur%rowtype;
begin
    --查询10号部门的员工
    --打开游标
    open cur(10);
    --遍历
    fetch cur into v;
    while cur%found loop
       dbms_output.put_line(v.ename||','||v.job||','||v.sal||','||v.deptno);
       fetch cur into v;
    end loop;
    --关闭游标
    close cur;
    
    --查询30号部门的员工
    --打开游标
    open cur(30);
    --遍历
    fetch cur into v;
    while cur%found loop
       dbms_output.put_line(v.ename||','||v.job||','||v.sal||','||v.deptno);
       fetch cur into v;
    end loop;
    --关闭游标
    close cur;
end;

--7、使用带参数的游标，实现接受一个部门名称，从emp表中显示该部门的所有雇员的姓名，工作和薪水。
select ename,job,sal from emp where deptno in (select deptno from dept where dname='');
select ename,job,sal from emp where exists (select 1 from dept where emp.deptno=deptno and dname='');

declare
   --定义一个游标
   cursor cur(v_dname varchar2) is select ename,job,sal from emp where deptno in (select deptno from dept where dname=v_dname);
   --声名一个变量保存游标中的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur('&部门名称');
   --遍历
   loop
      fetch cur into v;
      exit when cur%notfound;
      dbms_output.put_line(v.ename||','||v.job||','||v.sal);
   end loop;
   --关闭游标
   close cur;
end;

select * from dept;


--8、用游标获取所有收入超过2000的 salesman.
select * from emp where sal+nvl(comm,0)>2000 and job='SALESMAN';

declare
    --定义一个游标
    cursor cur is select * from emp where sal+nvl(comm,0)>2000 and job='SALESMAN';
begin
    for v in cur loop
      dbms_output.put_line(v.ename);
    end loop;
end;
--9、编写一个PL/SQL程序块，从emp表中对名字以"A"或"S"开始的所有雇员按他们基本薪水的10%给他们加薪。
declare
   --定义一个游标
   cursor cur is select * from emp where ename like 'A%' or ename like 'S%';
begin
   for v in cur loop
      update emp set sal=sal*1.1 where empno=v.empno;
   end loop;
end;


declare
   --定义一个游标
   cursor cur is select sal from emp where ename like 'A%' or ename like 'S%' for update;
begin
   for v in cur loop
      update emp set sal=sal*1.1 where current of cur; --where current of cur 表示更新游标当前行的数据
   end loop;
end;


--10、按照salgrade表中的标准，给员工加薪，1：5%，2：4%，3：3%，4：2%，5：1%， 
--并打印输出每个人，加薪前后的工资。
select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 


declare
   --定义一个游标
   cursor cur is select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 
begin
   for v in cur loop
     --获取到每一个员工的信息 empno ename sal grade
     case grade
       when 1 then
         update emp set sal=sal*1.05 where empno=v.empno;
       when 2 then
         update emp set sal=sal*1.04 where empno=v.empno;
       when 3 then
         update emp set sal=sal*1.03 where empno=v.empno;
       when 4 then
         update emp set sal=sal*1.02 where empno=v.empno;
       else
         update emp set sal=sal*1.01 where empno=v.empno;
     end case;
   end loop;
  
end;

declare
   --定义一个游标
   cursor cur is select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 
begin
   for v in cur loop
     --获取到每一个员工的信息 empno ename sal grade
     dbms_output.put(v.ename||'加薪前的工资:'||v.sal);
     case v.grade
       when 1 then
         v.sal:=v.sal*1.05;
       when 2 then
         v.sal:=v.sal*1.04;
       when 3 then
         v.sal:=v.sal*1.03;
       when 4 then
         v.sal:=v.sal*1.02;
       else
         v.sal:=v.sal*1.01;
     end case;
     update emp set sal=v.sal where empno=v.empno;
     dbms_output.put_line(',加薪后的工资:'||v.sal);
   end loop; 
end;


declare
   --定义一个游标
   cursor cur is select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 
   --声名一个变量保存加薪后的工资
   v_sal emp.sal%type;
begin
   for v in cur loop
     --获取到每一个员工的信息 empno ename sal grade
     case v.grade
       when 1 then
         v_sal:=v.sal*1.05;
       when 2 then
         v_sal:=v.sal*1.04;
       when 3 then
         v_sal:=v.sal*1.03;
       when 4 then
         v_sal:=v.sal*1.02;
       else
         v_sal:=v.sal*1.01;
     end case;
     update emp set sal=v_sal where empno=v.empno;
     dbms_output.put_line(v.ename||'加薪前的工资:'||v.sal||',加薪后的工资:'||v_sal);
   end loop; 
end;
