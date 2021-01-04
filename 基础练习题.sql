1.写一个plsql代码块，输入一个部门编号，查询出该部门下工资最高的员工信息并打印

declare 
dno number := &deptno;
v emp%rowtype;
begin
select * into v from (select * from emp where deptno = dno order by sal desc) where rownum = 1;
dbms_output.put_line(v.empno || ',' || v.ename || ',' || v.job || ',' || v.deptno);
end;

2.写一个代码块，查询出平均工资最高的员工所有的部门信息，并打印结果

declare
dno number;
v dept%rowtype;
begin
  select * into dno from (select deptno from emp group by deptno order by avg(sal) desc) where rownum = 1;
  select * into v from dept where deptno = dno;
--select * into v from (select * from dept where deptno in (select deptno from emp group by deptno order by avg(sal) desc)) where rownum = 1);
dbms_output.put_line(v.deptno || ',' || v.dname || ',' || v.loc);
end;

3.写一个代码块，输入一个工资值，给所有员工加薪
declare 
v_sal number:= &bonus;
begin
  update emp set sal = sal + v_sal;
  end;

select * from emp;
rollback;
  
4.写一个代码块，输入一个部门编号，查询该部门下的平均工资，总工资，最高工资，和最低工资，并打印

declare 
dno emp.deptno%type := &dno;
v_avg number;
v_sum number;
v_max number;
v_min number;
begin
select avg(sal), sum(sal), max(sal), min(sal) into v_avg, v_sum, v_max, v_min from emp where deptno = dno; 
dbms_output.put_line(v_avg || ',' ||  v_sum || ',' ||  v_max || ',' ||  v_min);
end;

5.写一个代码块，输入一个部门名称，查询该部门下，资历最老的员工信息并打印

select * from dept;
select * from emp;

declare
dna dept.dname%type := '&dname';
v emp%rowtype;
begin
select * into v from (select e.* from emp e join dept d on e.deptno = d.deptno where d.dname = dna order by e.hiredate asc) where rownum = 1;
dbms_output.put_line(v.ename || ',' || v.empno || ',' || v.deptno);
end;

6.写一个代码块，输入一个员式编号，查询该员工下的工资等级
commit;
select table_name from user_tables;
select * from salgrade;

declare 
eno emp.empno%type := &eno;
v number(1);
begin
select grade into v from (select * from emp e join salgrade s on e.sal between s.losal and s.hisal) where empno = eno;
dbms_output.put_line(v);
end;

7.写一个代码块，创建一张dept_sum表，汇总部门下的人数，平均工资，总工资，最高工资，最低工资

declare
n number;
v_sql varchar2(300):= 'insert into dept_sum select deptno, count(1), avg(sal), sum(sal), max(sal), min(sal) from emp group by deptno';
--v dept_sum%rowtype;
begin
  select count(1) into n from user_tables where table_name = 'dept_sum';
  if n = 0 then
    execute immediate 'create table dept_sum(deptno number, members number, avg_sal number, sum_sal number, max_sal number, min_sal number)';
    end if;
    execute immediate v_sql;
    --select * into v from dept_sum;
    --dbms_output.put_line(v.deptno || ', ' || v.member || ', ' || v.avg_sal);
    end;
      select * from dept_sum;


8.写一个代码块，输入一个部门编号，删除部门下的工资低于该部门平均工资的员工

declare
  dno   number(2) := &dno;
  v_sql varchar2(300) := 'delete from (select * from emp where deptno = :1 and sal < (select avg(sal) from emp where deptno = :2)) where rownum = 1';
begin
  execute immediate v_sql
    using dno, dno;
end;
rollback;

9.写一个代码块，创建一张emp表的备份表，表中除包含emp表所有列之外，还需要保存备份时间
  输入员工编号 || ',' || 员工职位，员工工资，员工的佣金，部门编号，根据员工编号修改员工的信息，
  在修改信息前，将原来的员工信息保存到备份表中

