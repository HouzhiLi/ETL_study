stu��ѧ����
create table stu(
   sno number(11) primary key, --ѧ��
   sname varchar2(30), --����
   sage number(3), --����
   ssex varchar2(3) --�Ա�
);
insert into stu 
select 1,'����',18,'��' from dual
union all
select 2,'����',28,'��' from dual
union all
select 3,'����',19,'��' from dual
union all
select 4,'����',18,'Ů' from dual;
teacher��(��ʦ��)
create table teacher(
   tno number(11) primary key, --��ʦ���
   tname varchar2(30) --��ʦ����
);
insert into teacher
select 1,'��Сƽ' from dual
union all
select 2,'����' from dual
union all
select 3,'smith' from dual
union all
select 4,'��С��' from dual
union all
select 5,'��С��' from dual
union all
select 6,'�ź�' from dual;
corse���γ̱�
create table course(
   cno number(11) primary key, --�γ̺�
   cname varchar2(40),   --�γ�����
   tno number(11) --��ʦ���
);
insert into course
select 1,'����',1 from dual
union all
select 2,'Ӣ��',3 from dual
union all
select 3,'oracle',2 from dual
union all
select 4,'python',5 from dual
union all
select 5,'etl',6 from dual
union all
select 6,'��ѧ',4 from dual;

sc��(ѡ�α�)
create table sc(
   sno number(11), --ѧ��
   cno number(11), --�γ̺�
   score number(3)  --�ɼ�
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

sc_number��ѡ��ͳ�Ʊ�
create table sc_number(
   sno number(10),  --ѧ��
   nu number(3),   --ѡ����
   score number(4,1)  --ƽ���ɼ�
);
select * from stu;
select * from sc;
select * from course;
select * from teacher;
select * from sc_number;
--------------------------------------------------
-----------------����tips��--------------------
--------------------------------------------------
/*
 Ŀ¼�������в�֧������Ĵ���
 ʹ��after������ʱ�����ִ�е���insert,update���delete��䣬
   ��ô�������ڴ����������ж�ԭ������κβ���
*/

/*�α�*/
create or replace trigger tr1
before insert on sc for each row
declare
   --����һ����������sc_number���е���������
   n number(3);
begin
   --pragma autonomous_transaction;
   --�м�������������ͨ����new��ȡ������ӵ�����
   --�ж�sc_number����û�и�ѧ����ѡ������¼
   select count(*) into n from sc_number where sno=:new.sno;
  -- n:=0;
   if n=0 then
     --insert into sc_number select :new.sno,count(*) from sc where sno=:new.sno;
     --����ѧ�Ų�ѯѧ����ѡ����
     --insert into sc_number(sno,nu) values(:new.sno,1); --�����sc����û�����ݵ����������дû������
     --���sc���������ݣ���Ҫͳ��һ��ѧ����ѡ����
     dbms_output.put_line('��sc_number�������һ���µļ�¼:'||:new.sno);
     select count(1) into n from sc where sno=:new.sno;--ֻ�ܷ���sc���before��������
     insert into sc_number(sno,nu) values(:new.sno,n);
   end if;
   --˵��sc_number�����Ѿ��и�ѧ����ѡ����������ѡ������1
   update sc_number set nu=nu+1 where sno=:new.sno;
end;
select * from sc where sno=1;


select sc.*,1 from sc where sno=1;

select count('a') from sc where sno=1;
select count(1) from sc where sno=1;

count(1):count(����)��ִ��Ч�ʱ�count(*)��

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
--����sc���У���һ����������  alter sc add constraint pk_sc primary key(sno,cno);
select 1,count(*) from sc where sno=1;
/*
   ����в�������
   ��һ��
   insert into ����(����,����,...) values(ֵ,ֵ,...);
   �ڶ���
   insert into ����(����,...) select ���; --���Բ���������ݣ�Ҳ���Բ���һ������
      select���Ĳ�ѯ���Ҫ�ͱ���������һ��
*/
/*
Ҫʹ��before�������������ڴ����������ж�sc������ݽ��в�����crud��

ʹ��after������ʱ�����ܶ�sc�����ݽ��в���


1.��Ϊ���ǵ��������Ǵ�����sc���������ݵ�����£�������Ҫ��sc���в�ѯ���ݣ�����before������*/
1.��sc���������ʱ���޸�sc_number���е�ѡ���������sc_number��û���������һ��
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------   
/*create or replace trigger t01
before insert on sc for each row
declare
n number;
begin
  select count(1) into n from sc_number where sno = :new.sno;
  case n
    when 0 then
      dbms_output.put_line('����ѧ��ѧ�ţ�' || :new.sno);
      insert into sc_number values (:new.sno, 1, :new.score);
      else
        update sc_number set nu = nu+1, score = (score*nu + :new.score)/(nu+1) where sno = :new.sno;
      end case;
end;*/
--------------------------------------------------
----------------����ʵ�֡�--------------------
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
----------------������ԡ�--------------------
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
2.��ɾ��sc��ʱ���޸�sc_number���е�ѡ����
--------------------------------------------------
----------------����ʵ�֡�--------------------
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
----------------������ԡ�--------------------
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
3.���޸�sc������ʱ������޸���ѧ��sno���޸�sc_number����Ӧ��ѡ�����������ӡ'ѧ����ѡ����Ϣ�Ѹ���'
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------  
create or replace trigger t03
before update on sc for each row
declare
n number;
m number;
begin
  --1.��δ�޸�sno����ֻ�޸�sc_number���е�ƽ���֣�����ӡ��ѧ����ѡ����Ϣ�Ѹ��ġ�
  if :old.sno = :new.sno then
    update sc_number set score = (score*nu - :old.score + :new.score)/nu where sno = :old.sno;
    dbms_output.put_line('ѧ����ѡ����Ϣ�Ѹ���');
  --1.���޸�sno�����ж���sno�Ƿ�Ϊsc��������sno����������ֱ�Ӹ���sc_number���еĸ�����
    else
      update sc_number set nu = nu + 1, score = (score*nu + :new.score)/(nu+1) where sno = :new.sno returning  sno into n;
    --2.����sno��sc���в����ڣ�������sc_number��������һ����Ӧ����
       if n is null then
      --3.ͬ������sc_number���о�sno��Ӧ�����ݵ�nu
      update sc_number set nu = nu - 1 where sno = :old.sno returning nu into m;
      insert into sc_number values (:new.sno, 1, :new.score);
        --4.��nuΪ0�����c_number�����Ƴ�������
      if m = 0 then
        delete from sc_number where sno = :old.sno;
          --5.��nu��Ϊ0�����c_number���и��¸����ݵ�score
        else
          update sc_number set score = (score*(nu+1) - :old.score)/nu where sno = :old.sno;
      end if;
    --2
      else
      --3.ͬ������sc_number���о�sno��Ӧ�����ݵ�nu
        update sc_number set nu = nu - 1 where sno = :old.sno returning nu into m;
        --4.��nuΪ0�����c_number�����Ƴ�������
        if m = 0 then
        delete from sc_number where sno = :old.sno;
          --5.��nu��Ϊ0�����c_number���и��¸����ݵ�score
        else
          update sc_number set score = (score*(nu+1) - :old.score)/nu where sno = :old.sno;
      end if;
      end if;
    end if;
end;
--------------------------------------------------
----------------������ԡ�--------------------
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
4.����ɾ���ɼ���90�����ϵ�ѧ����ѡ����Ϣ
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------  
create or replace trigger t04
before delete on sc for each row
begin
  if :old.score >= 90 then
    dbms_standard.raise_application_error(-20001, '����ɾ���ɼ���90�����ϵ�ѧ����ѡ����Ϣ');
  end if;
end;
--------------------------------------------------
----------------������ԡ�--------------------
--------------------------------------------------
alter trigger t04 enable;
delete from sc where sno = 1 and cno =5;
alter trigger t04 disable;
--------------------------------------------------
5.��stu�����������ʱ�����䲻�ܳ���30��
--------------------------------------------------
----------------����ʵ�֡�--------------------
-------------------------------------------------- 
create or replace trigger t05
before insert on stu for each row
begin
  if :new.sage > 30 then
    dbms_standard.raise_application_error(-20002, '���䲻�ܳ���30��');
  end if;
end;
--------------------------------------------------
----------------������ԡ�--------------------
--------------------------------------------------
alter trigger t05 enable;
insert into stu select 6,'��aa',31,'��' from dual;
alter trigger t05 disable;
--------------------------------------------------
6.ɾ��ѧ����Ϣʱ��ͬʱɾ��sc���sc_number���е�����
--------------------------------------------------
----------------����ʵ�֡�--------------------
-------------------------------------------------- 
create or replace trigger t06
before delete on stu for each row
begin
  delete from sc where sno = :old.sno;
  end;
--------------------------------------------------
----------------������ԡ�--------------------
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
7.�޸�emp���еĹ���ʱ��ֻ�����Ӳ��ܼ���
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------  
create or replace trigger t07 
before update on emp for each row
begin
  if :old.sal > :new.sal then
    dbms_standard.raise_application_error(-20022, '���ܼ��ٹ���');
  end if;
end;
--------------------------------------------------
----------------������ԡ�--------------------
--------------------------------------------------
alter trigger t07 enable;
update emp set sal = 700 where empno = 7369;
alter trigger t07 disable;
--------------------------------------------------
8.��ǰɾ��emp���е�����ʱ�������ݱ��ݵ�emp_log����
emp_log������䣺
drop table emp_log;
create table emp_log as select emp.*, sysdate as del_dt from emp where 1 = 0;
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------  
create or replace trigger t08
before delete on emp for each row
begin
  insert into emp_log select :old.empno, :old.ename, :old.job, :old.mgr, :old.hiredate, :old.sal, :old.comm, :old.deptno, sysdate from dual;
end;
--------------------------------------------------
----------------������ԡ�--------------------
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
9.��ÿ�������9��֮ǰ��6��֮�󣬲������emp���е����ݽ������,�޸�,ɾ��
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------
create or replace trigger t09
before delete or insert or update on emp
begin
  if to_char(sysdate, 'hh24') < 9 or to_char(sysdate, 'hh24') >= 18 then
    dbms_standard.raise_application_error(-20003, '��ÿ�������9��֮ǰ��6��֮�󣬲������emp���е����ݽ������,�޸�,ɾ��');
  end if;
end;  
--------------------------------------------------
----------------������ԡ�--------------------
--------------------------------------------------
alter trigger t09 enable;
update emp set sal = 700 where empno = 7369;
alter trigger t09 disable;
--------------------------------------------------  
10.��emp���е����ݱ��ʱ��ͳ�Ƹ����ŵ���������Ա����ƽ�����ʣ��ܹ��ʣ�
����ͳ�ƽ�����浽ͳ�Ʊ�emp_cal����
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------
create or replace trigger t10
before insert or delete or update on emp
declare
v_sql1 varchar2(300) := 'drop table emp_cal';
v_sql2 varchar2(300) := 'create table emp_cal as select deptno dno, count(1) d_members, round(avg(sal),2) d_avg_sal, sum(sal) d_sum_sal, sysdate op_dt from emp group by deptno';
begin
  execute immediate v_sql1;
  execute immediate v_sql2;
end; --���Դ�������ʹ��ddl��䵫�����ܡ�
--------------------------------------------------
----------------����ʵ�֡�--------------------
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
----------------������ԡ�--------------------
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
 11.����һ���������а������¹���
 1.����������һ��Ա����ţ�����Ա������Ϣ
 2.���̣�����Ա����ţ��޸�Ա���Ĺ��� ������������һ��Ա����ţ�һ��Ա�����ʣ�
 3.���������ݲ��ű�ţ����ظò��ŵ����� 
 4.���̣����ݲ��ű�ţ�����ò���������Ա������ϸ��Ϣ (һ�����ű���Ǵ������������������������ͣ���Ҫ�ڰ�����һ������)
 --------------------------------------------------
----------------����ʵ�֡�--------------------
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
