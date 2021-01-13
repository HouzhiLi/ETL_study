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

