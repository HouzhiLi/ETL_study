1.  写一个PLSQL代码块打印99乘法表格式（5分）
--------------------------------------------------
--------------------解答↓----------------------
-------------------------------------------------- 

-------------------------------------------------- 
2.	写一个PLSQL代码块打印99乘法表格式（5分）
--------------------------------------------------
----------------代码实现↓--------------------
-------------------------------------------------- 
declare
n number;
m number;
begin
  for n in 1..9 loop
    for m in 1..n loop
      dbms_output.put(rpad(n || 'x' || m || '=' || n*m, 10, ' '));
      end loop;
    dbms_output.put_line('');
    end loop;
    end;
--------------------------------------------------
3.	分别利用游标、集合遍历dept表中的数据（10分） 
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------   
declare
cursor cur is select * from dept;
begin
  for v in cur loop
    dbms_output.put_line(v.deptno|| ',' || v.dname|| ',' || v.loc);
    end loop;
    end;
--↑游标 ↓集合    
declare
type ntype is table of dept%rowtype;
n ntype;
begin
  select * bulk collect into n from dept;
  for i in n.first..n.last loop
    dbms_output.put_line(n(i).deptno|| ',' || n(i).dname|| ',' || n(i).loc);
    end loop;
    end;
-------------------------------------------------- 
4.	写一个匿名块，接受一个部门号和员工编号，输出对应的员工信息，
若部门不存在，则返回‘输入的部门不正确，请重新输入’，
若部门存在，员工不存在，则返回‘部门内不存在该员工’（10分）
--------------------------------------------------
--------代码实现（游标循环）↓----------
--------------------------------------------------
declare
dno number := 20;
eno number := 7369;
cursor cur1 is select * from dept where deptno = dno;
cursor cur2 is select * from emp where deptno = dno and empno = eno;
v dept%rowtype;
n emp%rowtype;
begin
  open cur1;
  loop
    fetch cur1 into v;
     if cur1%notfound then
       dbms_output.put_line('输入的部门不正确，请重新输入');
       exit;
     else
       open cur2;
       loop
         fetch cur2 into n;
         if cur2%notfound then
         dbms_output.put_line('部门内不存在该员工');
         exit;
         else
           dbms_output.put_line(n.empno|| ', ' || n.ename|| ', ' || n.job|| ', ' || n.mgr|| ', ' || n.hiredate|| ', ' || n.sal|| ', ' || n.comm|| ', ' || n.deptno);
           exit;
         end if;
       end loop;
       close cur2;
       exit;
     end if;
  end loop;
  close cur1;
end;
--------------------------------------------------
---------代码实现（匿名块）↓------------
--------------------------------------------------
declare
eno number := 7369;
dno number := 10;
d dept%rowtype;
e emp%rowtype;
v_sql varchar2(200);
begin
   select * into d from dept where deptno = dno;
    --dbms_output.put_line('deptno confirmed');
    begin
    select * into e from emp where deptno = dno and empno = eno;
    v_sql := e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno;
    dbms_output.put_line(v_sql);
    exception
      when no_data_found then   
        dbms_output.put_line('部门内不存在该员工');
    end;
    exception 
      when no_data_found then        
        dbms_output.put_line('输入的部门不正确，请重新输入');
        end;
--------------------------------------------------
--------代码实现（存储结构）↓----------
--------------------------------------------------
create or replace procedure pae99_04(dno in number, eno in number)
is
d dept%rowtype;
e emp%rowtype;
--v_sql varchar2(200);
begin
   select * into d from dept where deptno = dno;
    --dbms_output.put_line('deptno confirmed');
    begin
    select * into e from emp where deptno = dno and empno = eno;
    dbms_output.put_line(e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno);
    exception
      when no_data_found then   
        dbms_output.put_line('部门内不存在该员工');
    end;
    exception 
      when no_data_found then        
        dbms_output.put_line('输入的部门不正确，请重新输入');
        end;

call pae99_04(20, 7369);        
--------------------------------------------------
-----------代码实现（函数）↓-------------
--------------------------------------------------
create or replace function fae99_04(eno in number, dno in number)
return varchar2
is
--eno number := 7369;
--dno number := 10;
d dept%rowtype;
e emp%rowtype;
v_sql varchar2(200);
begin
   select * into d from dept where deptno = dno;
    --dbms_output.put_line('deptno confirmed');
    begin
    select * into e from emp where deptno = dno and empno = eno;
    v_sql := e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno;
    return v_sql;
    --dbms_output.put_line(e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno);
    exception
      when no_data_found then
        v_sql := '部门内不存在该员工';
        return v_sql;
        --dbms_output.put_line('部门内不存在该员工');
    end;
    exception 
      when no_data_found then
        v_sql := '输入的部门不正确，请重新输入';
        return v_sql;
        --dbms_output.put_line('输入的部门不正确，请重新输入');
        end;
       
       begin
       dbms_output.put_line(fae99_04(7369,20));
       end;
--------------------------------------------------
5.	有如下用户表
create table user_login(
		id number(11) primary key,
     username varchar2(30),
     password varchar2(32)
);

delete from user_login ul where ul.id = 2;
insert into user_login 
select 2, 'takami', 'wer665' from dual;
commit;
select * from user_login;
--------------------------------------------------
----------------建表代码↑--------------------
--------------------------------------------------
写一个函数，实现用户的登陆功能，传入用户名和密码，
当前用户名和密码都正确时，返回“登陆成功”，
如果用户名不存在，返回“该用户不存在，请先注册”，
如果密码不正确，则返回“用户名或密码不正确”(10分)
--------------------------------------------------
create table dept_bak as select * from dept where 1 = 0;
select * from dept_bak;
--------------------------------------------------
----------------调试代码↑--------------------
--------------------------------------------------
declare
type ctype is table of dept_bak%rowtype index by pls_integer;
c ctype;
begin
  select * bulk collect into c from dept_bak;
  for v in c.first..c.last loop
    dbms_output.put_line(c(v).deptno || ', ' || c(v).dname || ', ' || c(v).loc);
    end loop;
  end;
--------------------------------------------------
----------------调试代码↑--------------------
--------------------------------------------------
--------------使用异常处理↓----------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
not_matched exception;
pragma exception_init(not_matched, -06502);
s varchar2(200);
type ctype is table of user_login%rowtype index by pls_integer;
c ctype;
v user_login%rowtype;
  begin
    select ul.* bulk collect into c from user_login ul where ul.username = uname;
    for i in c.first..c.last loop
      null;
      end loop;
    begin 
    select ul.* bulk collect into c from user_login ul where ul.username = uname and ul.password = pwd;
    for i in c.first..c.last loop
      null;
    end loop;
    s := '登陆成功';
    return s;
    exception
      when not_matched then
        s := '用户名或密码不正确';
        return s;
    end;
  exception
    when not_matched then
      s := '该用户不存在，请先注册';
      return s;
  end;
--------------------------------------------------
----------------测试代码↓--------------------
--------------------------------------------------
begin
  dbms_output.put_line(fae99_05('takami', 'Fils1109'));
  dbms_output.put_line(fae99_05('takami', 'wer665')); 
  dbms_output.put_line(fae99_05('11', 'Fils1109'));
  dbms_output.put_line(fae99_05('takami', 'wer'));
end;
--------------------------------------------------
----------------测试代码↑--------------------
--------------------------------------------------
---------------使用流程控制↓---------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
s varchar2(200);
flag number := 0;
begin
  for i in (select * from user_login) loop
    if i.username = uname then
      for v in (select * from user_login ul where ul.username = i.username) loop
        if v.password = pwd then
          flag := 1;
          exit;
        else
          flag := 2;
        end if;
      end loop;
      exit;
    else
      null;
    end if;
  end loop;
  
  case flag
    when 0 then
      s := '该用户不存在，请先注册';
      when 1 then
        s := '登陆成功';
        when 2 then
          s := '用户名或密码不正确';
          end case;
          return s;
end;
--------------------------------------------------
------------假设用户名不唯一↑
--------------------------------------------------
-------------假设用户名唯一↓
--------------------------------------------------
begin
delete from user_login u where u.id = 2;
insert into user_login values (2, 'houzhi', 'wer665');
commit;
end;
select * from user_login;
--------------------------------------------------
-------------修改数据代码↑-----------------
--------------------------------------------------
-------------使用异常处理↓-----------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
v user_login%rowtype;
s varchar2(200);
begin
  select * into v from user_login ul where ul.username = uname;
  begin
    select * into v from user_login ul where ul.username = uname and ul.password = pwd;
    s := '登陆成功';
    return s;
    exception
    when no_data_found then
      s := '用户名或密码不正确';
      return s;
  end;
  exception
    when no_data_found then
      s := '该用户不存在，请先注册';
      return s;
end;
--------------------------------------------------
----------------测试代码↓--------------------
--------------------------------------------------
begin
  dbms_output.put_line(fae99_05('takami', 'Fils1109'));
  dbms_output.put_line(fae99_05('houzhi', 'wer665')); 
  dbms_output.put_line(fae99_05('11', 'Fils1109'));
  dbms_output.put_line(fae99_05('takami', 'wer'));
end;
--------------------------------------------------
----------------测试代码↑--------------------
--------------------------------------------------
-------------使用流程控制↓-----------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
s varchar2(200);
flag number := 0;
begin
  for v in (select * from user_login) loop
    if v.username = uname then
      for i in (select * from user_login ul where ul.username = v.username) loop
        if i.password = pwd then
          flag := 1;
          exit;
        else
          flag := 2;
        end if;
      end loop;
      exit;
    else
      null;
    end if;
  end loop;
  
  case flag
    when 0 then
      s := '该用户不存在，请先注册';
    when 1 then
      s := '登陆成功';
    when 2 then
      s := '用户名或密码不正确';
    end case;
    return s;
end;
--------------------------------------------------
6.	有如下表account（账户表）,account_history(账户记录表)
account表
id（账号）  name（姓名）  amount(余额)  dt(最后修改时间)
001            张三          20000           2019-01-22
002            李四          4000            2019-03-12
... ... ... ...
account_history表
id(账号)  name(姓名)  amount(余额)  start_dt(开始时间)  end_dt(结束时间)
001       张三          20000           2019-01-22        2019-04-01
001       张三          15000           2019-04-01        2999-12-31
002       李四          4000            2019-03-12        2999-12-31
... ... ... ... ...
--------------------------------------------------
----------------建表代码↓--------------------
--------------------------------------------------
drop table t_account;
drop table t_account_history;
create table t_account(
aid varchar2(3),
aname varchar2(10),
amount number,
dt date);

create table t_account_history(
aid varchar2(3),
aname varchar2(10),
amount number,
start_dt date,
end_dt date);

insert into t_account
select '001', '张三', '20000', to_date('2019-01-22', 'yyyy-mm-dd') from dual
union
select '002', '李四', '4000', to_date('2019-03-12', 'yyyy-mm-dd') from dual;

insert into t_account_history
select '001', '张三', '20000', to_date('2019-01-22', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual
union
/*select '001', '张三', '15000', to_date('2019-04-01', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual
union*/
select '002', '李四', '4000', to_date('2019-03-12', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual;
commit;
select * from t_account;
select * from t_account_history;
--------------------------------------------------
----------------建表代码↑--------------------
--------------------------------------------------
要求实现:当在account表新增用户时，在account_history表中增加一条记录，
开始时间为当前时间，结束时间为2999-12-31.
当account表的记录被修改时，例如张三的账号，
假设在2019-04-01这天取了5000元，在修改account表数据时，
将account_history表中张三的上一条记录的结束时间改为2019-04-01，
再在account_history表中添加一条记录
（如上图第2条记录，开始时间为当前时间2019-04-01，结束时间为2999-12-31）
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------
create or replace procedure pae99_06(a_id varchar2, a_name varchar2, v_amount number, v_dt date)
is
flag number := 0;
balance number; 
v_sql1 varchar2(300) := 'insert into t_account values (:1, :2, :3, :4) returning amount into :5';
v_sql2 varchar2(300) := 'update t_account set amount = amount + :1, dt = :2 where aid = :3 returning amount into :4';
v_sql3 varchar2(300) := 'update t_account_history set end_dt = :1 where aid = :2 and end_dt = to_date(''2999-12-31'', ''yyyy-mm-dd'')';
v_sql4 varchar2(300) := 'insert into t_account_history select :1, :2, :3, :4, to_date(''2999-12-31'', ''yyyy-mm-dd'') from dual';

begin
  for v in (select * from t_account) loop
    if v.aid = a_id then
      flag := 1;
      exit;
    else
      null;
    end if;
  end loop;
  
  case flag
    when 0 then
      execute immediate v_sql1 using a_id, a_name, v_amount, v_dt returning into balance;
      when 1 then
        execute immediate v_sql2 using v_amount, v_dt, a_id returning into balance;
        execute immediate v_sql3 using v_dt, a_id;
  end case;
  execute immediate v_sql4 using a_id, a_name, balance, v_dt;
end;
--------------------------------------------------
----------------测试代码↓--------------------
--------------------------------------------------
begin
  for v in (select * from t_account) loop
    dbms_output.put_line(v.aid|| ', ' || v.aname|| ', ' || v.amount|| ', ' || v.dt);
  end loop;
  dbms_output.put_line(rpad('-', 50, '-'));
  for i in (select * from t_account_history) loop
    dbms_output.put_line(i.aid|| ', ' || i.aname|| ', ' || i.amount|| ', ' || i.start_dt || ', ' || i.end_dt);
  end loop;
  pae99_06('001', '张三', -5000, to_date('20190401', 'yyyymmdd'));
  pae99_06('004', 'takami', 11000, trunc(sysdate));
  dbms_output.put_line(rpad('-', 50, '-'));
  dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from t_account order by aid) loop
    dbms_output.put_line(v.aid|| ', ' || v.aname|| ', ' || v.amount|| ', ' || v.dt);
  end loop;
  dbms_output.put_line(rpad('-', 50, '-'));
  for i in (select * from t_account_history order by aid) loop
    dbms_output.put_line(i.aid|| ', ' || i.aname|| ', ' || i.amount|| ', ' || i.start_dt || ', ' || i.end_dt);
  end loop;
  rollback;
end;
--------------------------------------------------
7.写一个存储过程，用于恢复数据库中dept表的数据（10分）
1.	若dept表存在，则将该表删除，重新创建该表，否则创建直接建表
2.	插入如下数据：
     Deptno      dname             loc
      10       ACCOUNTING        NEW YORK
      20       RESEARCH              DALLAS
      30        SALES                   CHICAGO
      40      OPERATIONS          BOSTON
3.在dept表的deptno 字段上创建主键约束，并且要求部门名称列非空
--------------------------------------------------
----------------代码预备↓--------------------
--------------------------------------------------
alter table emp drop constraint FK_DEPTNO;
-- sys dba
grant create any table to scott;
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------
create or replace procedure pae99_07
is
v_sql1 varchar2(300) := 'drop table dept';
v_sql2 varchar2(300) := 'create table dept (deptno number(2), dname varchar2(14), loc varchar2(13))';
v_sql3 varchar2(300) := 'insert into dept select 10, ''ACCOUNTING'', ''NEW YORK'' from dual union select 20, ''RESEARCH'', ''DALLAS'' from dual union select 30, ''SALES'', ''CHICAGO'' from dual union select 40, ''OPERATIONS'', ''BOSTON'' from dual';
v_sql4 varchar2(300) := 'alter table dept add constraint pk_dept_deptno primary key (deptno)';
v_sql5 varchar2(300) := 'alter table dept modify dname not null';
begin
  execute immediate v_sql1;
  execute immediate v_sql2;
  execute immediate v_sql3;
  execute immediate v_sql4;
  execute immediate v_sql5;
  commit;
end;  
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
call pae99_07();
select * from dept;
insert into dept(deptno, dname) values(40, 'aa');
insert into dept(dname) values('aa');
insert into dept(deptno) values(50);
--------------------------------------------------
8.写一个包，封装对雇员信息的操作，包含如下功能（10分）
   1.输出所有雇员信息
   2.查询公司所有领导及其下属员工人数，没有下属，结果为0
   3.返回每个部门的部门编号，部门名称，
   员工人数以及薪资大于5000的高薪员工人数
   4.接受一个部门编号和薪资，返回该部门高于输入的薪资的员工人数
   
--------------------------------------------------
create or replace package pkas99_08
is     
       e emp%rowtype;
       
       procedure p_output_einfo
         is
         begin
           for v in emp loop
             dbms_output.put_line()
           end loop;
         end;

end pkas99_08;

create or replace package body pkas99_08
is

end pkas99_08;

 
    
