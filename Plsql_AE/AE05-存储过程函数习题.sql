1.дһ���洢���̣�����Ա����Ϣ����emp���в���һ��Ա����Ϣ

create or replace procedure p1(v in emp%rowtype)
is
begin
  insert into emp values (v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno);
  end;
  
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

create or replace procedure p2(v in varchar2) is
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
----------------------------------------
declare
m varchar2(300);
begin
  m := '1111,takami,worker,222,19951109,500,50,10';
  p2(m);
  end;
----------------------------------------
call p2(&v);  
select * from emp;

  
3.дһ���洢���̣���������Ĳ���,�޸�Ա����Ϣ��
 ע�����ֻ����Ա����������ô��ֻ�޸�����
     ���������ֵ�����޸�Ա���Ķ����Ϣ
     ���磺����Ա�������������������ʣ���Ҫ��
     ��������������������Ϣ���޸�
     create or replace procedure p3 (v emp%rowtype)
     is
     begin
       update emp set ename = nvl(v.ename, ename), job = nvl(v.job, job), sal = nvl(v.sal, sal) where empno = v.empno;
       end;
       
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
         p3(v);
         end;
         select * from emp;
         
4.���ҳ���ǰ�û�ģʽ�£�ÿ�ű�ļ�¼������scott�û�Ϊ�������Ӧ���£�
DEPT...................................4
EMP...................................14
BONUS.................................0
SALGRADE.............................5
��ʾ�������û������б�����sqlΪselect table_name from user_tables;

/*create table ttt as select * from emp where 1=0;
select * from emp;
create or replace procedure p4 is
begin
  for i in (select ut.table_name tn, count(*) c
              from user_tables ut, user_tab_cols ut_c
             where ut.TABLE_NAME(+) = ut_c.TABLE_NAME
             group by ut.TABLE_NAME) loop
    -- select table_name tn, count(*) c from user_tables ut, user_tab_cols ut_c where ut.TABLE_NAME(+) = ut_c.TABLE_NAME  group by ut.TABLE_NAME;
    dbms_output.put_line(i.tn || rpad('.', 50, '.') || i.c);
  end loop;
  end; 
  call p4();*/
  
  create or replace procedure p4
  is
  begin
    for i in (select * from user_tables) loop
      dbms_output.put_line(i.table_name || rpad('.', 50, '.') || nvl(i.num_rows,0));
      end loop;
      end;
    call p4();
    
   /* for i in (select table_name from user_tables ) loop
      for n in (select count(1) from table(i.table_name)) loop
      --dbms_output.put_line(i.table_name);
     --select count(*) into n from i.table_name;
       dbms_output.put_line(i.table_name || rpad('.', 50, '.') || n);
       end loop;
     end loop;
     end;*/
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
select * from cc for update;

declare
cursor cur is select * from 
    
6.����һ�����̣�����dept�������һ���¼�¼.��in������
create or replace procedure p6(d in dept%rowtype)
is
begin
  insert into dept values()
  d.deptno := &deptno;
  d.dname := '&dname';
  d.loc := '&loc';
  end
7.����һ�����̣���emp���д����Ա�����������ظù�Ա��нˮֵ����out������
8.������Ա��,�����Ա��ְλ��MANAGER��������DALLAS������ô�͸���н���15���������Ա��ְλ��CLERK��������NEW YORK������ô�͸���н��۳�5��;���������������
������Ա��,�����Ա��������SALES�����ҹ�������1500��ô�͸���н���15���������Ա��������RESEARCH������ְλ��CLERK��ô�͸���н������5��;��������������� 
9.��ֱ���ϼ���'BLAKE'������Ա�������ղμӹ�����ʱ���н��
81��6����ǰ�ļ�н10��
81��6���Ժ�ļ�н5��
10.��дһPL/SQL�������е�"����Ա"(SALESMAN)����Ӷ��500.
11.��дһ��PL/SQL����飬��������"A"��"S"��ʼ�����й�Ա�����ǵĻ���нˮ��10%��н��
12.��дһPL/SQL�������������ʸ����ϵ�"ְԱ"Ϊ"�߼�ְԱ"��������ʱ��Խ�������ȼ�Խ�ߣ�

13.��ʾEMP�еĵ�������¼��
create or replace procedure p13(n in number)
is 
v emp%rowtype;
--v_sql varchar2(300) := 'select * from (select emp.*, rownum rn from emp) t where t.rn = n'; 
begin
  select empno, ename, job, mgr, hiredate, sal, comm, deptno into v from (select emp.*, rownum rn from emp) t where t.rn = n;
  dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.mgr|| ', ' || v.hiredate|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.deptno);
  end;
 
call p13(4);
    
14.��дһ���������Ա��н10%�Ĺ��̣���֮�󣬼������Ѿ���Ӷ�ù�Ա����60���£�����������н3000.
create or replace procedure p1
is
begin
  
