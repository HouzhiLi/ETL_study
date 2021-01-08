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

2.����
��������һ�������ֵ�plsql����飬����ʵ����ѧ������ܵ�.���з���ֵ����ʹ��ʱ
����ʹ�õ�����ֵ������������in,out,in out,������sql�����ʹ�ã���������plsql�������ʹ��

�����Ķ����﷨��
create [or replace] function ������(���� in|out|in out ��������[:=Ĭ��ֵ])
return ����ֵ����
is
   --��������
begin
   --�����
   return���;
   --�쳣����
end;

--����һ��������������εĳ��Ϳ�������ε����
create or replace function fn1(w in number,h number)
return number
is
   --����һ������������ε����
   s number;
begin
   s:=w*h;
   --���ؽ��
   return s;
end;

�����ĵ��ã�����ʹ�õ�����ֵ����
��1����sql�е���
select fn1(3,4) from dual;

(2)��plsql�е��ã�����ʹ�÷���ֵ��
declare
  --����һ������
  s number;
begin
  s:=fn1(3,4);
  dbms_output.put_line(s);
end;

begin
  dbms_output.put_line(fn1(3,4));
end;

begin
  if fn1(3,4)>10 then
    dbms_output.put_line('���ε��������10');
  end if;
end;


--дһ������������һ��Ա����ţ����Ա���Ĺ���С��2000,��ô��Ա����н500����������1;
--  ���Ա�����ʴ��ڵ���2000����������н ��������0

--����1��0
״ֵ̬��
--1��ʾ��Ա����н��
--0��ʾû�м�н

--ִ��update���
create or replace function fn2(eno number)
return number
is
   --����һ����������Ա���Ĺ���
   v_sal number;
begin
   select sal into v_sal from emp where empno=eno;
   --�жϹ����Ƿ�С��2000
   if v_sal<2000 then
      --�������С��2000������н500
      update emp set sal=sal+500 where empno=eno;
      return 1;
   else
      --���ʴ���2000,����н������0
      return 0;
   end if;
end;
--selec����е��õĺ�������ʹ��dml����
begin
   if fn2(7566)=1 then
      dbms_output.put_line('��н');
   else
      dbms_output.put_line('δ��н');
   end if;
end;



select * from emp;


--�����ĵݹ���ã����ѵ������ѣ�
--дһ������������һ�����Ľ׳� 
create or replace function fn3(n number)
return number
is
   --����һ����������׳˽��
   s number:=1;
begin
   for i in 1..n loop
     s:=s*i;
   end loop;
   return s;
end;
select fn3(5) from dual;

create or replace function fn4(n number)
return number
is
begin
  /***
    fn4(5) n=5
     1    n=5     n<=2������   n*fn4(n-1)=5*fn4(4)=5*4*fn4(3)=5*4*3*fn4(2)=5*4*3*2
            fn4(4)   n=4     n<=2������  n*fn4(n-1)=4*fn4(3) =4*3*fn4(2)=4*3*2 
            fn4(3)   n=3     .........   n*fn4(n-1)=3*fn4(2)=3*2
            fn4(2)   n=2     ��������   ���� n  2
     
  
  */
  if n<=2 then
    --���nС�ڵ���2ʱ���׳˵���n����
    return n;
  else
    return n*fn4(n-1);
  end if;
end;

�ݹ���ã�������һ���ٽ���������ǰ��������ʱ������һ���̶���ֵ
          ����������±�����һ������
 

select fn4(6) from dual;
