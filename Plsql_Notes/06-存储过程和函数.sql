�洢����
�洢���̣�����һ�������ֵ�PLSQL����飬����ʵ��ĳ��ҵ����ܡ�
   �����в�����Ҳ����û�в�����ֻ����plsql�������ʹ�ã�������sql�����ʹ��
   û�з���ֵ��������������������Ĳ������������ͣ������������������������������
   
�洢���̵Ĵ����﷨��
create [or replace] procedure �洢������[(���� in|out|in out ��������������[:=Ĭ��ֵ],...)]
is
   --��������
begin
   --�����
   --�쳣�������
end;

procedure:�洢���̹ؼ���
�洢������:��Ҫ���ϱ�ʶ�������淶
in|out|in out:�ֱ��ʾ����|���|�������

create or replace procedure p1
is
begin
   dbms_output.put_line('Hello PLSQL');
end;

�洢���̵ĵ��÷�����
1.�ڴ�����е���
begin
   �洢������[(����)];
end;

begin
  p1;
end;
begin
  p1();
end;
2.ʹ��call��sql����������
call �洢������([����]);

call p1();

3.ʹ��exec(sqlplus����)�������
exec �洢������([����]);

exec p1();

(1)in����
in��������������ڳ�������޸ģ����������ⷽʽֵ�Σ�3�ִ��η�ʽ�����ԣ�,���ؼ��ֿ���ʡ�Բ�д

--дһ���洢���̣�����һ�����ű�ţ����ݲ��ű�Ų�ѯ�����µ�Ա��������ӡԱ����Ϣ
create or replace procedure p2(dno in number)
is
begin
   for v in (select * from emp where deptno=dno) loop
      --��ӡԱ����Ϣ
      dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   end loop;
end;

begin
  p2(10); 
end;

declare
   --����һ���������沿�ű��
   d number:=20;
begin
   p2(d);
end;

begin
   p2(dno=>30);
end;

create or replace procedure p2(dno in number)
is
begin
   --�޸�dno��ֵ
   ---dno:=20;  in ���Ͳ����������޸�
   for v in (select * from emp where deptno=dno) loop
      --��ӡԱ����Ϣ
      dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   end loop;
end;

create or replace procedure p2(dno number)
is
begin
   --�޸�dno��ֵ
   ---dno:=20;  in ���Ͳ����������޸�
   for v in (select * from emp where deptno=dno) loop
      --��ӡԱ����Ϣ
      dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   end loop;
end;

(2)out����
out�������������ֵ�ڳ����п����޸ģ������Դ������ķ�ʽ���Σ�����������н�����ⲿ����ʹ��

--дһ���洢���̣����ݴ��벿�ű�ţ����ݲ��ű�Ų�ѯ��Ա��������
create or replace procedure p3(dno number,n out number) --dno��һ���������   n��ʾһ���������
is

begin
   select count(*) into n from emp where deptno=dno;
end;

declare
  --����һ����������Ա������
  s number;
begin
  p3(20,s);   --out���������ݴ��ⲿ���ó���
  --��ӡs��ֵ
  dbms_output.put_line(s);
end;

��3��in out����
in out������������������in��out�������ص㣬�ڳ����п����޸�����ֵ������ʱֻ���Ա����ķ�ʽ����

--дһ���洢���̣�����Ա����ţ���ѯԱ����Ϣ������Ա����Ϣ�������ⲿ����
create or replace procedure p4(eno in number,v out emp%rowtype)
is
begin
  select * into v from emp where empno=eno;
end;
select * from emp;
declare
   --����һ����¼���ͱ���
   e emp%rowtype;
begin
   p4(7499,e);
   --��ӡԱ����Ϣ
   dbms_output.put_line(e.empno||','||e.ename||','||e.job||','||e.mgr||','||e.sal||','||e.deptno);
end;


create or replace procedure p4(v in out emp%rowtype)
is
begin
   select * into v from emp where empno=v.empno;
end;

declare
   e emp%rowtype;
begin
   e.empno:=7369;
   p4(e);
    --��ӡԱ����Ϣ
   dbms_output.put_line(e.empno||','||e.ename||','||e.job||','||e.mgr||','||e.sal||','||e.deptno);
end;

in����������һ�����ɱ����ݣ�����ʱ����Ҫ��ֵ��ֵ�ڴ����б�ʹ�õ��������������壩
out����������һ���ձ�����û������
in out����������һ�������������������ݣ����ݱ�ʹ�õ�


--дһ���洢���̣����ݲ��ű�Ų�ѯ�����µ�����
create or replace procedure p5(n in out number)
is
begin
   select count(*) into n from emp where deptno=n;
end;

declare
  dno number:=20;
begin
  p5(dno);
  dbms_output.put_line(dno);
end;

create or replace procedure p6(n in out number )
is

begin
  select count(*) into n from emp where deptno=n;
  
end;
