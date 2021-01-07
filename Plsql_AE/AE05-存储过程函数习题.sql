1.写一个存储过程，输入员工信息，在emp表中插入一条员工信息

create or replace procedure p1(v in emp%rowtype)
is
begin
  insert into emp values (v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno);
  end;
  
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

create or replace procedure p2(v in varchar2) is
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
----------------------------------------
declare
m varchar2(300);
begin
  m := '1111,takami,worker,222,19951109,500,50,10';
  p2(m);
  end;
----------------------------------------
call p2(&v);  
select * from emp;

  
3.写一个存储过程，根据输入的参数,修改员工信息，
 注：如果只输入员工姓名，那么就只修改姓名
     如果输入多个值，则修改员工的多个信息
     例如：输入员工的姓名、工作、工资，则要求
     把姓名、工作、工资信息都修改
     create or replace procedure p3 (v emp%rowtype)
     is
     begin
       update emp set ename = nvl(v.ename, ename), job = nvl(v.job, job), sal = nvl(v.sal, sal) where empno = v.empno;
       end;
       
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
         p3(v);
         end;
         select * from emp;
         
4.查找出当前用户模式下，每张表的记录数，以scott用户为例，结果应如下：
DEPT...................................4
EMP...................................14
BONUS.................................0
SALGRADE.............................5
提示：查找用户下所有表名的sql为select table_name from user_tables;

/*create table ttt as select * from emp where 1=0;
select * from emp;
create or replace procedure p4 is
begin
  for i in (select ut.table_name tn, count(*) c
              from user_tables ut, user_tab_cols ut_c
             where ut.TABLE_NAME(+) = ut_c.TABLE_NAME
             group by ut.TABLE_NAME) loop
    -- select table_name tn, count(*) c from user_tables ut, user_tab_cols ut_c where ut.TABLE_NAME(+) = ut_c.TABLE_NAME  group by ut.TABLE_NAME;
    dbms_output.put_line(i.tn || rpad('.', 50, '.') || i.c);
  end loop;
  end; 
  call p4();*/
  
  create or replace procedure p4
  is
  begin
    for i in (select * from user_tables) loop
      dbms_output.put_line(i.table_name || rpad('.', 50, '.') || nvl(i.num_rows,0));
      end loop;
      end;
    call p4();
    
   /* for i in (select table_name from user_tables ) loop
      for n in (select count(1) from table(i.table_name)) loop
      --dbms_output.put_line(i.table_name);
     --select count(*) into n from i.table_name;
       dbms_output.put_line(i.table_name || rpad('.', 50, '.') || n);
       end loop;
     end loop;
     end;*/
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
select * from cc for update;

declare
cursor cur is select * from 
    
6.创建一个过程，能向dept表中添加一个新记录.（in参数）
create or replace procedure p6(d in dept%rowtype)
is
begin
  insert into dept values()
  d.deptno := &deptno;
  d.dname := '&dname';
  d.loc := '&loc';
  end
7.创建一个过程，从emp表中带入雇员的姓名，返回该雇员的薪水值。（out参数）
8.对所有员工,如果该员工职位是MANAGER，并且在DALLAS工作那么就给他薪金加15％；如果该员工职位是CLERK，并且在NEW YORK工作那么就给他薪金扣除5％;其他情况不作处理
对所有员工,如果该员工部门是SALES，并且工资少于1500那么就给他薪金加15％；如果该员工部门是RESEARCH，并且职位是CLERK那么就给他薪金增加5％;其他情况不作处理 
9.对直接上级是'BLAKE'的所有员工，按照参加工作的时间加薪：
81年6月以前的加薪10％
81年6月以后的加薪5％
10.编写一PL/SQL，对所有的"销售员"(SALESMAN)增加佣金500.
11.编写一个PL/SQL程序块，对名字以"A"或"S"开始的所有雇员按他们的基本薪水的10%加薪。
12.编写一PL/SQL，以提升两个资格最老的"职员"为"高级职员"。（工作时间越长，优先级越高）

13.显示EMP中的第四条记录。
create or replace procedure p13(n in number)
is 
v emp%rowtype;
--v_sql varchar2(300) := 'select * from (select emp.*, rownum rn from emp) t where t.rn = n'; 
begin
  select empno, ename, job, mgr, hiredate, sal, comm, deptno into v from (select emp.*, rownum rn from emp) t where t.rn = n;
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
  end;
 
call p13(4);
    
14.编写一个给特殊雇员加薪10%的过程，这之后，检查如果已经雇佣该雇员超过60个月，则给他额外加薪3000.
create or replace procedure p1
is
begin
  
