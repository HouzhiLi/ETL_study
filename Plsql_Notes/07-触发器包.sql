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

