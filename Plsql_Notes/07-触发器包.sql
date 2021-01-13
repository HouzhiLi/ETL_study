触发器
触发器是oracle在执行dml或ddl语句时触发执行的一段代码，它可以在语句执行之前运行，
  也可以在语句运行之后运行，还可以替换语句只执行触发器代码
  触发器的分类：表级触发器(语句级触发器)和行级触发器
  
（1）表级触发器
表级触发器：一条sql语句只触发执行一次触发器代码
语法：
create [or replace] trigger 触发器名
before|after insert[ or update or delete] on 对象名
declare
   声名部分;
begin
   代码块;
   异常处理;
end;

trigger:触发器的关键字
before|after:分别表示触发器代码在sql语句前|后执行
insert|update|delete:分别表示insert语|update语句|delete语句
on 对象名：对象名一般批表名

表示在表上执行insert或update或者delete语句前或者后，执行下面的代码中的代码
注意：触发器代码块中一般不允许执行ddl语句，也不允许对表进行dml操作和dql操作


--写一个触发器，当dept表中数据添加新数据时，打印“添加数据”
create or replace trigger t1
before insert on dept
begin
  dbms_output.put_line('添加数据');
end;

insert into dept values(50,'aa','bb');

insert into dept 
select 60,'cc','dd' from dual
union all
select 70,'ee','ff' from dual
union all
select 80,'gg','hh' from dual;

update dept set dname='ss' where deptno=50;

delete from dept where deptno >40;

alter trigger 触发器名 disable; --让触发器失效
alter trigger t1 disable;
alter trigger 触发器名 enable; --让触发器生效
alter trigger t1 enable;
drop trigger 触发器名; --删除触发器
drop trigger t1;

inserting:布尔类型，当insert语句触发触发器代码时，该变量为true,否则为false
updating:布尔类型，当update语句触发触发器代码时，变量为true,否则为false
deleting:布尔类型，当delete语句触发触发器代码时，变量为True,否则为false

--记录表的操作日志
create table log1(
  op varchar2(30),  ---执行了什么操作  insert update delete
  dt date    --记录操作时间
);
当dept表中数据发生改变时，记录sql语句到log1表中
create or replace trigger t1 
after insert or delete or update on dept
declare
   --声名一个变量保存操作类型
   s varchar2(30);
begin
   if inserting then
     s:='insert';
   end if;
   if updating then
     s:='update';
   end if;
   if deleting then
     s:='delete';
   end if;
   --将操作记录插入到log1表中
   insert into log1 values(s,sysdate);
end;

select * from log1;

--写一个触发器，实现当前早上10点之前，和下午6点以后不允许对表dept进行增删改操作
create or replace trigger t2
before insert or update or delete on dept
begin
  if to_char(sysdate,'hh24')<'10' or to_char(sysdate,'hh24')>=18 then
     dbms_standard.raise_application_error(-20222,'非工作时间不允许修改表数据');
  end if;
end;

一个表上可以有多个触发器(7个)：触发器触发执行的顺序
before 语句级触发器
before 行级触发器
sql语句
after 行级触发器
after 语句级触发器 

（2）行级触发器
行级触发器：一个sql语句触发执行1次或多次（sql语句影响的数据库数据条数来决定）

drop trigger t1;
drop trigger t2;
行级触发器语法：
create or replace trigger 触发器名
before|after  insert or update or delete on 表名 for each row
declare

begin
  
end;

create or replace trigger t3
before insert on dept for each row
begin
  dbms_output.put_line('行级触发器');
end;

:old 记录类型对象(表名%rowtype),获取到修改前的数据
      
:new 记录类型对象(表名%rowtype),获取到修改后的对象

   insert: :old对象为空 ，:new对象有值
   update: :old对象和：new都有值
   delete: :old对象有值， :new对象为空
注意：before触发器可以使用:new对象，但after触发器中不能使用:new对象

drop trigger t3;

create or replace trigger t4
before insert or update or delete on dept for each row
begin
   if inserting then
      dbms_output.put_line('insert');
      dbms_output.put_line(':old对象：'||:old.deptno||','||:old.dname||','||:old.loc);
      dbms_output.put_line(':new对象：'||:new.deptno||','||:new.dname||','||:new.loc);
   end if;
   if updating then
      dbms_output.put_line('update');
      dbms_output.put_line(':old对象：'||:old.deptno||','||:old.dname||','||:old.loc);
      dbms_output.put_line(':new对象：'||:new.deptno||','||:new.dname||','||:new.loc);
   end if;
   
   if deleting then
      dbms_output.put_line('delete');
      dbms_output.put_line(':old对象：'||:old.deptno||','||:old.dname||','||:old.loc);
      dbms_output.put_line(':new对象：'||:new.deptno||','||:new.dname||','||:new.loc);
   end if;
end;

drop trigger t4;

--使用触发器生成主键
create table tt(
   dno number(11) primary key,
   name varchar2(30)
);
insert into tt values(1,'aa');


create sequence tt_seq start with 1 increment by 1;

select tt_seq.nextval from dual;
insert into tt values(tt_seq.nextval,'bb');


insert into tt(name) values('bb');

create or replace trigger t5 
before insert on tt for each row
begin
  --触发器中修改主键列的值
  :new.dno:=tt_seq.nextval;
end;
insert into tt values(1,'aa');
insert into tt(name) values('cc');
select * from tt;

--记录表中的详细日志
--dept_log表表结构如下 
create table dept_log as select dept.*,'aaaaaaaaaaaa' op,sysdate opt_time from dept where 1=0;

select * from dept_log;
--当执行insert语句时，将插入的数据保存到dept_log表中，op字段的值为insert opt_time为当前时间
--当前执行update语句时，将更新的数据保存到dept_log表中，。。。。。update 。。。。。。。。。。。
--当执行delete语句时，将删除的数据保存到dept_log表中，。。。。。。delete ................
create or replace trigger t6
before insert or update or delete on dept for each row
begin
  if inserting then
    insert into dept_log values(:new.deptno,:new.dname,:new.loc,'insert',sysdate);
  end if;
  if updating then
    insert into dept_log values(:new.deptno,:new.dname,:new.loc,'update',sysdate);
  end if;
  if deleting then
    insert into dept_log values(:old.deptno,:old.dname,:old.loc,'delete',sysdate);
  end if;
end;

select * from dept_log;


--当前emp表中数据修改时，如果工资小于2000,那么提示工资不能低于2000
create or replace trigger t7
before insert or update on emp for each row
begin
  if :new.sal<2000 then
     dbms_standard.raise_application_error(-20001,'工资不能低于2000');
  end if;
end;

update emp set sal=sal+2000 where empno=7369;

(3)替换触发器
替换触发器：替换原有sql语句，只执行触发器代码，只能针对视图
语法：
create or replace trigger 触发器名
instead of insert or update or delete on 视图名 for each row
declare

begin
  
end;
drop view d_e;
create view d_e as select emp.*,dname,loc from emp join dept on emp.deptno=dept.deptno;

select * from d_e;

--当向视图中插入数据时，
     如果部门不存在，添加一个新的部门，
     如果员工不存在，添加一个新的员工
     如果部门存在，修改部门的信息
     如果员工存在，修改员工信息
create or replace trigger t8 
instead of insert on d_e for each row
declare
   --声名一个变量n
   n number:=0;
begin
   select count(1) into n from dept where deptno=:new.deptno;
   --判断部门是否存在
   if n=0 then
      --如果部门不存在，执行insert插入一条部门信息
      insert into dept values(:new.deptno,:new.dname,:new.loc);
   else
      --如果部门存在，执行update修改部门信息
      update dept set dname=:new.dname,loc=:new.loc where deptno=:new.deptno;
   end if;
   select count(1) into n from emp where empno=:new.empno;   
   --判断员工是否存在
   if n=0 then
      --如果员工不存在，执行insert插入一条员工信息
      insert into emp values(:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
   else
      --如果员工存在，执行update修改员工信息
      update emp set ename=:new.ename,
                     job=:new.job,
                     mgr=:new.mgr,
                     hiredate=:new.hiredate,
                     sal=:new.sal,
                     comm=:new.comm,
                     deptno=:new.deptno
                     where empno=:new.empno;
   end if;
end;     


insert into d_e values(8000,'ss','clerk',7369,sysdate,2000,100,10,'xx','yy');

select * from d_e;

select * from dept;
select * from emp;

drop trigger t8;

create view e as select * from emp; 

create or replace trigger t9 
before insert on e for each row
declare
   n number;
begin
   select count(1) into n from emp where empno=:new.empno;
   --判断员工是否存在，
   if n=1 then
     --如果存在，修改
     update emp set ename=:new.ename,
                     job=:new.job,
                     mgr=:new.mgr,
                     hiredate=:new.hiredate,
                     sal=:new.sal,
                     comm=:new.comm,
                     deptno=:new.deptno
                     where empno=:new.empno;
   else
     --如果不存在，添加
     insert into emp values(:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
   end if;
end;


create or replace trigger t9 
before insert on e for each row
declare
   n number;
begin  
     update emp set ename=:new.ename,
                     job=:new.job,
                     mgr=:new.mgr,
                     hiredate=:new.hiredate,
                     sal=:new.sal,
                     comm=:new.comm,
                     deptno=:new.deptno
                     where empno=:new.empno returning empno into n;
     if n is null then
        --员工不存在
        insert into emp values(:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
     
     end if;

end;

包
包：是对之前学的存储过程，函数，类型，变量等的一个封装
   分为包的声名（包头）和包的实现（包体）
   
包的声名语法：
create or replace package 包名
is
    --公有变量常量的声名
    --公有类型的定义

    --公有存储过程的声名
    procedure 存储过程名(参数 类型,....);
    --公有函数的声名
    function 函数名(参数 类型,....) return 返回值类型;
end [包名];   

create or replace package pk1
is
   --声名一个常量
   pi constant number(6,5):=3.14159;
   --声名一个变量
   s varchar2(30);
   --定义一个索引表类型
   type atype is table of varchar2(30) index by pls_integer;
   --声名一个函数计算圆的面积
   function fn(r number) return number;
   --声名一个存储过程打印99乘法表
   procedure p1;
end pk1; 

begin
  dbms_output.put_line(pk1.pi);
end;

包体的语句
create or replace package body 包名
is
   --私有变量的声名
   --私有类型的定义
   --私有存储过程和函数
   --公有存储过程的实现
   procedure 过程名(参数 类型,..)
     is
     
     begin
       
     end;
   --公有函数的实现
   function 函数名(参数,类型)
     return number
     is
     
     begin
       
     end;




end 包名;

create or replace package body pk1
is
   --声名一个变量
   str varchar2(30):='Hello 祝英台';
   --声名一个私有的存储过程
   procedure pn
     is
     begin
       dbms_output.put_line(str);
     end;
   --声名一个私有的函数
   function fnn(n number)
     return number
     is
     begin
       if n<2 then
         return n;
       else
         return n*fnn(n-1);
       end if;
     end;  
   --公有存储过程的实现
   procedure p1 
     is
     begin
       pn;
       for i in 1..9 loop
         for j in 1..i loop
           dbms_output.put(j||'*'||i||'='||(j*i)||' ');
           if i*j<10 then
             dbms_output.put(' ');
           end if;
         end loop;
         dbms_output.put_line('');
       end loop;
     end;
     
   --公有函数的实现
   function fn(r number)
     return number
     is
     begin
       dbms_output.put_line(fnn(r));
       return pi*power(r,2);
     end;
end pk1;
包名.对象名（变量，类型，函数，存储过程等）
begin
  dbms_output.put_line(pk1.fn(3));
  pk1.p1;
end;
注意：包声名部分的内容都属于公有对象 ，可以通过包名.对象名直接该
      包体中，未在声名部分声名的对象是私有对象，私有对象只只可以在包内被调用
         而且私有对象必须在调用对象的前面声名
