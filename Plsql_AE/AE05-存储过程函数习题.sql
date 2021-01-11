
  drop procedure p2;
    drop procedure p3;
      drop procedure p4;
        drop procedure p5;
          drop procedure p6;
            drop procedure p7;

1.дһ���洢���̣�����Ա����Ϣ����emp���в���һ��Ա����Ϣ
create or replace procedure p01(v in emp%rowtype)
is
begin
  insert into emp values (v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno);
  end;
----------------------------------------------------------------------
declare
  v emp%rowtype;
  begin
    v.empno := &empno;
    v.ename := '&ename';
    v.job := '&job';
    v.mgr := &mgr;
    v.hiredate := &hiredate;
    v.sal := &sal;
    v.comm := &comm;
    v.deptno := &deptno;
    p1(v);
    end;

2.(��̬��)дһ���洢���̣�����һ���ַ�������Ա�����в���һ��Ա����Ϣ���ַ�����ʽ
Ա�����,����,����,�ϼ����,��ְʱ��,Ӷ��,���ű��
create or replace procedure p02(v in varchar2) is
/*declare
v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';*/
begin
  insert into emp
  values
    (substr(v, 1, instr(v, ',', 1, 1) - 1),
     substr(v,
            instr(v, ',', 1, 1) + 1,
            instr(v, ',', 1, 2) - instr(v, ',', 1, 1) - 1),
     substr(v,
            instr(v, ',', 1, 2) + 1,
            instr(v, ',', 1, 3) - instr(v, ',', 1, 2) - 1),
     substr(v,
            instr(v, ',', 1, 3) + 1,
            instr(v, ',', 1, 4) - instr(v, ',', 1, 3) - 1),
     to_date(substr(v,
            instr(v, ',', 1, 4) + 1,
            instr(v, ',', 1, 5) - instr(v, ',', 1, 4) - 1), 'yyyymmdd'),
     substr(v,
            instr(v, ',', 1, 5) + 1,
            instr(v, ',', 1, 6) - instr(v, ',', 1, 5) - 1),
     substr(v,
            instr(v, ',', 1, 6) + 1,
            instr(v, ',', 1, 7) - instr(v, ',', 1, 6) - 1),
     substr(v,
            instr(v, ',', 1, 7) + 1));
end;

select instr('aa,bb,cc', ',', -1, 1) from dual;
----------------------------------------
declare
m varchar2(300);
begin
  m := '1111,takami,worker,222,19951109,500,50,10';
  p02(m);
  end;
----------------------------------------
call p02('&v');  
select * from emp;
----------------------------------------
--declare
--v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
create or replace procedure p02(v varchar2)
is
n number;
tmp varchar2(20);
v_sql varchar2(300); 
vc varchar2(300) := '';
type ttype is table of varchar2(30);
t ttype;
begin
  n := (length(v) - length(replace(v, ',', '')) + 1);
  select data_type bulk collect into t from user_tab_cols where table_name = 'EMP';
  for i in 1..n loop
    if t(i) = 'DATE' then
      tmp := substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || 'to_date(''' || tmp || ''', ''yyyymmdd'')' || ',';
          else
    if i = 1 then
      tmp := substr(v, 1, instr(v, ',', 1, 1)-1);
      --dbms_output.put_line(tmp);
      vc := vc || '''' || tmp || '''' || ',';
      elsif i = n then
        tmp := substr(v, instr(v, ',', 1, i-1)+1);
        --dbms_output.put_line(tmp);
        vc := vc || tmp;   
        else
          tmp := substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || '''' || tmp || '''' || ',';
          end if;   
          end if;
    end loop;
    v_sql := 'insert into emp values('||vc||')';
    --dbms_output.put_line(vc);
    --dbms_output.put_line(v_sql);
    execute immediate v_sql;
    for m in (select * from emp) loop
    dbms_output.put_line(m.empno || ',' || m.ename);
    end loop;
    rollback;
    end;
    
declare
v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
begin
  p02(v);
  end;
--��ȡ�ַ���(������ʽ)

--select regexp_substr('1111,takami,worker,222,19951109,500,50,10', '[^,]+', 1, 1) from dual;
create or replace procedure p02(v varchar2)
is
--declare
--v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
n number;
tmp varchar2(20);
v_sql varchar2(300); 
vc varchar2(300) := '';
type ttype is table of varchar2(30);
t ttype;
begin
  n := (length(v) - length(replace(v, ',', '')) + 1);
  select data_type bulk collect into t from user_tab_cols where table_name = 'EMP';
  for i in 1..n loop
    if t(i) = 'DATE' then
      tmp := regexp_substr(v, '[^,]+', 1, i);
      --substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || 'to_date(''' || tmp || ''', ''yyyymmdd'')' || ',';
          else
   /* if i = 1 then
      tmp := regexp_substr(v, [^,]+, 1, i);
      --substr(v, 1, instr(v, ',', 1, 1)-1);
      dbms_output.put_line(tmp);
      vc := vc || '''' || tmp || '''' || ',';*/
      if i = n then
        tmp := regexp_substr(v, '[^,]+', 1, i);
        --substr(v, instr(v, ',', 1, i-1)+1);
        --dbms_output.put_line(tmp);
        vc := vc || tmp;   
        else
          tmp := regexp_substr(v, '[^,]+', 1, i);
          --substr(v, instr(v, ',', 1, i-1)+1, instr(v, ',', 1, i) - instr(v, ',', 1, i-1) - 1);
          --dbms_output.put_line(tmp);
          vc := vc || '''' || tmp || '''' || ',';
          end if;   
          end if;
    end loop;
    v_sql := 'insert into emp values('||vc||')';
    --dbms_output.put_line(vc);
    --dbms_output.put_line(v_sql);
    execute immediate v_sql;
    /*for m in (select * from emp) loop
    dbms_output.put_line(m.empno || ',' || m.ename);
    end loop;*/
    --rollback;
    end;

declare
v varchar2(300) := '1111,takami,worker,222,19951109,500,50,10';
begin
  p02(v);
  end;
--����·��
grant create any directory to scott;  
create or replace directory d01 as 'E:\data';
--�ļ�д��
declare
n number := 1111;
v varchar2 (300) := ',takami,worker,222,19951109,500,50,10';
vc varchar2(300);
f utl_file.file_type;
begin
  f := utl_file.fopen('D01', 'test.txt', 'w');
  /*v := to_char(n) || v;
  dbms_output.put_line(v);
  utl_file.put_line(f,v);*/
  for i in 1..8 loop
    vc := to_char(n) || v;
    n := n + 1111;
    utl_file.put_line(f,vc);
    end loop;
  utl_file.fclose(f);
  end;
--�ļ�����  
declare
f utl_file.file_type;
v varchar2(300);
begin
  f := utl_file.fopen('D01', 'test.txt', 'r');
  begin
  loop
    utl_file.get_line(f, v);
    p02(v);
    end loop;
    exception 
      when no_data_found then
        null;
        end;
  utl_file.fclose(f);
  
  for i in (select * from emp) loop
  dbms_output.put_line(i.empno);
  end loop;
  rollback;
  end;

3.дһ���洢���̣���������Ĳ���,�޸�Ա����Ϣ��
 ע�����ֻ����Ա����������ô��ֻ�޸�����
     ���������ֵ�����޸�Ա���Ķ����Ϣ
     ���磺����Ա�������������������ʣ���Ҫ��
     ��������������������Ϣ���޸�
     create or replace procedure p03 (v emp%rowtype)
     is
     begin
       update emp set ename = nvl(v.ename, ename), job = nvl(v.job, job), sal = nvl(v.sal, sal) where empno = v.empno;
       end;
------------------------------------------------------------------     
       declare
       v emp%rowtype;
       begin
         v.empno := &empno;
         v.ename := '&ename';
         v.job := '&job';
         v.mgr := &mgr;
         v.hiredate := &hiredate;
         v.sal := &sal;
         v.comm := &comm;
         v.deptno := &deptno;
         p03(v);
         end;
         select * from emp;
         
4.���ҳ���ǰ�û�ģʽ�£�ÿ�ű�ļ�¼������scott�û�Ϊ�������Ӧ���£�
DEPT...................................4
EMP...................................14
BONUS.................................0
SALGRADE.............................5
��ʾ�������û������б�����sqlΪselect table_name from user_tables;
  create or replace procedure p04
  is
  begin
    for i in (select * from user_tables) loop
      dbms_output.put_line(i.table_name || rpad('.', 50, '.') || nvl(i.num_rows,0));
      end loop;
      end;

call p04();
  -- ��num_rows(oracle���ڸ��£�ʱЧ�Բ�)��  
---------------------------------------------------------------------------- 
  -- ��ƴ��sql����
  create or replace procedure p04
  is
  v_sql varchar2(300):= 'select count(1) from ';
  n number;
  begin
    for v in (select table_name from user_tables ) loop
      execute immediate concat(v_sql, v.table_name) into n;
       dbms_output.put_line(v.table_name || rpad('.', 50, '.') || n);
     end loop;
     end;
------------------------------------------------------   
call p04();
     
5.ĳcc���������£�
c1 c2
--------------
1 ��
1 ��
1 ��
2 ��
2 ��
3 ��
����
ת��Ϊ
1 ������
2 ����
3 ��
Ҫ�󣺲��ܸı��ṹ����������
create table cc(
c1 number(2),
c2 varchar2(20));
insert into cc values (1, '��');
insert into cc values (1, '��');
insert into cc values (1, '��');
insert into cc values (2, '��');
insert into cc values (2, '��');
insert into cc values (3, '��');
commit;
select * from cc; 
----------------------------------------------------
create or replace procedure p05 
is
cursor cur1 is select c1 from cc group by c1;
cursor cur2(n number) is select * from cc where c1 = n;
begin
  for v in cur1 loop
    dbms_output.put(v.c1 || ' ');
    for m in cur2(v.c1) loop
      dbms_output.put(m.c2);
      end loop;
      dbms_output.new_line();
      end loop;
      end;
-----------------------------------------------------     
call p05();

6.����һ�����̣�����dept�������һ���¼�¼.��in������
create or replace procedure p06(d in dept%rowtype)
is
begin
  insert into dept values(d.deptno, d.dname, d.loc);
  end;
  
  declare
  d dept%rowtype;
  begin
  d.deptno := &deptno;
  d.dname := '&dname';
  d.loc := '&loc';
  p06(d);
  rollback;
  end;
  
7.����һ�����̣���emp���д����Ա�����������ظù�Ա��нˮֵ����out������
create or replace procedure p07 (v_ename in varchar2, v_sal out number)
is
begin
  select sal into v_sal from (select * from emp where ename = v_ename) where rownum = 1;
  end;
---------------------------------------------------------------------------------------------- 
  declare
  v_e varchar2(20):= 'SMITH';
  v_s number;
  begin
    p07(v_e, v_s);
    dbms_output.put_line(v_s);
    end;
    
8.
������Ա��,�����Ա��ְλ��MANAGER��������DALLAS������ô�͸���н���15����
�����Ա��ְλ��CLERK��������NEW YORK������ô�͸���н��۳�5��;���������������
������Ա��,�����Ա��������SALES�����ҹ�������1500��ô�͸���н���15����
�����Ա��������RESEARCH������ְλ��CLERK��ô�͸���н������5��;��������������� 
select * from emp;
select * from dept;
---------------------------------------------------
create or replace procedure p08
is
cursor cur is select e.empno, e.job, e.sal, d.dname, d.loc  from emp e, dept d where e.deptno = d.deptno;
begin
  for v in cur loop
    if v.job = 'MANAGER' and v.loc = 'DALLAS' then
      v.sal := v.sal * 1.15;
      elsif v.job = 'CLERK' and v.loc = 'NEW YORK' then
        v.sal := v.sal * 0.95;
        elsif v.dname = 'SALES' and v.sal < 1500 then
          v.sal := v.sal * 1.15;
          elsif  v.dname = 'RESEARCH' and v.job = 'CLERK'then
            v.sal := v.sal * 1.05;
            else
              null;
              end if;
              update emp set sal = v.sal where empno = v.empno;
    end loop;
  end;
------------------------------------------------------------------------------
begin
p08;
for v in (select * from emp) loop
dbms_output.put_line(v.empno|| ',' || v.sal|| ',' || v.deptno|| ',' || v.job);
end loop;
rollback;
end;

9.��ֱ���ϼ���'BLAKE'������Ա�������ղμӹ�����ʱ���н��
81��6����ǰ�ļ�н10��
81��6���Ժ�ļ�н5��
create or replace procedure p09(mgn in varchar2)
is
cursor cur(ena emp.ename%type) is select e1.empno as empno, e1.sal as sal, e1.hiredate as hiredate, e2.ename as mgrname from emp e1, emp e2 where e1.mgr = e2.empno and e2.ename = /*'BLAKE'*/ena;
begin
  for v in cur(mgn) loop
    if v.hiredate < to_date('19810601', 'yyyymmdd') then
      v.sal := v.sal * 1.1;
      else
        v.sal := v.sal * 1.05;
        end if;
        update emp set sal = v.sal where empno = v.empno;
        end loop;
  end;
-------------------------------------------------------------------------------
declare
v_mgn varchar2(10):= 'BLAKE';
cursor cur(ena emp.ename%type) is select e1.empno as empno, e1.sal as sal, e1.hiredate as hiredate, e2.ename as mgrname from emp e1, emp e2 where e1.mgr = e2.empno and e2.ename = /*'BLAKE'*/ena;
begin
  for v in cur(v_mgn) loop
    dbms_output.put_line(v.empno || ', ' || v.mgrname || ', ' || v.sal);
    end loop;
  p09(v_mgn);
    dbms_output.put_line(rpad('-', 50, '-'));
  for v in cur(v_mgn) loop
    dbms_output.put_line(v.empno || ', ' || v.mgrname || ', ' || v.hiredate || ', ' || v.sal);
    end loop;
    rollback;
    end;
    
10.��дһPL/SQL�������е�"����Ա"(SALESMAN)����Ӷ��500.
create or replace procedure p10(v_job in varchar2)
is
/*declare
v_job varchar2(30) := 'SALESMAN';*/
v_sql varchar2(300):= 'update emp set comm = nvl(comm,0) + 500 where job = :1';-- cursor cur(v_job emp.job%type) is select * from emp;
begin
  execute immediate v_sql using v_job;
  end;
----------------------------------------------------------------------------------  
declare
v_job varchar2(30):= 'SALESMAN';
begin
  for v in (select * from emp where job = v_job) loop
    dbms_output.put_line(v.empno || ', ' || v.job || ', ' || v.comm);
    end loop;
  p10(v_job);
  dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from emp where job = v_job) loop
    dbms_output.put_line(v.empno || ', ' || v.job || ', ' || v.comm);
    end loop;
    rollback;
    end; 
  
11.��дһ��PL/SQL����飬��������"A"��"S"��ʼ�����й�Ա�����ǵĻ���нˮ��10%��н��
create or replace procedure p11(n in varchar2)
is
v_sql varchar2(300) := 'update emp set sal = sal * 1.1 where instr(ename, :1) = 1';
begin
  execute immediate v_sql using n;
  end;
 -------------------------------------------------------------------------- 
begin
  for v in (select * from emp where ename like 'A%' or ename like 'S%') loop
    dbms_output.put_line(v.ename || ', ' || v.sal);
    end loop;
    p11('A');
    p11('S');
    dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from emp where ename like 'A%' or ename like 'S%') loop
    dbms_output.put_line(v.ename || ', ' || v.sal);
    end loop;
    rollback;
    end;  
  
12.��дһPL/SQL�������������ʸ����ϵ�"ְԱ"Ϊ"�߼�ְԱ"��������ʱ��Խ�������ȼ�Խ�ߣ�
alter table emp modify job varchar2(30);
------------------------------------------------------------------
create or replace procedure p12
is
v emp%rowtype;
cursor cur is select * from emp where job = 'CLERK' order by hiredate asc;
begin
  open cur;
  loop
    fetch cur into v;
    update emp set job = 'SENIOR_CLERK' where empno = v.empno;
    exit when cur%rowcount = 2;
    end loop;
    close cur;
  end;
-------------------------------------------------------------
begin 
  for v in (select * from emp where job = 'CLERK') loop
    dbms_output.put_line(v.empno || ', ' || v.ename || ', ' || v.job || ', ' || v.hiredate);
    end loop;
    p12;
    dbms_output.put_line(rpad('-', 50, '-'));
  for v in (select * from emp where job in ('CLERK', 'SENIOR_CLERK')) loop
    dbms_output.put_line(v.empno || ', ' || v.ename || ', ' || v.job || ', ' || v.hiredate);
    end loop;
    rollback;
    end;
    
13.��ʾEMP�еĵ�������¼��
create or replace procedure p13(n in number)
is 
v emp%rowtype;
begin
  select empno, ename, job, mgr, hiredate, sal, comm, deptno into v from (select emp.*, rownum rn from emp) t where t.rn = n;
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
  end;
------------------------------------------------------------------------------------
call p13(4);

---------------------------------------

create or replace procedure p13(n in number)
is
cursor cur is select * from emp;
v emp%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    null;
    exit when cur%rowcount = 4;
    end loop;
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
  close cur;
  end;
-------------------------------------- 
  call p13(4);
14.��дһ���������Ա��н10%�Ĺ��̣���֮��
�������Ѿ���Ӷ�ù�Ա����60���£�����������н3000.
create or replace procedure p14
is
o_sal number;
cursor cur is select * from emp;
begin
  for v in cur loop
    v.sal := v.sal * 1.1;
    if months_between(sysdate, v.hiredate) > 60 then
      v.sal := v.sal +3000;
      end if;
      select sal into o_sal from emp where empno = v.empno;
      update emp set sal = v.sal where empno = v.empno;
      dbms_output.put_line(v.empno|| ', ��ְʱ��: ' || trunc(months_between(sysdate, v.hiredate),1)|| ', �¹���: ' || v.sal|| ', �ɹ���: ' || o_sal);
      end loop;
      rollback;
      end; 
---------------------------------------------------------------
call p14();      


