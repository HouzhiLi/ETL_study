1.д��loopѭ����whileѭ����forѭ��������

--------------------------------------------------   
--------------------------------------------------
2.  дһ��PLSQL������ӡ99�˷����ʽ��5�֣�
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
3.	�ֱ������αꡢ���ϱ���dept���е����ݣ�10�֣� 
--�α�
declare
cursor cur is select * from dept;
begin
  for v in cur loop
    dbms_output.put_line(v.deptno || ', ' || v.dname || ', ' || v.loc);
  end loop;
end;    
--����
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
4.  дһ�������飬����һ�����źź�Ա����ţ������Ӧ��Ա����Ϣ��
�����Ų����ڣ��򷵻ء�����Ĳ��Ų���ȷ�����������롯��
�����Ŵ��ڣ�Ա�������ڣ��򷵻ء������ڲ����ڸ�Ա������10�֣�
declare
dno number := &dno;
eno number := &eno;
n number;
v emp%rowtype;
begin
  select count(1) into n from emp where deptno = dno;
  case n
    when 0 then 
      dbms_output.put_line('����Ĳ��Ų���ȷ������������');
    else
      select count(1) into n from emp where deptno = dno and empno = eno;
      case n 
        when 0 then
          dbms_output.put_line('�����ڲ����ڸ�Ա��');
        else
          select * into v from emp where deptno = dno and empno  = eno;
          dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
        end case;
    end case;
end;
--------------------------------------------------   
--------------------------------------------------
5.  �������û���
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
----------------��������--------------------
--------------------------------------------------
дһ��������ʵ���û��ĵ�½���ܣ������û��������룬
��ǰ�û��������붼��ȷʱ�����ء���½�ɹ�����
����û��������ڣ����ء����û������ڣ�����ע�ᡱ��
������벻��ȷ���򷵻ء��û��������벻��ȷ��(10��)
create or replace function fun05(uname varchar2, pwd varchar2)
return varchar2
is
n number;
s varchar2(200);
begin
  select count(1) into n from user_login where username = uname;
  case n
    when 0 then
      s := '���û������ڣ�����ע��';
    else
      select count(1) into n from user_login ul where ul.username = uname and ul.password = pwd;
      case n
        when 0 then
          s := '�û��������벻��ȷ';
        else
          s := '��½�ɹ�';
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
6.  �����±�account���˻���,account_history(�˻���¼��)
account��
id���˺ţ�  name��������  amount(���)  dt(����޸�ʱ��)
001            ����          20000           2019-01-22
002            ����          4000            2019-03-12
... ... ... ...
account_history��
id(�˺�)  name(����)  amount(���)  start_dt(��ʼʱ��)  end_dt(����ʱ��)
001       ����          20000           2019-01-22        2019-04-01
001       ����          15000           2019-04-01        2999-12-31
002       ����          4000            2019-03-12        2999-12-31
... ... ... ... ...
--------------------------------------------------
----------------��������--------------------
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
select '001', '����', '20000', '2019-01-22' from dual
union
select '002', '����', '4000', '2019-03-12' from dual;

insert into account_history
select '001', '����', '20000', '2019-01-22', '2999-12-31'from dual
union
/*select '001', '����', '15000', to_date('2019-04-01', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual
union*/
select '002', '����', '4000', '2019-03-12', '2999-12-31' from dual;
commit;
select * from account;
select * from account_history;
--------------------------------------------------
----------------��������--------------------
--------------------------------------------------
Ҫ��ʵ��:����account�������û�ʱ����account_history��������һ����¼��
��ʼʱ��Ϊ��ǰʱ�䣬����ʱ��Ϊ2999-12-31.
��account��ļ�¼���޸�ʱ�������������˺ţ�
������2019-04-01����ȡ��5000Ԫ�����޸�account������ʱ��
��account_history������������һ����¼�Ľ���ʱ���Ϊ2019-04-01��
����account_history�������һ����¼
������ͼ��2����¼����ʼʱ��Ϊ��ǰʱ��2019-04-01������ʱ��Ϊ2999-12-31��
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

update account set name = 'takami', amount = 15000, dt = '2019-04-01' where name = '����';
--------------------------------------------------   
--------------------------------------------------
7.дһ���洢���̣����ڻָ����ݿ���dept������ݣ�10�֣�
1.	��dept����ڣ��򽫸ñ�ɾ�������´����ñ����򴴽�ֱ�ӽ���
2.	�����������ݣ�
     Deptno      dname             loc
      10       ACCOUNTING        NEW YORK
      20       RESEARCH              DALLAS
      30        SALES                   CHICAGO
      40      OPERATIONS          BOSTON
3.��dept���deptno �ֶ��ϴ�������Լ��������Ҫ���������зǿ�
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
8.дһ��������װ�Թ�Ա��Ϣ�Ĳ������������¹��ܣ�10�֣�
   1.������й�Ա��Ϣ
   2.��ѯ��˾�����쵼��������Ա��������û�����������Ϊ0
   3.����ÿ�����ŵĲ��ű�ţ��������ƣ�
   Ա�������Լ�н�ʴ���5000�ĸ�нԱ������
   4.����һ�����ű�ź�н�ʣ����ظò��Ÿ��������н�ʵ�Ա������
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
