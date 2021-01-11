1.дһ��plsql����飬����һ�����ű�ţ���ѯ���ò����¹�����ߵ�Ա����Ϣ����ӡ
select into 
execute immediate into 
%rowtype

select * from (select * from emp where deptno=10 order by sal desc) where rownum=1;

select * from emp where deptno=10 and sal = (select max(sal) from emp where deptno=10) and rownum=1;

declare
  --����һ����������һ��Ա������Ϣ
  v emp%rowtype;
  --����һ���������沿�ű��
  dno emp.deptno%type:=&���ű��;
begin
  --select into ����ѯ
  select * into v from (select * from emp where deptno=dno order by sal desc) where rownum=1;
  --��ӡ
  dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
end;

declare
   --����һ����������һ��Ա����Ϣ
   v emp%rowtype;
   --����һ����������sql���
   v_sql varchar2(300);

begin
   v_sql:='select * from (select * from emp where deptno=:1 order by sal desc) where rownum=1';
   --ʹ��execute immediateִ��
   execute immediate v_sql into v using &���ű��;
   dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
end;

2.дһ������飬��ѯ��ƽ��������ߵĵĲ�����Ϣ������ӡ���
1��.�Ȳ�ѯ��ƽ��������ߵĲ��ű��
select deptno from (select deptno,avg(sal) from emp group by deptno order by 2 desc) where rownum=1;
2��.���ݲ��ű�ţ���ѯ�����ŵ���Ϣ
select * from dept where deptno=?

declare
  --����һ���������沿�ű��
  dno emp.deptno%type;
  --����һ����������dept���е�һ����¼
  v dept%rowtype;
begin
  --��ѯƽ��������ߵĲ��ű��
  select deptno into dno from (select deptno,avg(sal) from emp group by deptno order by 2 desc) where rownum=1;
  --��ӡ���ű��
  dbms_output.put_line(dno);
  --���ݲ��ű�ţ�ȥdept���в�ѯ�ò��ŵĲ�����Ϣ
  select * into v from dept where deptno=dno;
  --��ӡ������Ϣ
  dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
end;

select t2.deptno, t2.dname, t2.loc
  from (select deptno, avg(sal) from emp group by deptno order by 2 desc) t1
  join dept t2
    on t1.deptno = t2.deptno
 where rownum = 1;

declare
   --����һ����������һ��������Ϣ
   v dept%rowtype;
begin
   select t2.deptno,t2.dname,t2.loc into v from (select deptno,avg(sal) from emp group by deptno order by 2 desc) t1 join dept t2 on t1.deptno=t2.deptno where rownum=1;
    --��ӡ������Ϣ
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
end;
3.дһ������飬����һ������ֵ��������Ա����н
begin
  update emp set sal=sal+&����;
end;
declare
   s number=&����;
begin
  update emp set sal=sal+s;
end;

select * from emp;
4.дһ������飬����һ�����ű�ţ���ѯ�ò����µ�ƽ�����ʣ��ܹ��ʣ���߹��ʣ�����͹��ʣ�����ӡ
select avg(sal),sum(sal),max(sal),min(sal) from emp where deptno=10;

declare
  --����һ���������沿�ű��
  dno number:=&���ű��;
  --�����ĸ������ֱ𱣴沿�ŵ�ƽ�����ʣ��ܹ��ʣ���߹��ʣ���͹���
  v1 number(6,2);
  v2 number(6,2);
  v3 number(6,2);
  v4 number(6,2);
begin
  select avg(sal),sum(sal),max(sal),min(sal) into v1,v2,v3,v4 from emp where deptno=dno;
  dbms_output.put_line(dno||'���ţ�ƽ������:'||v1||',�ܹ��ʣ�'||v2||',��߹���:'||v3||',��͹��ʣ�'||v4);
  
end;

5.дһ������飬����һ���������ƣ���ѯ�ò����£��������ϵ�Ա����Ϣ����ӡ
1)���ݲ������Ʋ�ѯ�����ű��
select deptno from dept where dname='';
2)���ݲ�ѯ���Ĳ��ű�ţ�ȥemp���в�ѯ�������ϵ�Ա��
select * from (select * from emp where deptno=? order by hiredate) where rownum=1
declare
   --����һ���������沿�ű��
   dno number;
   --����һ����������Ա����Ϣ
   v emp%rowtype;
begin
   --���ݲ������Ʋ�ѯ���ű�� 
   select deptno into dno from dept where dname='&��������';
   dbms_output.put_line(dno);
   --���ݲ��ű�Ų�ѯ���ò������������ϵ�Ա��
   select * into v from (select * from emp where deptno=dno order by hiredate) where rownum=1;
   --��ӡ��ѯ���
   dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
end;
select * from dept;
6.дһ������飬����һ��Ա����ţ���ѯ��Ա���Ĺ��ʵȼ�
select grade from emp join salgrade on sal between losal and hisal where empno=7369; 
declare
  --����һ����������Ա���Ĺ��ʵȼ�
  n number(1);
begin
  --��ѯ���ʵȼ�
  select grade into n from emp join salgrade on sal between losal and hisal where empno=&Ա�����;
  --��ӡ���
  dbms_output.put_line('���ʵȼ�:'||n);
end;
7.дһ������飬����һ��dept_sum�����ܲ����µ�������ƽ�����ʣ��ܹ��ʣ���߹��ʣ���͹���
���ű�� deptno number(4)
�������� total  number(5)
ƽ������ avg_sal number(8,2)
�ܹ���   sum_sal number(8,2)
��߹��� max_sal number(8,2)
��͹��� min_sal number(8,2)
create table dept_num(
   deptno number(4),
   total  number(5),
   avg_sal number(8,2),
   sum_sal number(8,2),
   max_sal number(8,2),
   min_sal number(8,2),
   dt date
)

insert into dept_num select deptno,count(1),avg(sal),sum(sal),max(sal),min(sal),sysdate from emp group by deptno;
--����ֻ������һ��,ִ��ǰ��Ҫִ��drop table dept_num
declare
   --����һ����������sql���
   v_sql varchar2(500);
begin
   --����sql
   v_sql:='create table dept_num(
   deptno number(4),
   total  number(5),
   avg_sal number(8,2),
   sum_sal number(8,2),
   max_sal number(8,2),
   min_sal number(8,2),
   dt date
  )';
  --execute immediate
  execute immediate v_sql;  --���Ƕ�̬�����ģ�insert���Ҳ����Ҫʹ��execute immediate���������
  --��������sql
  v_sql:='insert into dept_num select deptno,count(1),avg(sal),sum(sal),max(sal),min(sal),sysdate from emp group by deptno';
  --ʹ��execute immediate��ִ��
  execute immediate v_sql;
  --�ύ����
  commit;
end;

select * from dept_num;

8.дһ������飬����һ�����ű�ţ�ɾ�������µĹ��ʵ��ڸò���ƽ�����ʵ�Ա��
delete from emp where deptno=10 and sal<(select avg(sal) from emp where deptno=10);
declare
   --����һ��������������Ĳ��ű��
   dno number:=&���ű��;
begin
   delete from emp where deptno=dno and sal < (select avg(sal) from emp where deptno=dno);
end;
select * from emp where deptno=10;

1)��ѯ���ò��ŵ�ƽ������
select avg(sal) from emp where deptno=?
2)������������ɾ��
delete from emp where deptno=�� and sal<?;

declare
   --����һ����������������Ĳ��ű��
   dno number:=&���ű��;
   --����ò��ŵ�ƽ������
   avg_sal number(6,2);
begin
   --��ѯ���ŵ�ƽ������
   select avg(sal) into avg_sal from emp where deptno=dno;
   --ɾ��Ա����Ϣ
   delete from emp where deptno=dno and sal<avg_sal;
  
end;

declare
  
   --����ò��ŵ�ƽ������
   avg_sal number(6,2);
begin
   --��ѯ���ŵ�ƽ������
   select avg(sal) into avg_sal from emp where deptno=&���ű��;
   --ɾ��Ա����Ϣ
   delete from emp where deptno=&���ű�� and sal<avg_sal;
  
end;

9.дһ������飬����һ��emp��ı��ݱ����г�����emp��������֮�⣬����Ҫ���汸��ʱ��
  ����Ա�����,Ա��ְλ��Ա�����ʣ�Ա����Ӷ�𣬲��ű�ţ�����Ա������޸�Ա������Ϣ��
  ���޸���Ϣǰ����ԭ����Ա����Ϣ���浽���ݱ���
create table emp_bak as select emp.*,sysdate dt from emp where 1=0;

Ա�����empno    v_empno number:=&Ա�����
Ա��ְλjob      v_job varchar2(20):='&ְλ'
Ա������sal      v_sal number:=&Ա������
Ա��Ӷ��comm     v_comm number:=&Ӷ��
���ű��deptno   v_deptno number:=&���ű��
--����Ա����Ų�ѯ�����ݣ������浽��emp_bak��
insert into emp_bak select emp.*,sysdate from emp where empno=v_empno;

--�޸�Ա����Ϣ
update emp set job=v_job,sal=v_sal,comm=v_comm,deptno=v_deptno where empno=v_empno;

declare
    v_empno number:=&Ա�����;
    v_job varchar2(20):='&ְλ';
    v_sal number:=&Ա������;
    v_comm number:=&Ӷ��;
    v_deptno number:=&���ű��;
begin
   --����ԭ����
   insert into emp_bak select emp.*,sysdate from emp where empno=v_empno;
   --�޸�����
   update emp set job=nvl(v_job,job),sal=nvl(v_sal,sal),comm=nvl(v_comm,comm),deptno=nvl(v_deptno,deptno) where empno=v_empno;
end;

select * from emp_bak;

select * from emp;
