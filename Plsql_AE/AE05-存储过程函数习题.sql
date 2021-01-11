
  drop procedure p2;
    drop procedure p3;
      drop procedure p4;
        drop procedure p5;
          drop procedure p6;
            drop procedure p7;

1.写一个存储过程，输入员工信息，在emp表中插入一条员工信息
create or replace procedure p01(v in emp%rowtype)
is
begin
  insert into emp values (v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno);
  end;
----------------------------------------------------------------------
declare
  v emp%rowtype;
  begin
    v.empno := &empno;
    v.ename := '&ename';
    v.job := '&job';
    v.mgr := &mgr;
    v.hiredate := &hiredate;
    v.sal := &sal;
    v.comm := &comm;
    v.deptno := &deptno;
    p1(v);
    end;

2.(变态题)写一个存储过程，输入一个字符串，在员工表中插入一条员工信息，字符串格式
员工编号,姓名,工作,上级编号,入职时间,佣金,部门编号
create or replace procedure p02(v in varchar2) is
/*declare
v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';*/
begin
  insert into emp
  values
    (substr(v, 1, instr(v, ',', 1, 1) - 1),
     substr(v,
            instr(v, ',', 1, 1) + 1,
            instr(v, ',', 1, 2) - instr(v, ',', 1, 1) - 1),
     substr(v,
            instr(v, ',', 1, 2) + 1,
            instr(v, ',', 1, 3) - instr(v, ',', 1, 2) - 1),
     substr(v,
            instr(v, ',', 1, 3) + 1,
            instr(v, ',', 1, 4) - instr(v, ',', 1, 3) - 1),
     to_date(substr(v,
            instr(v, ',', 1, 4) + 1,
            instr(v, ',', 1, 5) - instr(v, ',', 1, 4) - 1), 'yyyymmdd'),
     substr(v,
            instr(v, ',', 1, 5) + 1,
            instr(v, ',', 1, 6) - instr(v, ',', 1, 5) - 1),
     substr(v,
            instr(v, ',', 1, 6) + 1,
            instr(v, ',', 1, 7) - instr(v, ',', 1, 6) - 1),
     substr(v,
            instr(v, ',', 1, 7) + 1));
end;

select instr('aa,bb,cc', ',', -1, 1) from dual;
----------------------------------------
declare
m varchar2(300);
begin
  m := '1111,takami,worker,222,19951109,500,50,10';
  p02(m);
  end;
----------------------------------------
call p02('&v');  
select * from emp;
----------------------------------------
--declare
--v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
create or replace procedure p02(v varchar2)
is
n number;
tmp varchar2(20);
v_sql varchar2(300); 
vc varchar2(300) := '';
type ttype is table of varchar2(30);
t ttype;
begin
  n := (length(v) - length(replace(v, ',', '')) + 1);
  select data_type bulk collect into t from user_tab_cols where table_name = 'EMP';
  for i in 1..n loop
    if t(i) = 'DATE' then
      tmp := substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || 'to_date(''' || tmp || ''', ''yyyymmdd'')' || ',';
          else
    if i = 1 then
      tmp := substr(v, 1, instr(v, ',', 1, 1)-1);
      --dbms_output.put_line(tmp);
      vc := vc || '''' || tmp || '''' || ',';
      elsif i = n then
        tmp := substr(v, instr(v, ',', 1, i-1)+1);
        --dbms_output.put_line(tmp);
        vc := vc || tmp;   
        else
          tmp := substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || '''' || tmp || '''' || ',';
          end if;   
          end if;
    end loop;
    v_sql := 'insert into emp values('||vc||')';
    --dbms_output.put_line(vc);
    --dbms_output.put_line(v_sql);
    execute immediate v_sql;
    for m in (select * from emp) loop
    dbms_output.put_line(m.empno || ',' || m.ename);
    end loop;
    rollback;
    end;
    
declare
v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
begin
  p02(v);
  end;
--截取字符串(正则表达式)

--select regexp_substr('1111,takami,worker,222,19951109,500,50,10', '[^,]+', 1, 1) from dual;
create or replace procedure p02(v varchar2)
is
--declare
--v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
n number;
tmp varchar2(20);
v_sql varchar2(300); 
vc varchar2(300) := '';
type ttype is table of varchar2(30);
t ttype;
begin
  n := (length(v) - length(replace(v, ',', '')) + 1);
  select data_type bulk collect into t from user_tab_cols where table_name = 'EMP';
  for i in 1..n loop
    if t(i) = 'DATE' then
      tmp := regexp_substr(v, '[^,]+', 1, i);
      --substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || 'to_date(''' || tmp || ''', ''yyyymmdd'')' || ',';
          else
   /* if i = 1 then
      tmp := regexp_substr(v, [^,]+, 1, i);
      --substr(v, 1, instr(v, ',', 1, 1)-1);
      dbms_output.put_line(tmp);
      vc := vc || '''' || tmp || '''' || ',';*/
      if i = n then
        tmp := regexp_substr(v, '[^,]+', 1, i);
        --substr(v, instr(v, ',', 1, i-1)+1);
        --dbms_output.put_line(tmp);
        vc := vc || tmp;   
        else
          tmp := regexp_substr(v, '[^,]+', 1, i);
          --substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || '''' || tmp || '''' || ',';
          end if;   
          end if;
    end loop;
    v_sql := 'insert into emp values('||vc||')';
    --dbms_output.put_line(vc);
    --dbms_output.put_line(v_sql);
    execute immediate v_sql;
    /*for m in (select * from emp) loop
    dbms_output.put_line(m.empno || ',' || m.ename);
    end loop;*/
    --rollback;
    end;

declare
v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
begin
  p02(v);
  end;
--创建路径
grant create any directory to scott;  
create or replace directory d01 as 'E:\data';
--文件写入
declare
n number := 1111;
v varchar2 (300) := ',takami,worker,222,19951109,500,50,10';
vc varchar2(300);
f utl_file.file_type;
begin
  f := utl_file.fopen('D01', 'test.txt', 'w');
  /*v := to_char(n) || v;
  dbms_output.put_line(v);
  utl_file.put_line(f,v);*/
  for i in 1..8 loop
    vc := to_char(n) || v;
    n := n + 1111;
    utl_file.put_line(f,vc);
    end loop;
  utl_file.fclose(f);
  end;
--文件导出  
declare
f utl_file.file_type;
v varchar2(300);
begin
  f := utl_file.fopen('D01', 'test.txt', 'r');
  begin
  loop
    utl_file.get_line(f, v);
    p02(v);
    end loop;
    exception 
      when no_data_found then
        null;
        end;
  utl_file.fclose(f);
  
  for i in (select * from emp) loop
  dbms_output.put_line(i.empno);
  end loop;
  rollback;
  end;

3.写一个存储过程，根据输入的参数,修改员工信息，
 注：如果只输入员工姓名，那么就只修改姓名
     如果输入多个值，则修改员工的多个信息
     例如：输入员工的姓名、工作、工资，则要求
     把姓名、工作、工资信息都修改
     create or replace procedure p03 (v emp%rowtype)
     is
     begin
       update emp set ename = nvl(v.ename, ename), job = nvl(v.job, job), sal = nvl(v.sal, sal) where empno = v.empno;
       end;
------------------------------------------------------------------     
       declare
       v emp%rowtype;
       begin
         v.empno := &empno;
         v.ename := '&ename';
         v.job := '&job';
         v.mgr := &mgr;
         v.hiredate := &hiredate;
         v.sal := &sal;
         v.comm := &comm;
         v.deptno := &deptno;
         p03(v);
         end;
         select * from emp;
         
4.查找出当前用户模式下，每张表的记录数，以scott用户为例，结果应如下：
DEPT...................................4
EMP...................................14
BONUS.................................0
SALGRADE.............................5
提示：查找用户下所有表名的sql为select table_name from user_tables;
  create or replace procedure p04
  is
  begin
    for i in (select * from user_tables) loop
      dbms_output.put_line(i.table_name || rpad('.', 50, '.') || nvl(i.num_rows,0));
      end loop;
      end;

call p04();
  -- ↑num_rows(oracle定期更新，时效性差)↑  
---------------------------------------------------------------------------- 
  -- ↓拼接sql语句↓
  create or replace procedure p04
  is
  v_sql varchar2(300):= 'select count(1) from ';
  n number;
  begin
    for v in (select table_name from user_tables ) loop
      execute immediate concat(v_sql, v.table_name) into n;
       dbms_output.put_line(v.table_name || rpad('.', 50, '.') || n);
     end loop;
     end;
------------------------------------------------------   
call p04();
     
5.某cc表数据如下：
c1 c2
--------------
1 西
1 安
1 的
2 天
2 气
3 好
……
转换为
1 西安的
2 天气
3 好
要求：不能改变表结构及数据内容
create table cc(
c1 number(2),
c2 varchar2(20));
insert into cc values (1, '西');
insert into cc values (1, '安');
insert into cc values (1, '的');
insert into cc values (2, '天');
insert into cc values (2, '气');
insert into cc values (3, '好');
commit;
select * from cc; 
----------------------------------------------------
create or replace procedure p05 
is
cursor cur1 is select c1 from cc group by c1;
cursor cur2(n number) is select * from cc where c1 = n;
begin
  for v in cur1 loop
    dbms_output.put(v.c1 || ' ');
    for m in cur2(v.c1) loop
      dbms_output.put(m.c2);
      end loop;
      dbms_output.new_line();
      end loop;
      end;
-----------------------------------------------------     
call p05();

6.创建一个过程，能向dept表中添加一个新记录.（in参数）
create or replace procedure p06(d in dept%rowtype)
is
begin
  insert into dept values(d.deptno, d.dname, d.loc);
  end;
  
  declare
  d dept%rowtype;
  begin
  d.deptno := &deptno;
  d.dname := '&dname';
  d.loc := '&loc';
  p06(d);
  rollback;
  end;
  
7.创建一个过程，从emp表中带入雇员的姓名，返回该雇员的薪水值。（out参数）
create or replace procedure p07 (v_ename in varchar2, v_sal out number)
is
begin
  select sal into v_sal from (select * from emp where ename = v_ename) where rownum = 1;
  end;
---------------------------------------------------------------------------------------------- 
  declare
  v_e varchar2(20):= 'SMITH';
  v_s number;
  begin
    p07(v_e, v_s);
    dbms_output.put_line(v_s);
    end;
    
8.
对所有员工,如果该员工职位是MANAGER，并且在DALLAS工作那么就给他薪金加15％；
如果该员工职位是CLERK，并且在NEW YORK工作那么就给他薪金扣除5％;其他情况不作处理
对所有员工,如果该员工部门是SALES，并且工资少于1500那么就给他薪金加15％；
如果该员工部门是RESEARCH，并且职位是CLERK那么就给他薪金增加5％;其他情况不作处理 
select * from emp;
select * from dept;
---------------------------------------------------
create or replace procedure p08
is
cursor cur is select e.empno, e.job, e.sal, d.dname, d.loc  from emp e, dept d where e.deptno = d.deptno;
begin
  for v in cur loop
    if v.job = 'MANAGER' and v.loc = 'DALLAS' then
      v.sal := v.sal * 1.15;
      elsif v.job = 'CLERK' and v.loc = 'NEW YORK' then
        v.sal := v.sal * 0.95;
        elsif v.dname = 'SALES' and v.sal < 1500 then
          v.sal := v.sal * 1.15;
          elsif  v.dname = 'RESEARCH' and v.job = 'CLERK'then
            v.sal := v.sal * 1.05;
            else
              null;
              end if;
              update emp set sal = v.sal where empno = v.empno;
    end loop;
  end;
------------------------------------------------------------------------------
begin
p08;
for v in (select * from emp) loop
dbms_output.put_line(v.empno|| ',' || v.sal|| ',' || v.deptno|| ',' || v.job);
end loop;
rollback;
end;

9.对直接上级是'BLAKE'的所有员工，按照参加工作的时间加薪：
81年6月以前的加薪10％
81年6月以后的加薪5％
create or replace procedure p09(mgn in varchar2)
is
cursor cur(ena emp.ename%type) is select e1.empno as empno, e1.sal as sal, e1.hiredate as hiredate, e2.ename as mgrname from emp e1, emp e2 where e1.mgr = e2.empno and e2.ename = /*'BLAKE'*/ena;
begin
  for v in cur(mgn) loop
    if v.hiredate < to_date('19810601', 'yyyymmdd') then
      v.sal := v.sal * 1.1;
      else
        v.sal := v.sal * 1.05;
        end if;
        update emp set sal = v.sal where empno = v.empno;
        end loop;
  end;
-------------------------------------------------------------------------------
declare
v_mgn varchar2(10):= 'BLAKE';
cursor cur(ena emp.ename%type) is select e1.empno as empno, e1.sal as sal, e1.hiredate as hiredate, e2.ename as mgrname from emp e1, emp e2 where e1.mgr = e2.empno and e2.ename = /*'BLAKE'*/ena;
begin
  for v in cur(v_mgn) loop
    dbms_output.put_line(v.empno || ', ' || v.mgrname || ', ' || v.sal);
    end loop;
  p09(v_mgn);
    dbms_output.put_line(rpad('-', 50, '-'));
  for v in cur(v_mgn) loop
    dbms_output.put_line(v.empno || ', ' || v.mgrname || ', ' || v.hiredate || ', ' || v.sal);
    end loop;
    rollback;
    end;
    
10.编写一PL/SQL，对所有的"销售员"(SALESMAN)增加佣金500.
create or replace procedure p10(v_job in varchar2)
is
/*declare
v_job varchar2(30) := 'SALESMAN';*/
v_sql varchar2(300):= 'update emp set comm = nvl(comm,0) + 500 where job = :1';-- cursor cur(v_job emp.job%type) is select * from emp;
begin
  execute immediate v_sql using v_job;
  end;
----------------------------------------------------------------------------------  
declare
v_job varchar2(30):= 'SALESMAN';
begin
  for v in (select * from emp where job = v_job) loop
    dbms_output.put_line(v.empno || ', ' || v.job || ', ' || v.comm);
    end loop;
  p10(v_job);
  dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from emp where job = v_job) loop
    dbms_output.put_line(v.empno || ', ' || v.job || ', ' || v.comm);
    end loop;
    rollback;
    end; 
  
11.编写一个PL/SQL程序块，对名字以"A"或"S"开始的所有雇员按他们的基本薪水的10%加薪。
create or replace procedure p11(n in varchar2)
is
v_sql varchar2(300) := 'update emp set sal = sal * 1.1 where instr(ename, :1) = 1';
begin
  execute immediate v_sql using n;
  end;
 -------------------------------------------------------------------------- 
begin
  for v in (select * from emp where ename like 'A%' or ename like 'S%') loop
    dbms_output.put_line(v.ename || ', ' || v.sal);
    end loop;
    p11('A');
    p11('S');
    dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from emp where ename like 'A%' or ename like 'S%') loop
    dbms_output.put_line(v.ename || ', ' || v.sal);
    end loop;
    rollback;
    end;  
  
12.编写一PL/SQL，以提升两个资格最老的"职员"为"高级职员"。（工作时间越长，优先级越高）
alter table emp modify job varchar2(30);
------------------------------------------------------------------
create or replace procedure p12
is
v emp%rowtype;
cursor cur is select * from emp where job = 'CLERK' order by hiredate asc;
begin
  open cur;
  loop
    fetch cur into v;
    update emp set job = 'SENIOR_CLERK' where empno = v.empno;
    exit when cur%rowcount = 2;
    end loop;
    close cur;
  end;
-------------------------------------------------------------
begin 
  for v in (select * from emp where job = 'CLERK') loop
    dbms_output.put_line(v.empno || ', ' || v.ename || ', ' || v.job || ', ' || v.hiredate);
    end loop;
    p12;
    dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from emp where job in ('CLERK', 'SENIOR_CLERK')) loop
    dbms_output.put_line(v.empno || ', ' || v.ename || ', ' || v.job || ', ' || v.hiredate);
    end loop;
    rollback;
    end;
    
13.显示EMP中的第四条记录。
create or replace procedure p13(n in number)
is 
v emp%rowtype;
begin
  select empno, ename, job, mgr, hiredate, sal, comm, deptno into v from (select emp.*, rownum rn from emp) t where t.rn = n;
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
  end;
------------------------------------------------------------------------------------
call p13(4);

---------------------------------------

create or replace procedure p13(n in number)
is
cursor cur is select * from emp;
v emp%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    null;
    exit when cur%rowcount = 4;
    end loop;
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
  close cur;
  end;
-------------------------------------- 
  call p13(4);
14.编写一个给特殊雇员加薪10%的过程，这之后，
检查如果已经雇佣该雇员超过60个月，则给他额外加薪3000.
create or replace procedure p14
is
o_sal number;
cursor cur is select * from emp;
begin
  for v in cur loop
    v.sal := v.sal * 1.1;
    if months_between(sysdate, v.hiredate) > 60 then
      v.sal := v.sal +3000;
      end if;
      select sal into o_sal from emp where empno = v.empno;
      update emp set sal = v.sal where empno = v.empno;
      dbms_output.put_line(v.empno|| ', 就职时间: ' || trunc(months_between(sysdate, v.hiredate),1)|| ', 新工资: ' || v.sal|| ', 旧工资: ' || o_sal);
      end loop;
      rollback;
      end; 
---------------------------------------------------------------
call p14();      


