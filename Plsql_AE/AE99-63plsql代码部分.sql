1.  дһ��PLSQL������ӡ99�˷����ʽ��5�֣�
--------------------------------------------------
--------------------����----------------------
-------------------------------------------------- 

-------------------------------------------------- 
2.	дһ��PLSQL������ӡ99�˷����ʽ��5�֣�
--------------------------------------------------
----------------����ʵ�֡�--------------------
-------------------------------------------------- 
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
3.	�ֱ������αꡢ���ϱ���dept���е����ݣ�10�֣� 
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------   
declare
cursor cur is select * from dept;
begin
  for v in cur loop
    dbms_output.put_line(v.deptno|| ',' || v.dname|| ',' || v.loc);
    end loop;
    end;
--���α� ������    
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
4.	дһ�������飬����һ�����źź�Ա����ţ������Ӧ��Ա����Ϣ��
�����Ų����ڣ��򷵻ء�����Ĳ��Ų���ȷ�����������롯��
�����Ŵ��ڣ�Ա�������ڣ��򷵻ء������ڲ����ڸ�Ա������10�֣�
--------------------------------------------------
--------����ʵ�֣��α�ѭ������----------
--------------------------------------------------
declare
dno number := 20;
eno number := 7369;
cursor cur1 is select * from dept where deptno = dno;
cursor cur2 is select * from emp where deptno = dno and empno = eno;
v dept%rowtype;
n emp%rowtype;
begin
  open cur1;
  loop
    fetch cur1 into v;
     if cur1%notfound then
       dbms_output.put_line('����Ĳ��Ų���ȷ������������');
       exit;
     else
       open cur2;
       loop
         fetch cur2 into n;
         if cur2%notfound then
         dbms_output.put_line('�����ڲ����ڸ�Ա��');
         exit;
         else
           dbms_output.put_line(n.empno|| ', ' || n.ename|| ', ' || n.job|| ', ' || n.mgr|| ', ' || n.hiredate|| ', ' || n.sal|| ', ' || n.comm|| ', ' || n.deptno);
           exit;
         end if;
       end loop;
       close cur2;
       exit;
     end if;
  end loop;
  close cur1;
end;
--------------------------------------------------
---------����ʵ�֣������飩��------------
--------------------------------------------------
declare
eno number := 7369;
dno number := 10;
d dept%rowtype;
e emp%rowtype;
v_sql varchar2(200);
begin
   select * into d from dept where deptno = dno;
    --dbms_output.put_line('deptno confirmed');
    begin
    select * into e from emp where deptno = dno and empno = eno;
    v_sql := e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno;
    dbms_output.put_line(v_sql);
    exception
      when no_data_found then   
        dbms_output.put_line('�����ڲ����ڸ�Ա��');
    end;
    exception 
      when no_data_found then        
        dbms_output.put_line('����Ĳ��Ų���ȷ������������');
        end;
--------------------------------------------------
--------����ʵ�֣��洢�ṹ����----------
--------------------------------------------------
create or replace procedure pae99_04(dno in number, eno in number)
is
d dept%rowtype;
e emp%rowtype;
--v_sql varchar2(200);
begin
   select * into d from dept where deptno = dno;
    --dbms_output.put_line('deptno confirmed');
    begin
    select * into e from emp where deptno = dno and empno = eno;
    dbms_output.put_line(e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno);
    exception
      when no_data_found then   
        dbms_output.put_line('�����ڲ����ڸ�Ա��');
    end;
    exception 
      when no_data_found then        
        dbms_output.put_line('����Ĳ��Ų���ȷ������������');
        end;

call pae99_04(20, 7369);        
--------------------------------------------------
-----------����ʵ�֣���������-------------
--------------------------------------------------
create or replace function fae99_04(eno in number, dno in number)
return varchar2
is
--eno number := 7369;
--dno number := 10;
d dept%rowtype;
e emp%rowtype;
v_sql varchar2(200);
begin
   select * into d from dept where deptno = dno;
    --dbms_output.put_line('deptno confirmed');
    begin
    select * into e from emp where deptno = dno and empno = eno;
    v_sql := e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno;
    return v_sql;
    --dbms_output.put_line(e.empno|| ', ' || e.ename|| ', ' || e.job|| ', ' || e.mgr|| ', ' || e.hiredate|| ', ' || e.sal|| ', ' || e.comm|| ', ' || e.deptno);
    exception
      when no_data_found then
        v_sql := '�����ڲ����ڸ�Ա��';
        return v_sql;
        --dbms_output.put_line('�����ڲ����ڸ�Ա��');
    end;
    exception 
      when no_data_found then
        v_sql := '����Ĳ��Ų���ȷ������������';
        return v_sql;
        --dbms_output.put_line('����Ĳ��Ų���ȷ������������');
        end;
       
       begin
       dbms_output.put_line(fae99_04(7369,20));
       end;
--------------------------------------------------
5.	�������û���
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
--------------------------------------------------
create table dept_bak as select * from dept where 1 = 0;
select * from dept_bak;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
declare
type ctype is table of dept_bak%rowtype index by pls_integer;
c ctype;
begin
  select * bulk collect into c from dept_bak;
  for v in c.first..c.last loop
    dbms_output.put_line(c(v).deptno || ', ' || c(v).dname || ', ' || c(v).loc);
    end loop;
  end;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
--------------ʹ���쳣�����----------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
not_matched exception;
pragma exception_init(not_matched, -06502);
s varchar2(200);
type ctype is table of user_login%rowtype index by pls_integer;
c ctype;
v user_login%rowtype;
  begin
    select ul.* bulk collect into c from user_login ul where ul.username = uname;
    for i in c.first..c.last loop
      null;
      end loop;
    begin 
    select ul.* bulk collect into c from user_login ul where ul.username = uname and ul.password = pwd;
    for i in c.first..c.last loop
      null;
    end loop;
    s := '��½�ɹ�';
    return s;
    exception
      when not_matched then
        s := '�û��������벻��ȷ';
        return s;
    end;
  exception
    when not_matched then
      s := '���û������ڣ�����ע��';
      return s;
  end;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
begin
  dbms_output.put_line(fae99_05('takami', 'Fils1109'));
  dbms_output.put_line(fae99_05('takami', 'wer665')); 
  dbms_output.put_line(fae99_05('11', 'Fils1109'));
  dbms_output.put_line(fae99_05('takami', 'wer'));
end;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
---------------ʹ�����̿��ơ�---------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
s varchar2(200);
flag number := 0;
begin
  for i in (select * from user_login) loop
    if i.username = uname then
      for v in (select * from user_login ul where ul.username = i.username) loop
        if v.password = pwd then
          flag := 1;
          exit;
        else
          flag := 2;
        end if;
      end loop;
      exit;
    else
      null;
    end if;
  end loop;
  
  case flag
    when 0 then
      s := '���û������ڣ�����ע��';
      when 1 then
        s := '��½�ɹ�';
        when 2 then
          s := '�û��������벻��ȷ';
          end case;
          return s;
end;
--------------------------------------------------
------------�����û�����Ψһ��
--------------------------------------------------
-------------�����û���Ψһ��
--------------------------------------------------
begin
delete from user_login u where u.id = 2;
insert into user_login values (2, 'houzhi', 'wer665');
commit;
end;
select * from user_login;
--------------------------------------------------
-------------�޸����ݴ����-----------------
--------------------------------------------------
-------------ʹ���쳣�����-----------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
v user_login%rowtype;
s varchar2(200);
begin
  select * into v from user_login ul where ul.username = uname;
  begin
    select * into v from user_login ul where ul.username = uname and ul.password = pwd;
    s := '��½�ɹ�';
    return s;
    exception
    when no_data_found then
      s := '�û��������벻��ȷ';
      return s;
  end;
  exception
    when no_data_found then
      s := '���û������ڣ�����ע��';
      return s;
end;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
begin
  dbms_output.put_line(fae99_05('takami', 'Fils1109'));
  dbms_output.put_line(fae99_05('houzhi', 'wer665')); 
  dbms_output.put_line(fae99_05('11', 'Fils1109'));
  dbms_output.put_line(fae99_05('takami', 'wer'));
end;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
-------------ʹ�����̿��ơ�-----------------
--------------------------------------------------
create or replace function fae99_05(uname varchar2, pwd varchar2)
return varchar2
is
s varchar2(200);
flag number := 0;
begin
  for v in (select * from user_login) loop
    if v.username = uname then
      for i in (select * from user_login ul where ul.username = v.username) loop
        if i.password = pwd then
          flag := 1;
          exit;
        else
          flag := 2;
        end if;
      end loop;
      exit;
    else
      null;
    end if;
  end loop;
  
  case flag
    when 0 then
      s := '���û������ڣ�����ע��';
    when 1 then
      s := '��½�ɹ�';
    when 2 then
      s := '�û��������벻��ȷ';
    end case;
    return s;
end;
--------------------------------------------------
6.	�����±�account���˻���,account_history(�˻���¼��)
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
drop table t_account;
drop table t_account_history;
create table t_account(
aid varchar2(3),
aname varchar2(10),
amount number,
dt date);

create table t_account_history(
aid varchar2(3),
aname varchar2(10),
amount number,
start_dt date,
end_dt date);

insert into t_account
select '001', '����', '20000', to_date('2019-01-22', 'yyyy-mm-dd') from dual
union
select '002', '����', '4000', to_date('2019-03-12', 'yyyy-mm-dd') from dual;

insert into t_account_history
select '001', '����', '20000', to_date('2019-01-22', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual
union
/*select '001', '����', '15000', to_date('2019-04-01', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual
union*/
select '002', '����', '4000', to_date('2019-03-12', 'yyyy-mm-dd'), to_date('2999-12-31', 'yyyy-mm-dd') from dual;
commit;
select * from t_account;
select * from t_account_history;
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
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------
create or replace procedure pae99_06(a_id varchar2, a_name varchar2, v_amount number, v_dt date)
is
flag number := 0;
balance number; 
v_sql1 varchar2(300) := 'insert into t_account values (:1, :2, :3, :4) returning amount into :5';
v_sql2 varchar2(300) := 'update t_account set amount = amount + :1, dt = :2 where aid = :3 returning amount into :4';
v_sql3 varchar2(300) := 'update t_account_history set end_dt = :1 where aid = :2 and end_dt = to_date(''2999-12-31'', ''yyyy-mm-dd'')';
v_sql4 varchar2(300) := 'insert into t_account_history select :1, :2, :3, :4, to_date(''2999-12-31'', ''yyyy-mm-dd'') from dual';

begin
  for v in (select * from t_account) loop
    if v.aid = a_id then
      flag := 1;
      exit;
    else
      null;
    end if;
  end loop;
  
  case flag
    when 0 then
      execute immediate v_sql1 using a_id, a_name, v_amount, v_dt returning into balance;
      when 1 then
        execute immediate v_sql2 using v_amount, v_dt, a_id returning into balance;
        execute immediate v_sql3 using v_dt, a_id;
  end case;
  execute immediate v_sql4 using a_id, a_name, balance, v_dt;
end;
--------------------------------------------------
----------------���Դ����--------------------
--------------------------------------------------
begin
  for v in (select * from t_account) loop
    dbms_output.put_line(v.aid|| ', ' || v.aname|| ', ' || v.amount|| ', ' || v.dt);
  end loop;
  dbms_output.put_line(rpad('-', 50, '-'));
  for i in (select * from t_account_history) loop
    dbms_output.put_line(i.aid|| ', ' || i.aname|| ', ' || i.amount|| ', ' || i.start_dt || ', ' || i.end_dt);
  end loop;
  pae99_06('001', '����', -5000, to_date('20190401', 'yyyymmdd'));
  pae99_06('004', 'takami', 11000, trunc(sysdate));
  dbms_output.put_line(rpad('-', 50, '-'));
  dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from t_account order by aid) loop
    dbms_output.put_line(v.aid|| ', ' || v.aname|| ', ' || v.amount|| ', ' || v.dt);
  end loop;
  dbms_output.put_line(rpad('-', 50, '-'));
  for i in (select * from t_account_history order by aid) loop
    dbms_output.put_line(i.aid|| ', ' || i.aname|| ', ' || i.amount|| ', ' || i.start_dt || ', ' || i.end_dt);
  end loop;
  rollback;
end;
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
--------------------------------------------------
----------------����Ԥ����--------------------
--------------------------------------------------
alter table emp drop constraint FK_DEPTNO;
-- sys dba
grant create any table to scott;
--------------------------------------------------
----------------����ʵ�֡�--------------------
--------------------------------------------------
create or replace procedure pae99_07
is
v_sql1 varchar2(300) := 'drop table dept';
v_sql2 varchar2(300) := 'create table dept (deptno number(2), dname varchar2(14), loc varchar2(13))';
v_sql3 varchar2(300) := 'insert into dept select 10, ''ACCOUNTING'', ''NEW YORK'' from dual union select 20, ''RESEARCH'', ''DALLAS'' from dual union select 30, ''SALES'', ''CHICAGO'' from dual union select 40, ''OPERATIONS'', ''BOSTON'' from dual';
v_sql4 varchar2(300) := 'alter table dept add constraint pk_dept_deptno primary key (deptno)';
v_sql5 varchar2(300) := 'alter table dept modify dname not null';
begin
  execute immediate v_sql1;
  execute immediate v_sql2;
  execute immediate v_sql3;
  execute immediate v_sql4;
  execute immediate v_sql5;
  commit;
end;  
--------------------------------------------------
----------------������ԡ�--------------------
--------------------------------------------------
call pae99_07();
select * from dept;
insert into dept(deptno, dname) values(40, 'aa');
insert into dept(dname) values('aa');
insert into dept(deptno) values(50);
--------------------------------------------------
8.дһ��������װ�Թ�Ա��Ϣ�Ĳ������������¹��ܣ�10�֣�
   1.������й�Ա��Ϣ
   2.��ѯ��˾�����쵼��������Ա��������û�����������Ϊ0
   3.����ÿ�����ŵĲ��ű�ţ��������ƣ�
   Ա�������Լ�н�ʴ���5000�ĸ�нԱ������
   4.����һ�����ű�ź�н�ʣ����ظò��Ÿ��������н�ʵ�Ա������
   
--------------------------------------------------
create or replace package pkas99_08
is     
       e emp%rowtype;
       
       procedure p_output_einfo
         is
         begin
           for v in emp loop
             dbms_output.put_line()
           end loop;
         end;

end pkas99_08;

create or replace package body pkas99_08
is

end pkas99_08;

 
    
