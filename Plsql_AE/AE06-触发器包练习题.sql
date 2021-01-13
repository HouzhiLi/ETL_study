stu表（学生表）
create table stu(
   sno number(11) primary key, --学号
   sname varchar2(30), --姓名
   sage number(3), --年龄
   ssex varchar2(3) --性别
);
insert into stu 
select 1,'张三',18,'男' from dual
union all
select 2,'李四',28,'男' from dual
union all
select 3,'王五',19,'男' from dual
union all
select 4,'赵六',18,'女' from dual;
teacher表(老师表)
create table teacher(
   tno number(11) primary key, --老师编号
   tname varchar2(30) --老师名称
);
insert into teacher
select 1,'张小平' from dual
union all
select 2,'李明' from dual
union all
select 3,'smith' from dual
union all
select 4,'王小乐' from dual
union all
select 5,'孙小东' from dual
union all
select 6,'张豪' from dual;
corse表（课程表）
create table course(
   cno number(11) primary key, --课程号
   cname varchar2(40),   --课程名称
   tno number(11) --老师编号
);
insert into course
select 1,'语文',1 from dual
union all
select 2,'英语',3 from dual
union all
select 3,'oracle',2 from dual
union all
select 4,'python',5 from dual
union all
select 5,'etl',6 from dual
union all
select 6,'数学',4 from dual;

sc表(选课表)
create table sc(
   sno number(11), --学号
   cno number(11), --课程号
   score number(3)  --成绩
);
insert into sc 
select 1,2,70 from dual
union all 
select 1,3,80 from dual
union all
select 1,5,90 from dual
union all
select 2,1,76 from dual
union all
select 2,2,88 from dual
union all
select 2,6,30 from dual
union all
select 3,1,70 from dual
union all
select 3,2,65 from dual
union all
select 3,6,75 from dual
union all
select 3,4,79 from dual
union all
select 4,2,77 from dual;

sc_number表（选课统计表）
create table sc_number(
   sno number(10),  --学号
   nu number(3),   --选课数
   score number(4,1)  --平均成绩
);
select * from stu;
select * from sc;
select * from course;
select * from teacher;
select * from sc_number;
1.向sc表添加数据时，修改sc_number表中的选课数，如果sc_number中没有则新添加一条
/*
 目录触发器中不支持事务的处理
 使用after触发器时，如果执行的是insert,update或才delete语句，
   那么不允许在触发器代码中对原表进行任何操作

*/
/*游标*/
create or replace trigger tr1
before insert on sc for each row
declare
   --声名一个变量保存sc_number表中的数据条数
   n number(3);
begin
   --pragma autonomous_transaction;
   --行级触发器，可以通过：new获取到新添加的数据
   --判断sc_number中有没有该学生的选课数记录
   select count(*) into n from sc_number where sno=:new.sno;
  -- n:=0;
   if n=0 then
     --insert into sc_number select :new.sno,count(*) from sc where sno=:new.sno;
     --根据学号查询学生的选课数
     --insert into sc_number(sno,nu) values(:new.sno,1); --如果在sc表中没有数据的情况下这样写没有问题
     --如果sc表中有数据，需要统计一个学生的选课数
     dbms_output.put_line('向sc_number表中添加一条新的记录:'||:new.sno);
     select count(1) into n from sc where sno=:new.sno;--只能放在sc表的before触发器中
     insert into sc_number(sno,nu) values(:new.sno,n);
   end if;
   --说明sc_number表中已经有该学生的选课数，将其选课数加1
   update sc_number set nu=nu+1 where sno=:new.sno;
end;
select * from sc where sno=1;


select sc.*,1 from sc where sno=1;

select count('a') from sc where sno=1;
select count(1) from sc where sno=1;

count(1):count(常量)它执行效率比count(*)高

create or replace 
insert into sc_number(sno,nu) values(1,4);
declare
   n number(3);
begin
       select count(1) into n from sc where sno=1;
       dbms_output.put_line(n);
end;
select * from sc where sno=1;
select * from sc_number;
delete from sc_number;
insert into sc values(1,4,88);
--本来sc表中，有一个联合主键  alter sc add constraint pk_sc primary key(sno,cno);
select 1,count(*) from sc where sno=1;
/*
   向表中插入数据
   第一种
   insert into 表名(列名,列名,...) values(值,值,...);
   第二种
   insert into 表名(列名,...) select 语句; --可以插入多条数据，也可以插入一条数据
      select语句的查询结果要和表名后列名一致
*/
/*
要使用before触发器，可以在触发器代码中对sc表的数据进行操作（crud）

使用after触发器时，不能对sc表数据进行操作

1.因为考虑到触发器是创建在sc表已有数据的情况下，所以需要从sc表中查询数据，所有before触发器

2.当删除sc表时，修改sc_number表中的选课数
3.当修改sc表数据时，如果修改了学号sno，修改sc_number中相应的选课数，否则打印'学生的选课信息已更改'


4.不能删除成绩是90分以上的学生的选课信息


5.向stu表中添加数据时，年龄不能超过30岁

6.删除学生信息时，同时删除sc表和sc_number表中的数据

7.修改emp表中的工资时，只能增加不能减少

8.当前删除emp表中的数据时，将数据备份到emp_log表中
emp_log建表语句：


9.在每天的早上9点之前和6点之后，不允许对emp表中的数据进行添加,修改,删除

10.当emp表中的数据变更时，统计各部门的人数，和员工的平均工资，总工资，
并将统计结果保存到统计表emp_cal表中


 11.创建一个包，包中包含以下功能
 1.函数，传入一个员工编号，返回员工的信息
 2.过程，根据员工编号，修改员工的工资 （两个参数，一个员工编号，一个员工工资）
 3.函数，根据部门编号，返回该部门的人数 
 4.过程，根据部门编号，输出该部门下所有员工的详细信息 (一个部门编号是传入参数，输出参数，集合类型，需要在包声名一个类型)
 