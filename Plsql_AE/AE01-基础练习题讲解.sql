1.写一个plsql代码块，输入一个部门编号，查询出该部门下工资最高的员工信息并打印
select into 
execute immediate into 
%rowtype

select * from (select * from emp where deptno=10 order by sal desc) where rownum=1;

select * from emp where deptno=10 and sal = (select max(sal) from emp where deptno=10) and rownum=1;

declare
  --声名一个变量保存一条员工的信息
  v emp%rowtype;
  --声名一个变量保存部门编号
  dno emp.deptno%type:=&部门编号;
begin
  --select into 语句查询
  select * into v from (select * from emp where deptno=dno order by sal desc) where rownum=1;
  --打印
  dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
end;

declare
   --声名一个变量保存一条员工信息
   v emp%rowtype;
   --声名一个变量保存sql语句
   v_sql varchar2(300);

begin
   v_sql:='select * from (select * from emp where deptno=:1 order by sal desc) where rownum=1';
   --使用execute immediate执行
   execute immediate v_sql into v using &部门编号;
   dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
end;

2.写一个代码块，查询出平均工资最高的的部门信息，并打印结果
1）.先查询出平均工资最高的部门编号
select deptno from (select deptno,avg(sal) from emp group by deptno order by 2 desc) where rownum=1;
2）.根据部门编号，查询出部门的信息
select * from dept where deptno=?

declare
  --声名一个变量保存部门编号
  dno emp.deptno%type;
  --声名一个变量保存dept表中的一条记录
  v dept%rowtype;
begin
  --查询平均工资最高的部门编号
  select deptno into dno from (select deptno,avg(sal) from emp group by deptno order by 2 desc) where rownum=1;
  --打印部门编号
  dbms_output.put_line(dno);
  --根据部门编号，去dept表中查询该部门的部门信息
  select * into v from dept where deptno=dno;
  --打印部门信息
  dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
end;

select t2.deptno, t2.dname, t2.loc
  from (select deptno, avg(sal) from emp group by deptno order by 2 desc) t1
  join dept t2
    on t1.deptno = t2.deptno
 where rownum = 1;

declare
   --声名一个变量保存一条部门信息
   v dept%rowtype;
begin
   select t2.deptno,t2.dname,t2.loc into v from (select deptno,avg(sal) from emp group by deptno order by 2 desc) t1 join dept t2 on t1.deptno=t2.deptno where rownum=1;
    --打印部门信息
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
end;
3.写一个代码块，输入一个工资值，给所有员工加薪
begin
  update emp set sal=sal+&工资;
end;
declare
   s number=&工资;
begin
  update emp set sal=sal+s;
end;

select * from emp;
4.写一个代码块，输入一个部门编号，查询该部门下的平均工资，总工资，最高工资，和最低工资，并打印
select avg(sal),sum(sal),max(sal),min(sal) from emp where deptno=10;

declare
  --声名一个变量保存部门编号
  dno number:=&部门编号;
  --声名四个变量分别保存部门的平均工资，总工资，最高工资，最低工资
  v1 number(6,2);
  v2 number(6,2);
  v3 number(6,2);
  v4 number(6,2);
begin
  select avg(sal),sum(sal),max(sal),min(sal) into v1,v2,v3,v4 from emp where deptno=dno;
  dbms_output.put_line(dno||'部门，平均工资:'||v1||',总工资：'||v2||',最高工资:'||v3||',最低工资：'||v4);
  
end;

5.写一个代码块，输入一个部门名称，查询该部门下，资历最老的员工信息并打印
1)根据部门名称查询出部门编号
select deptno from dept where dname='';
2)根据查询出的部门编号，去emp表中查询资历最老的员工
select * from (select * from emp where deptno=? order by hiredate) where rownum=1
declare
   --声名一个变量保存部门编号
   dno number;
   --声名一个变量保存员工信息
   v emp%rowtype;
begin
   --根据部门名称查询部门编号 
   select deptno into dno from dept where dname='&部门名称';
   dbms_output.put_line(dno);
   --根据部门编号查询出该部门下资历最老的员工
   select * into v from (select * from emp where deptno=dno order by hiredate) where rownum=1;
   --打印查询结果
   dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
end;
select * from dept;
6.写一个代码块，输入一个员工编号，查询该员工的工资等级
select grade from emp join salgrade on sal between losal and hisal where empno=7369; 
declare
  --声名一个变量保存员工的工资等级
  n number(1);
begin
  --查询工资等级
  select grade into n from emp join salgrade on sal between losal and hisal where empno=&员工编号;
  --打印结果
  dbms_output.put_line('工资等级:'||n);
end;
7.写一个代码块，创建一张dept_sum表，汇总部门下的人数，平均工资，总工资，最高工资，最低工资
部门编号 deptno number(4)
部门人数 total  number(5)
平均工资 avg_sal number(8,2)
总工资   sum_sal number(8,2)
最高工资 max_sal number(8,2)
最低工资 min_sal number(8,2)
create table dept_num(
   deptno number(4),
   total  number(5),
   avg_sal number(8,2),
   sum_sal number(8,2),
   max_sal number(8,2),
   min_sal number(8,2),
   dt date
)

insert into dept_num select deptno,count(1),avg(sal),sum(sal),max(sal),min(sal),sysdate from emp group by deptno;
--代码只能运行一次,执行前需要执行drop table dept_num
declare
   --声名一个变量保存sql语句
   v_sql varchar2(500);
begin
   --建表sql
   v_sql:='create table dept_num(
   deptno number(4),
   total  number(5),
   avg_sal number(8,2),
   sum_sal number(8,2),
   max_sal number(8,2),
   min_sal number(8,2),
   dt date
  )';
  --execute immediate
  execute immediate v_sql;  --表是动态创建的，insert语句也是需要使用execute immediate语句来运行
  --插入语句的sql
  v_sql:='insert into dept_num select deptno,count(1),avg(sal),sum(sal),max(sal),min(sal),sysdate from emp group by deptno';
  --使用execute immediate来执行
  execute immediate v_sql;
  --提交事务
  commit;
end;

select * from dept_num;

8.写一个代码块，输入一个部门编号，删除部门下的工资低于该部门平均工资的员工
delete from emp where deptno=10 and sal<(select avg(sal) from emp where deptno=10);
declare
   --声名一个变量保存输入的部门编号
   dno number:=&部门编号;
begin
   delete from emp where deptno=dno and sal < (select avg(sal) from emp where deptno=dno);
end;
select * from emp where deptno=10;

1)查询出该部门的平均工资
select avg(sal) from emp where deptno=?
2)根据条件进行删除
delete from emp where deptno=？ and sal<?;

declare
   --声名一个变量，保存输入的部门编号
   dno number:=&部门编号;
   --保存该部门的平均工资
   avg_sal number(6,2);
begin
   --查询部门的平均工资
   select avg(sal) into avg_sal from emp where deptno=dno;
   --删除员工信息
   delete from emp where deptno=dno and sal<avg_sal;
  
end;

declare
  
   --保存该部门的平均工资
   avg_sal number(6,2);
begin
   --查询部门的平均工资
   select avg(sal) into avg_sal from emp where deptno=&部门编号;
   --删除员工信息
   delete from emp where deptno=&部门编号 and sal<avg_sal;
  
end;

9.写一个代码块，创建一张emp表的备份表，表中除包含emp表所有列之外，还需要保存备份时间
  输入员工编号,员工职位，员工工资，员工的佣金，部门编号，根据员工编号修改员工的信息，
  在修改信息前，将原来的员工信息保存到备份表中
create table emp_bak as select emp.*,sysdate dt from emp where 1=0;

员工编号empno    v_empno number:=&员工编号
员工职位job      v_job varchar2(20):='&职位'
员工工资sal      v_sal number:=&员工工资
员工佣金comm     v_comm number:=&佣金
部门编号deptno   v_deptno number:=&部门编号
--根据员工编号查询出数据，并保存到表emp_bak中
insert into emp_bak select emp.*,sysdate from emp where empno=v_empno;

--修改员工信息
update emp set job=v_job,sal=v_sal,comm=v_comm,deptno=v_deptno where empno=v_empno;

declare
    v_empno number:=&员工编号;
    v_job varchar2(20):='&职位';
    v_sal number:=&员工工资;
    v_comm number:=&佣金;
    v_deptno number:=&部门编号;
begin
   --备份原数据
   insert into emp_bak select emp.*,sysdate from emp where empno=v_empno;
   --修改数据
   update emp set job=nvl(v_job,job),sal=nvl(v_sal,sal),comm=nvl(v_comm,comm),deptno=nvl(v_deptno,deptno) where empno=v_empno;
end;

select * from emp_bak;

select * from emp;
