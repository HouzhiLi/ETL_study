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
--------------------------------------------------
-----------------博哥tips↓--------------------
--------------------------------------------------
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


1.因为考虑到触发器是创建在sc表已有数据的情况下，所以需要从sc表中查询数据，所有before触发器*/
1.向sc表添加数据时，修改sc_number表中的选课数，如果sc_number中没有则新添加一条
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------   
/*create or replace trigger t01
before insert on sc for each row
declare
n number;
begin
  select count(1) into n from sc_number where sno = :new.sno;
  case n
    when 0 then
      dbms_output.put_line('新增学生学号：' || :new.sno);
      insert into sc_number values (:new.sno, 1, :new.score);
      else
        update sc_number set nu = nu+1, score = (score*nu + :new.score)/(nu+1) where sno = :new.sno;
      end case;
end;*/
--------------------------------------------------
----------------代码实现↓--------------------
-------------------------------------------------- 
create or replace trigger tae06_01_01
before insert on stu for each row
begin
  insert into sc_number values (:new.sno, 0, 0);
end;

create or replace trigger tae06_01_02
before insert on sc for each row
begin
  update sc_number set nu = nu+1, score = (score * nu + :new.score)/(nu+1) where sno = :new.sno;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
delete from sc;
--------------------------------------------------
delete from sc_number;
--------------------------------------------------
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
--------------------------------------------------
begin
for v in (select * from stu) loop
  dbms_output.put_line(v.sno|| ', ' || v.sname|| ', ' || v.sage|| ', ' || v.ssex);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for i in (select * from sc) loop
  dbms_output.put_line(i.sno|| ', ' || i.cno|| ', ' || i.score);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for n in (select * from sc_number) loop
  dbms_output.put_line(n.sno|| ', ' || n.nu|| ', ' || n.score);
end loop;
--------------------------------------------------
rollback;
end;
--------------------------------------------------
2.当删除sc表时，修改sc_number表中的选课数
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------  
create or replace trigger tae06_02
before delete on sc for each row
declare
n number;
begin
  select nu into n from sc_number where sno = :old.sno;
  case n
    when 1 then
      update sc_number set nu = 0 , score = 0 where sno = :old.sno;
    else  
      update sc_number set nu = nu-1, score = (score*nu - :old.score)/(nu-1) where sno = :old.sno;
    end case;   
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
delete from sc where score = 70;
delete from sc;
--------------------------------------------------
begin
for v in (select * from stu) loop
  dbms_output.put_line(v.sno|| ', ' || v.sname|| ', ' || v.sage|| ', ' || v.ssex);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for i in (select * from sc) loop
  dbms_output.put_line(i.sno|| ', ' || i.cno|| ', ' || i.score);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for n in (select * from sc_number) loop
  dbms_output.put_line(n.sno|| ', ' || n.nu|| ', ' || n.score);
end loop;
--------------------------------------------------
rollback;
end;
--------------------------------------------------
3.当修改sc表数据时，如果修改了学号sno，修改sc_number中相应的选课数，否则打印'学生的选课信息已更改'
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------  
create or replace trigger t03
before update on sc for each row
declare
n number;
m number;
begin
  --1.若未修改sno，则只修改sc_number表中的平均分，并打印‘学生的选课信息已更改‘
  if :old.sno = :new.sno then
    update sc_number set score = (score*nu - :old.score + :new.score)/nu where sno = :old.sno;
    dbms_output.put_line('学生的选课信息已更改');
  --1.若修改sno，则判断新sno是否为sc表中已有sno，若已有则直接更新sc_number表中的该数据
    else
      update sc_number set nu = nu + 1, score = (score*nu + :new.score)/(nu+1) where sno = :new.sno returning  sno into n;
    --2.若新sno在sc表中不存在，则需向sc_number表中新增一条对应数据
       if n is null then
      --3.同步更新sc_number表中旧sno对应的数据的nu
      update sc_number set nu = nu - 1 where sno = :old.sno returning nu into m;
      insert into sc_number values (:new.sno, 1, :new.score);
        --4.若nu为0，则从c_number表中移除该数据
      if m = 0 then
        delete from sc_number where sno = :old.sno;
          --5.若nu不为0，则从c_number表中更新该数据的score
        else
          update sc_number set score = (score*(nu+1) - :old.score)/nu where sno = :old.sno;
      end if;
    --2
      else
      --3.同步更新sc_number表中旧sno对应的数据的nu
        update sc_number set nu = nu - 1 where sno = :old.sno returning nu into m;
        --4.若nu为0，则从c_number表中移除该数据
        if m = 0 then
        delete from sc_number where sno = :old.sno;
          --5.若nu不为0，则从c_number表中更新该数据的score
        else
          update sc_number set score = (score*(nu+1) - :old.score)/nu where sno = :old.sno;
      end if;
      end if;
    end if;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
update sc set sno = 5 where sno = 4 and cno = 2;
update sc set sno = 4 where sno = 1;
--------------------------------------------------
begin
for v in (select * from stu) loop
  dbms_output.put_line(v.sno|| ', ' || v.sname|| ', ' || v.sage|| ', ' || v.ssex);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for i in (select * from sc) loop
  dbms_output.put_line(i.sno|| ', ' || i.cno|| ', ' || i.score);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for n in (select * from sc_number) loop
  dbms_output.put_line(n.sno|| ', ' || n.nu|| ', ' || n.score);
end loop;
--------------------------------------------------
rollback;
end;
--------------------------------------------------
4.不能删除成绩是90分以上的学生的选课信息
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------  
create or replace trigger t04
before delete on sc for each row
begin
  if :old.score >= 90 then
    dbms_standard.raise_application_error(-20001, '不能删除成绩是90分以上的学生的选课信息');
  end if;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
alter trigger t04 enable;
delete from sc where sno = 1 and cno =5;
alter trigger t04 disable;
--------------------------------------------------
5.向stu表中添加数据时，年龄不能超过30岁
--------------------------------------------------
----------------代码实现↓--------------------
-------------------------------------------------- 
create or replace trigger t05
before insert on stu for each row
begin
  if :new.sage > 30 then
    dbms_standard.raise_application_error(-20002, '年龄不能超过30岁');
  end if;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
alter trigger t05 enable;
insert into stu select 6,'张aa',31,'男' from dual;
alter trigger t05 disable;
--------------------------------------------------
6.删除学生信息时，同时删除sc表和sc_number表中的数据
--------------------------------------------------
----------------代码实现↓--------------------
-------------------------------------------------- 
create or replace trigger t06
before delete on stu for each row
begin
  delete from sc where sno = :old.sno;
  end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
alter table stu disable primary key; --constraint SYS_C0010883 ;
delete from stu where sno = 1;
--------------------------------------------------
begin
for v in (select * from stu) loop
  dbms_output.put_line(v.sno|| ', ' || v.sname|| ', ' || v.sage|| ', ' || v.ssex);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for i in (select * from sc) loop
  dbms_output.put_line(i.sno|| ', ' || i.cno|| ', ' || i.score);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for n in (select * from sc_number) loop
  dbms_output.put_line(n.sno|| ', ' || n.nu|| ', ' || n.score);
end loop;
--------------------------------------------------
rollback;
end;
--------------------------------------------------
7.修改emp表中的工资时，只能增加不能减少
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------  
create or replace trigger t07 
before update on emp for each row
begin
  if :old.sal > :new.sal then
    dbms_standard.raise_application_error(-20022, '不能减少工资');
  end if;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
alter trigger t07 enable;
update emp set sal = 700 where empno = 7369;
alter trigger t07 disable;
--------------------------------------------------
8.当前删除emp表中的数据时，将数据备份到emp_log表中
emp_log建表语句：
drop table emp_log;
create table emp_log as select emp.*, sysdate as del_dt from emp where 1 = 0;
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------  
create or replace trigger t08
before delete on emp for each row
begin
  insert into emp_log select :old.empno, :old.ename, :old.job, :old.mgr, :old.hiredate, :old.sal, :old.comm, :old.deptno, sysdate from dual;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
delete from emp;
--------------------------------------------------
begin
for v in (select * from emp) loop
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for i in (select * from emp_log) loop
  dbms_output.put_line(i.empno|| ', ' || i.ename|| ', ' || i.job|| ', ' || i.mgr|| ', ' || i.hiredate|| ', ' || i.sal|| ', ' || i.comm|| ', ' || i.deptno || ', ' ||i.del_dt);
end loop;
--------------------------------------------------
rollback;
end;
--------------------------------------------------
9.在每天的早上9点之前和6点之后，不允许对emp表中的数据进行添加,修改,删除
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------
create or replace trigger t09
before delete or insert or update on emp
begin
  if to_char(sysdate, 'hh24') < 9 or to_char(sysdate, 'hh24') >= 18 then
    dbms_standard.raise_application_error(-20003, '在每天的早上9点之前和6点之后，不允许对emp表中的数据进行添加,修改,删除');
  end if;
end;  
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
alter trigger t09 enable;
update emp set sal = 700 where empno = 7369;
alter trigger t09 disable;
--------------------------------------------------  
10.当emp表中的数据变更时，统计各部门的人数，和员工的平均工资，总工资，
并将统计结果保存到统计表emp_cal表中
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------
create or replace trigger t10
before insert or delete or update on emp
declare
v_sql1 varchar2(300) := 'drop table emp_cal';
v_sql2 varchar2(300) := 'create table emp_cal as select deptno dno, count(1) d_members, round(avg(sal),2) d_avg_sal, sum(sal) d_sum_sal, sysdate op_dt from emp group by deptno';
begin
  execute immediate v_sql1;
  execute immediate v_sql2;
end; --尝试触发器中使用ddl语句但并不能↑
--------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------
drop table emp_cal;
select * from emp_cal;
create table emp_cal as select deptno dno, count(1) d_members, round(avg(sal),2) d_avg_sal, sum(sal) d_sum_sal, sysdate op_dt from emp where 1 = 0 group by deptno;
create or replace trigger t10
after insert or delete or update on emp
begin
  delete from emp_cal;
  insert into emp_cal select deptno dno, count(1) d_members, round(avg(sal),2) d_avg_sal, sum(sal) d_sum_sal, sysdate op_dt from emp group by deptno;
end;
--------------------------------------------------
----------------代码测试↓--------------------
--------------------------------------------------
select deptno dno, count(1) d_members, round(avg(sal),2) d_avg_sal, sum(sal) d_sum_sal, sysdate op_dt from emp group by deptno;
delete from emp where empno = 1111;
--------------------------------------------------
begin
for v in (select * from emp) loop
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
end loop;
dbms_output.put_line(rpad('-', 50, '-'));
for i in (select * from emp_cal) loop
  dbms_output.put_line(i.dno|| ', ' || i.d_members|| ', ' || i.d_avg_sal|| ', ' || i.d_sum_sal|| ', ' || i.op_dt);
end loop;
--------------------------------------------------
rollback;
end;
--------------------------------------------------
 11.创建一个包，包中包含以下功能
 1.函数，传入一个员工编号，返回员工的信息
 2.过程，根据员工编号，修改员工的工资 （两个参数，一个员工编号，一个员工工资）
 3.函数，根据部门编号，返回该部门的人数 
 4.过程，根据部门编号，输出该部门下所有员工的详细信息 (一个部门编号是传入参数，输出参数，集合类型，需要在包声名一个类型)
 --------------------------------------------------
----------------代码实现↓--------------------
--------------------------------------------------
create or replace package pk01
is
        type ctype is table of emp%rowtype;
       function f_e_info(eno number) return emp%rowtype;
       procedure p_e_csal(eno number, v_sal number);
       function f_e_mem(dno number) return number;
       procedure p_e_dinfo(dno number, c out ctype);
       
end pk01; 

create or replace package body pk01
is
       type ctype is table of emp%rowtype;
       function f_e_info(eno number) 
       return emp%rowtype
       is
       e emp%rowtype;
       begin
         select * into e from emp where empno = eno;
       end;
       
        procedure p_e_csal(eno number, v_sal number)
        is
        begin
          update from emp set sal = v_sal where empno = eno;
        end;
        
        function f_e_mem(dno number) 
        return number
        is
        n number;
        begin
          select count(1) into n from emp where deptno = dno;
          return n;
        end;
        
        procedure p_e_dinfo(dno number, c out ctype)
        is
        c ctype;
        begin
          select * bulk collect into c from emp where deptno = dno;
        end;
       
end pk01; 
