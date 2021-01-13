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
1.��sc���������ʱ���޸�sc_number���е�ѡ���������sc_number��û���������һ��
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

1.��Ϊ���ǵ��������Ǵ�����sc���������ݵ�����£�������Ҫ��sc���в�ѯ���ݣ�����before������

2.��ɾ��sc��ʱ���޸�sc_number���е�ѡ����
3.���޸�sc������ʱ������޸���ѧ��sno���޸�sc_number����Ӧ��ѡ�����������ӡ'ѧ����ѡ����Ϣ�Ѹ���'


4.����ɾ���ɼ���90�����ϵ�ѧ����ѡ����Ϣ


5.��stu�����������ʱ�����䲻�ܳ���30��

6.ɾ��ѧ����Ϣʱ��ͬʱɾ��sc���sc_number���е�����

7.�޸�emp���еĹ���ʱ��ֻ�����Ӳ��ܼ���

8.��ǰɾ��emp���е�����ʱ�������ݱ��ݵ�emp_log����
emp_log������䣺


9.��ÿ�������9��֮ǰ��6��֮�󣬲������emp���е����ݽ������,�޸�,ɾ��

10.��emp���е����ݱ��ʱ��ͳ�Ƹ����ŵ���������Ա����ƽ�����ʣ��ܹ��ʣ�
����ͳ�ƽ�����浽ͳ�Ʊ�emp_cal����


 11.����һ���������а������¹���
 1.����������һ��Ա����ţ�����Ա������Ϣ
 2.���̣�����Ա����ţ��޸�Ա���Ĺ��� ������������һ��Ա����ţ�һ��Ա�����ʣ�
 3.���������ݲ��ű�ţ����ظò��ŵ����� 
 4.���̣����ݲ��ű�ţ�����ò���������Ա������ϸ��Ϣ (һ�����ű���Ǵ������������������������ͣ���Ҫ�ڰ�����һ������)
 