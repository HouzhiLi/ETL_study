-------------------------------------------------- 
2.	写一个PLSQL代码块打印99乘法表格式（5分）
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
declare

        end;
    

--------------------------------------------------
5.	有如下用户表
create table user(
		id number(11) primary key,
     username varchar2(30),
     password varchar2(32)
);
写一个函数，实现用户的登陆功能，传入用户名和密码，
当前用户名和密码都正确时，返回“登陆成功”，
如果用户名不存在，返回“该用户不存在，请先注册”，
如果密码不正确，则返回“用户名或密码不正确”(10分)

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
要求实现:当在account表新增用户时，在account_history表中增加一条记录，
开始时间为当前时间，结束时间为2999-12-31.
当account表的记录被修改时，例如张三的账号，
假设在2019-04-01这天取了5000元，在修改account表数据时，
将account_history表中张三的上一条记录的结束时间改为2019-04-01，
再在account_history表中添加一条记录
（如上图第2条记录，开始时间为当前时间2019-04-01，结束时间为2999-12-31）

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
8.写一个包，封装对雇员信息的操作，包含如下功能（10分）
   1.输出所有雇员信息
   2.查询公司所有领导及其下属员工人数，没有下属，结果为0
   3.返回每个部门的部门编号，部门名称，
   员工人数以及薪资大于5000的高薪员工人数
   4.接受一个部门编号和薪资，返回该部门高于输入的薪资的员工人数
   
--------------------------------------------------



 
    
