1.写出loop循环，while循环和for循环的区别

--------------------------------------------------   
--------------------------------------------------
2.  写一个PLSQL代码块打印99乘法表格式（5分）
declare
m number;
n number;
begin
  for m in 1..9 loop
    for n in 1..m loop
      dbms_output.put(rpad(n || '*' || m|| '=' || m*n, 10, ' '));
    end loop;
    dbms_output.new_line();
  end loop;
end;
--------------------------------------------------   
--------------------------------------------------
3.	分别利用游标、集合遍历dept表中的数据（10分） 
--游标
declare
cursor cur is select * from dept;
begin
  for v in cur loop
    dbms_output.put_line(v.deptno || ', ' || v.dname || ', ' || v.loc);
  end loop;
end;    
--集合
declare
type ctype is table of dept%rowtype;
c ctype;
begin
  select * bulk collect into c from dept;
  for i in c.first..c.last loop
    dbms_output.put_line(c(i).deptno || ', ' || c(i).dname || ', ' || c(i).loc);
  end loop;
end;
--------------------------------------------------   
--------------------------------------------------
4.  写一个匿名块，接受一个部门号和员工编号，输出对应的员工信息，
若部门不存在，则返回‘输入的部门不正确，请重新输入’，
若部门存在，员工不存在，则返回‘部门内不存在该员工’（10分）
declare
dno number := &dno;
eno number := &eno;
n number;
v emp%rowtype;
begin
  select count(1) into n from emp where deptno = dno;
  case n
    when 0 then 
      dbms_output.put_line('输入的部门不正确，请重新输入');
    else
      select count(1) into n from emp where deptno = dno and empno = eno;
      case n 
        when 0 then
          dbms_output.put_line('部门内不存在该员工');
        else
          select * into v from emp where deptno = dno and empno  = eno;
          dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
        end case;
    end case;
end;
--------------------------------------------------   
--------------------------------------------------
5.  有如下用户表
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
create or replace function fun05(uname varchar2, pwd varchar2)
return varchar2
is
n number;
s varchar2(200);
begin
  select count(1) into n from user_login where username = uname;
  case n
    when 0 then
      s := '该用户不存在，请先注册';
    else
      select count(1) into n from user_login ul where ul.username = uname and ul.password = pwd;
      case n
        when 0 then
          s := '用户名或密码不正确';
        else
          s := '登陆成功';
        end case;
    end case;
    return s;
end;
begin
dbms_output.put_line(fun05('takami', 'Fils1109'));
dbms_output.put_line(fun05('takami', 'wer665'));
dbms_output.put_line(fun05('ta', 'Fils1109'));
dbms_output.put_line(fun05('takami', '11'));
end;
--------------------------------------------------   
--------------------------------------------------
6.  有如下表account（账户表）,account_history(账户记录表)
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
drop table account;
drop table account_history;
create table account(
id varchar2(3),
name varchar2(10),
amount number,
dt varchar2(10));

create table account_history(
id varchar2(3),
name varchar2(10),
amount number,
start_dt varchar2(10),
end_dt varchar2(10));

insert into account
select '001', '张三', '20000', '2019-01-22' from dual
union
select '002', '李四', '4000', '2019-03-12' from dual;

insert into account_history
select '001', '张三', '20000', '2019-01-22', '2999-12-31'from dual
union
/*select '001', '张三', '15000', to_date('2019-04-01', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual
union*/
select '002', '李四', '4000', '2019-03-12', '2999-12-31' from dual;
commit;
select * from account;
select * from account_history;
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
create or replace trigger tri06
before insert or update on account for each row
begin
  if inserting then
    insert into account_history values (:new.id, :new.name, :new.amount, :new.dt, '2999-12-31');
    end if;
  if updating then
    dbms_output.put_line(:new.dt||', '||:old.dt);
    update account_history set end_dt = :new.dt where id = :old.id and end_dt = '2999-12-31';
    insert into account_history values (:old.id, :new.name, :new.amount, :new.dt, '2999-12-31');
    end if;
end;

update account set name = 'takami', amount = 15000, dt = '2019-04-01' where name = '张三';
--------------------------------------------------   
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
create or replace procedure pro07
is
v_sql1 varchar2(300) := 'drop table dept';
v_sql2 varchar2(300) := 'create table dept(deptno number(2), dname varchar2(30), loc varchar2(30))';
v_sql3 varchar2(300) := 'insert into dept select 10, ''ACCOUNTING'', ''NEW YORK'' from dual union select 20, ''RESEARCH'', ''DALLAS'' from dual union select 30, ''SALES'', ''CHICAGO'' from dual union select 40, ''OPERATIONs'', ''BOSTON'' from dual';
v_sql4 varchar2(300) := 'alter table dept add constraint pk_dept_dno primary key (deptno)';
v_sql5 varchar2(300) := 'alter table dept modify dname not null';
begin
  execute immediate v_sql1;
  execute immediate v_sql2;
  execute immediate v_sql3;
  execute immediate v_sql4;
  execute immediate v_sql5;
  end;
  
select * from dept; 
  call pro07();
--------------------------------------------------   
--------------------------------------------------
8.写一个包，封装对雇员信息的操作，包含如下功能（10分）
   1.输出所有雇员信息
   2.查询公司所有领导及其下属员工人数，没有下属，结果为0
   3.返回每个部门的部门编号，部门名称，
   员工人数以及薪资大于5000的高薪员工人数
   4.接受一个部门编号和薪资，返回该部门高于输入的薪资的员工人数
create or replace package pk08
is
       type rtype is record (dno number(2), dname varchar2(30), d_num number, hs_num number);
       procedure p_output_einfo;
       procedure p_m_e_relation;
       function f_d_c return sys_refcursor;
       function f_d_s(dno number, vsal number) return number;
end pk08;

create or replace package body pk08
is
       procedure p_output_einfo
         begin
           for v in (select * from emp) loop
             dbms_output.put_line(v.empno || ', ' || v.ename || ', ' || v.job || ', ' || v.mgr || ', ' || v.hiredate || ', ' || v.sal || ', ' || v.comm || ', ' || v.deptno);             
           end loop;
         end;
         
         procedure p_m_e_relation
           is
           begin
             for v in (select e1.empno, e1.ename, count(e2.empno) c from emp e1 left join emp e2 on e1.empno = e2.mgr group by e1.empno , e1.ename)
           end;
       
end pk08;
--------------------------------------------------   
--------------------------------------------------
