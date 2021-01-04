1.дһ��plsql����飬����һ�����ű�ţ���ѯ���ò����¹�����ߵ�Ա����Ϣ����ӡ

declare 
dno number := &deptno;
v emp%rowtype;
begin
select * into v from (select * from emp where deptno = dno order by sal desc) where rownum = 1;
dbms_output.put_line(v.empno || ',' || v.ename || ',' || v.job || ',' || v.deptno);
end;

2.дһ������飬��ѯ��ƽ��������ߵ�Ա�����еĲ�����Ϣ������ӡ���

declare
dno number;
v dept%rowtype;
begin
  select * into dno from (select deptno from emp group by deptno order by avg(sal) desc) where rownum = 1;
  select * into v from dept where deptno = dno;
--select * into v from (select * from dept where deptno in (select deptno from emp group by deptno order by avg(sal) desc)) where rownum = 1);
dbms_output.put_line(v.deptno || ',' || v.dname || ',' || v.loc);
end;

3.дһ������飬����һ������ֵ��������Ա����н
declare 
v_sal number:= &bonus;
begin
  update emp set sal = sal + v_sal;
  end;

select * from emp;
rollback;
  
4.дһ������飬����һ�����ű�ţ���ѯ�ò����µ�ƽ�����ʣ��ܹ��ʣ���߹��ʣ�����͹��ʣ�����ӡ

declare 
dno emp.deptno%type := &dno;
v_avg number;
v_sum number;
v_max number;
v_min number;
begin
select avg(sal), sum(sal), max(sal), min(sal) into v_avg, v_sum, v_max, v_min from emp where deptno = dno; 
dbms_output.put_line(v_avg || ',' ||  v_sum || ',' ||  v_max || ',' ||  v_min);
end;

5.дһ������飬����һ���������ƣ���ѯ�ò����£��������ϵ�Ա����Ϣ����ӡ

select * from dept;
select * from emp;

declare
dna dept.dname%type := '&dname';
v emp%rowtype;
begin
select * into v from (select e.* from emp e join dept d on e.deptno = d.deptno where d.dname = dna order by e.hiredate asc) where rownum = 1;
dbms_output.put_line(v.ename || ',' || v.empno || ',' || v.deptno);
end;

6.дһ������飬����һ��Աʽ��ţ���ѯ��Ա���µĹ��ʵȼ�
commit;
select table_name from user_tables;
select * from salgrade;

declare 
eno emp.empno%type := &eno;
v number(1);
begin
select grade into v from (select * from emp e join salgrade s on e.sal between s.losal and s.hisal) where empno = eno;
dbms_output.put_line(v);
end;

7.дһ������飬����һ��dept_sum�����ܲ����µ�������ƽ�����ʣ��ܹ��ʣ���߹��ʣ���͹���

declare
n number;
v_sql varchar2(300):= 'insert into dept_sum select deptno, count(1), avg(sal), sum(sal), max(sal), min(sal) from emp group by deptno';
--v dept_sum%rowtype;
begin
  select count(1) into n from user_tables where table_name = 'dept_sum';
  if n = 0 then
    execute immediate 'create table dept_sum(deptno number, members number, avg_sal number, sum_sal number, max_sal number, min_sal number)';
    end if;
    execute immediate v_sql;
    --select * into v from dept_sum;
    --dbms_output.put_line(v.deptno || ', ' || v.member || ', ' || v.avg_sal);
    end;
      select * from dept_sum;


8.дһ������飬����һ�����ű�ţ�ɾ�������µĹ��ʵ��ڸò���ƽ�����ʵ�Ա��

declare
  dno   number(2) := &dno;
  v_sql varchar2(300) := 'delete from (select * from emp where deptno = :1 and sal < (select avg(sal) from emp where deptno = :2)) where rownum = 1';
begin
  execute immediate v_sql
    using dno, dno;
end;
rollback;

9.дһ������飬����һ��emp��ı��ݱ����г�����emp��������֮�⣬����Ҫ���汸��ʱ��
  ����Ա����� || ',' || Ա��ְλ��Ա�����ʣ�Ա����Ӷ�𣬲��ű�ţ�����Ա������޸�Ա������Ϣ��
  ���޸���Ϣǰ����ԭ����Ա����Ϣ���浽���ݱ���

