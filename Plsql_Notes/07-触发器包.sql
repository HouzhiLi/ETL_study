������
��������oracle��ִ��dml��ddl���ʱ����ִ�е�һ�δ��룬�����������ִ��֮ǰ���У�
  Ҳ�������������֮�����У��������滻���ִֻ�д���������
  �������ķ��ࣺ��������(��伶������)���м�������
  
��1����������
����������һ��sql���ֻ����ִ��һ�δ���������
�﷨��
create [or replace] trigger ��������
before|after insert[ or update or delete] on ������
declare
   ��������;
begin
   �����;
   �쳣����;
end;

trigger:�������Ĺؼ���
before|after:�ֱ��ʾ������������sql���ǰ|��ִ��
insert|update|delete:�ֱ��ʾinsert��|update���|delete���
on ��������������һ��������

��ʾ�ڱ���ִ��insert��update����delete���ǰ���ߺ�ִ������Ĵ����еĴ���
ע�⣺�������������һ�㲻����ִ��ddl��䣬Ҳ������Ա����dml������dql����


--дһ������������dept�����������������ʱ����ӡ��������ݡ�
create or replace trigger t1
before insert on dept
begin
  dbms_output.put_line('�������');
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

alter trigger �������� disable; --�ô�����ʧЧ
alter trigger t1 disable;
alter trigger �������� enable; --�ô�������Ч
alter trigger t1 enable;
drop trigger ��������; --ɾ��������
drop trigger t1;

inserting:�������ͣ���insert��䴥������������ʱ���ñ���Ϊtrue,����Ϊfalse
updating:�������ͣ���update��䴥������������ʱ������Ϊtrue,����Ϊfalse
deleting:�������ͣ���delete��䴥������������ʱ������ΪTrue,����Ϊfalse

--��¼��Ĳ�����־
create table log1(
  op varchar2(30),  ---ִ����ʲô����  insert update delete
  dt date    --��¼����ʱ��
);
��dept�������ݷ����ı�ʱ����¼sql��䵽log1����
create or replace trigger t1 
after insert or delete or update on dept
declare
   --����һ�����������������
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
   --��������¼���뵽log1����
   insert into log1 values(s,sysdate);
end;

select * from log1;

--дһ����������ʵ�ֵ�ǰ����10��֮ǰ��������6���Ժ�����Ա�dept������ɾ�Ĳ���
create or replace trigger t2
before insert or update or delete on dept
begin
  if to_char(sysdate,'hh24')<'10' or to_char(sysdate,'hh24')>=18 then
     dbms_standard.raise_application_error(-20222,'�ǹ���ʱ�䲻�����޸ı�����');
  end if;
end;

һ�����Ͽ����ж��������(7��)������������ִ�е�˳��
before ��伶������
before �м�������
sql���
after �м�������
after ��伶������ 

��2���м�������
�м���������һ��sql��䴥��ִ��1�λ��Σ�sql���Ӱ������ݿ�����������������

drop trigger t1;
drop trigger t2;
�м��������﷨��
create or replace trigger ��������
before|after  insert or update or delete on ���� for each row
declare

begin
  
end;

create or replace trigger t3
before insert on dept for each row
begin
  dbms_output.put_line('�м�������');
end;

:old ��¼���Ͷ���(����%rowtype),��ȡ���޸�ǰ������
      
:new ��¼���Ͷ���(����%rowtype),��ȡ���޸ĺ�Ķ���

   insert: :old����Ϊ�� ��:new������ֵ
   update: :old����ͣ�new����ֵ
   delete: :old������ֵ�� :new����Ϊ��
ע�⣺before����������ʹ��:new���󣬵�after�������в���ʹ��:new����

drop trigger t3;

create or replace trigger t4
before insert or update or delete on dept for each row
begin
   if inserting then
      dbms_output.put_line('insert');
      dbms_output.put_line(':old����'||:old.deptno||','||:old.dname||','||:old.loc);
      dbms_output.put_line(':new����'||:new.deptno||','||:new.dname||','||:new.loc);
   end if;
   if updating then
      dbms_output.put_line('update');
      dbms_output.put_line(':old����'||:old.deptno||','||:old.dname||','||:old.loc);
      dbms_output.put_line(':new����'||:new.deptno||','||:new.dname||','||:new.loc);
   end if;
   
   if deleting then
      dbms_output.put_line('delete');
      dbms_output.put_line(':old����'||:old.deptno||','||:old.dname||','||:old.loc);
      dbms_output.put_line(':new����'||:new.deptno||','||:new.dname||','||:new.loc);
   end if;
end;

drop trigger t4;

--ʹ�ô�������������
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
  --���������޸������е�ֵ
  :new.dno:=tt_seq.nextval;
end;
insert into tt values(1,'aa');
insert into tt(name) values('cc');
select * from tt;

--��¼���е���ϸ��־
--dept_log���ṹ���� 
create table dept_log as select dept.*,'aaaaaaaaaaaa' op,sysdate opt_time from dept where 1=0;

select * from dept_log;
--��ִ��insert���ʱ������������ݱ��浽dept_log���У�op�ֶε�ֵΪinsert opt_timeΪ��ǰʱ��
--��ǰִ��update���ʱ�������µ����ݱ��浽dept_log���У�����������update ����������������������
--��ִ��delete���ʱ����ɾ�������ݱ��浽dept_log���У�������������delete ................
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


--��ǰemp���������޸�ʱ���������С��2000,��ô��ʾ���ʲ��ܵ���2000
create or replace trigger t7
before insert or update on emp for each row
begin
  if :new.sal<2000 then
     dbms_standard.raise_application_error(-20001,'���ʲ��ܵ���2000');
  end if;
end;

update emp set sal=sal+2000 where empno=7369;

(3)�滻������
�滻���������滻ԭ��sql��䣬ִֻ�д��������룬ֻ�������ͼ
�﷨��
create or replace trigger ��������
instead of insert or update or delete on ��ͼ�� for each row
declare

begin
  
end;
drop view d_e;
create view d_e as select emp.*,dname,loc from emp join dept on emp.deptno=dept.deptno;

select * from d_e;

--������ͼ�в�������ʱ��
     ������Ų����ڣ����һ���µĲ��ţ�
     ���Ա�������ڣ����һ���µ�Ա��
     ������Ŵ��ڣ��޸Ĳ��ŵ���Ϣ
     ���Ա�����ڣ��޸�Ա����Ϣ
create or replace trigger t8 
instead of insert on d_e for each row
declare
   --����һ������n
   n number:=0;
begin
   select count(1) into n from dept where deptno=:new.deptno;
   --�жϲ����Ƿ����
   if n=0 then
      --������Ų����ڣ�ִ��insert����һ��������Ϣ
      insert into dept values(:new.deptno,:new.dname,:new.loc);
   else
      --������Ŵ��ڣ�ִ��update�޸Ĳ�����Ϣ
      update dept set dname=:new.dname,loc=:new.loc where deptno=:new.deptno;
   end if;
   select count(1) into n from emp where empno=:new.empno;   
   --�ж�Ա���Ƿ����
   if n=0 then
      --���Ա�������ڣ�ִ��insert����һ��Ա����Ϣ
      insert into emp values(:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
   else
      --���Ա�����ڣ�ִ��update�޸�Ա����Ϣ
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
   --�ж�Ա���Ƿ���ڣ�
   if n=1 then
     --������ڣ��޸�
     update emp set ename=:new.ename,
                     job=:new.job,
                     mgr=:new.mgr,
                     hiredate=:new.hiredate,
                     sal=:new.sal,
                     comm=:new.comm,
                     deptno=:new.deptno
                     where empno=:new.empno;
   else
     --��������ڣ����
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
        --Ա��������
        insert into emp values(:new.empno,:new.ename,:new.job,:new.mgr,:new.hiredate,:new.sal,:new.comm,:new.deptno);
     
     end if;

end;

��
�����Ƕ�֮ǰѧ�Ĵ洢���̣����������ͣ������ȵ�һ����װ
   ��Ϊ������������ͷ���Ͱ���ʵ�֣����壩
   
���������﷨��
create or replace package ����
is
    --���б�������������
    --�������͵Ķ���

    --���д洢���̵�����
    procedure �洢������(���� ����,....);
    --���к���������
    function ������(���� ����,....) return ����ֵ����;
end [����];   

create or replace package pk1
is
   --����һ������
   pi constant number(6,5):=3.14159;
   --����һ������
   s varchar2(30);
   --����һ������������
   type atype is table of varchar2(30) index by pls_integer;
   --����һ����������Բ�����
   function fn(r number) return number;
   --����һ���洢���̴�ӡ99�˷���
   procedure p1;
end pk1; 

begin
  dbms_output.put_line(pk1.pi);
end;

��������
create or replace package body ����
is
   --˽�б���������
   --˽�����͵Ķ���
   --˽�д洢���̺ͺ���
   --���д洢���̵�ʵ��
   procedure ������(���� ����,..)
     is
     
     begin
       
     end;
   --���к�����ʵ��
   function ������(����,����)
     return number
     is
     
     begin
       
     end;




end ����;

create or replace package body pk1
is
   --����һ������
   str varchar2(30):='Hello ףӢ̨';
   --����һ��˽�еĴ洢����
   procedure pn
     is
     begin
       dbms_output.put_line(str);
     end;
   --����һ��˽�еĺ���
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
   --���д洢���̵�ʵ��
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
     
   --���к�����ʵ��
   function fn(r number)
     return number
     is
     begin
       dbms_output.put_line(fnn(r));
       return pi*power(r,2);
     end;
end pk1;
����.�����������������ͣ��������洢���̵ȣ�
begin
  dbms_output.put_line(pk1.fn(3));
  pk1.p1;
end;
ע�⣺���������ֵ����ݶ����ڹ��ж��� ������ͨ������.������ֱ�Ӹ�
      �����У�δ���������������Ķ�����˽�ж���˽�ж���ֻֻ�����ڰ��ڱ�����
         ����˽�ж�������ڵ��ö����ǰ������
