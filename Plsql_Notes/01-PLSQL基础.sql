PLSQL�����ṹ��
declare
  ��������
begin
  �����
  exception
    �쳣�������
end;
�������֣��Ա���,����,���ͣ��α�ȵĶ��������
����飺sql��䣬�Լ����̿������
exception:�쳣��������

begin
  dbms_output.put_line('Hello World');  --dbms_output.put_line()������
end;

�������������ͱ���һ�����ݣ������ǵ�����ֵ��Ҳ�����Ǹ��ӵ�ֵ��
������ �������� [:= ��ʼֵ];

":=":��plsql��������Ǹ�ֵ����

��ʶ�������ݿ��д�������ʱ���Ķ�����
    1.����ʹ��oracle�еĹؼ��֣����Ҫ��һ���ؼ���ʱ������ʹ��˫���Ž��ؼ���������
    2.���Ȳ��ܳ���30��Ӣ���ַ��ĳ���
    3.һ������ĸ��ͷ�����԰������֣��»��ߵ������ַ���_,$,#��,���������ֿ�ͷ
declare
   --����һ���������͵ı���
   n number(3):=10;
begin
   dbms_output.put_line(n);
   
   n:=20;  --������nֵ��Ϊ20
   
   dbms_output.put_line(n);
end;

����������Ҳ�������������ݵģ�������ֻ����һ�����ݣ����Ҳ����޸ģ�������ʱ���븳����ֵ
�����������﷨��
������ constant ��������:=����ֵ;
declare
   --����һ������,����Բ����
   pi constant number(5,4):=3.1415;
begin
   dbms_output.put_line(pi*power(2,2));
   
   --pi:=3.4;�����ǲ������޸ĵ�
end;

plsql������е��������ͣ�
 1.�������ͣ�
     number(l,s):l��ʾ���ȣ�s��ʾ���ȣ��38������
     integer:��������
     pls_integer/binary_integer:ֻ�������
     
     float(�����ͣ�С������),int
     
 2.�ַ������ͣ�
     varchar2(����):�䳤�ַ�������
     char(����):�����ַ�������
     
     long
     
     rowid:Ϊ�˴����ݿ���α��rowid�е�ֵʱʹ��
     
     select emp.*,rowid from emp;
 3.��������
    date:
    timestamp:
 4.��������
   boolean:��������ֻ����ֵ��true,false,null
   
 5.��¼���ͣ�
 record
 ��¼���͵Ķ����﷨��
 type ������ is record(
   ������ �������� [default Ĭ��ֵ] [NOT NULL],
   ������ �������� ...,
   ...
   ������ ��������
 );
 ��������
 ������ ����;
 ��¼���͵�ʹ�ã�
 ������.������  --��ȡ��¼�����е�����ֵ
 ������.������:=ֵ;
 
 declare
   --����һ����¼����
   type rtype is record(
      name varchar2(30),
      age number(3),
      sex varchar2(3)
   );
   --������¼���ͱ���
   v rtype;
 begin
   v.name:='smith';
   v.age:=18;
   v.sex:='��';
   --��ӡ��¼���͵�ֵ
   dbms_output.put_line(v.name||','||v.age||','||v.sex);
 end;
 declare
    --����һ����¼����
    type rtype is record(
       empno number(5),
       ename varchar2(12),
       job varchar2(20),
       mgr number(5),
       hiredate date,
       sal number(7,2),
       comm number(7,2),
       deptno number(5)
    );
    
    --����һ������
    v rtype;
 begin
    --ʹ��select into������¼���͸�ֵ select ����,... into ���� from ���� where ������
    select * into v from emp where empno=7369;
    --��ӡ����ֵ
    dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
 end;
 6.%type����
 ����%type:��ʾȡ�������������
 emp.ename%type :��ʾȡ��emp��ename�е��������� �൱��varchar2(10)
 ������%type ����ʾȡһ����������������
 declare
    --����һ�������������ͺ�emp����job�е�������ͬ
    v_job emp.job%type;  -- v_job varchar2(9);
    
    v v_job%type;  --��ʾ����һ������v���������ͺͱ���v_job��������ͬ  varchar2(9)
 begin
    v_job:='CLERK';
    
    v:='Smith';
    dbms_output.put_line(v_job);
    dbms_output.put_line(v);
 end;
 
 7.��������%rowtype����
 %rowtype���ͣ��Ǽ�¼���ͺ�%type���͵Ľ��
 ����%rowtype
 emp%rowtype
 type rtype is record(
   empno emp.empno%type,
   ename emp.ename%type,
   job emp.job%type, 
   mgr emp.mgr%type,
   hiredate emp.hiredate%type,
   sal emp.sal%type,
   comm emp.comm%type,
   deptno emp.deptno%type
 );
 
 
 declare
    --����һ��emp%rowtype���͵ı���
    v emp%rowtype;
 begin
    --��ѯһ��Ա����Ϣ������Ա����Ϣ���浽����v��
    select * into v from emp where empno=7499;
    --��ӡ����v��ֵ��v��һ����¼����
    dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
 end;
 
 �α�%rowtype;
 
 8.�α����ͣ��쳣���ͣ��������ͣ��ļ����͵�     
 
 
 ��PLSQL�������ִ��SQL��䣺
 
 1.ֱ����plsql�������ִ��
 ��1��insert,update,delete dml�����(������select)����ֱ����plsql�����������
  begin
    update emp set sal=sal+500;
    
    insert into emp(empno,ename,job,sal,deptno) values(7999,'scott','CLERK',1234,10);
    
    delete from emp where sal<1000;
  end;
  ��plsql�����������dml���ʱ������ʹ��plsql������еı�����Ϊsql��������
  
  declare
     --����һ������
     dno number(4):=50;
     --����һ������
     v_dname varchar2(30):='dept1';
     --����һ������
     v_loc varchar2(30):='loc1';
     
     --����һ����������һ��ֵ
     n number:=300;
  begin
     --insert into dept values(50,'dept1','loc1');
     insert into dept values(dno,v_dname,v_loc);
     
     update emp set sal=sal+n where deptno=10;
  end;
  
  declare
     --����һ����������Ա���Ĺ���
     v_job varchar2(10):='soft';
  begin
     --�޸�10��������Ա���Ĺ���
     update emp set job=v_job where deptno=10;
  end;
 select * from emp;
 
 select * from dept;
  (2)ִ��select��䣬������в���ֱ������sql���ֵ�select���
   select into�����﷨��
   select ����,����,... into ������,... from ���� where ����
   ��ʾ�����ݿ��е����ݲ�ѯ�������У�
   ע�⣺select into���ֻ�ܲ�ѯ�������ݣ����ܶ಻����
   
  --дһ��plsql����飬����һ��Ա����ţ�����Ա����Ų�ѯԱ���������͹���
  select ename,job from emp where empno=&Ա�����;
  &��oracle����ȡֵ���� ������������������ݣ�&������ ������ַ����������� '&����'
  declare
     --����һ����������Ա������
     v1 emp.ename%type;
     --����һ����������Ա���Ĺ���
     v2 emp.job%type;
  begin
     select ename,job into v1,v2 from emp where empno=&Ա�����;
     --��ӡ������ֵ
     dbms_output.put_line(v1||','||v2);
  end;
  
  declare
     --����һ����¼����
     type rtype is record(
        ename emp.ename%type,
        job emp.job%type
     );
     
     --����һ����¼���ͱ���
     v rtype;
  begin
     select ename,job into v from emp where empno=&Ա�����;
     --��ӡ���
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  
  declare
     --����һ����¼����
     type rtype is record(
        ename emp.ename%type,
        job emp.job%type,
        sal emp.sal%type
     );
     
     --����һ����¼���ͱ���
     v rtype;
  begin
     --����¼�����е����ԱȲ�ѯ������ж�����ٵ�ʱ��into���治��ֱ��д��¼���ͱ�����
     --select ename,job into v from emp where empno=&Ա�����;
     select ename,job into v.ename,v.job from emp where empno=&Ա�����;
     --��ӡ���
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  declare
     --����һ��rowtype����
     v emp%rowtype;
  begin
     select ename,job into v.ename,v.job from emp where empno=&Ա�����;
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  declare
     --����һ��rowtype���ͱ���
     v emp%rowtype;
  begin
     select * into v from emp where empno=&Ա�����;
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  --�ۺϺ���
  select count(*) from emp where 1=0; #�ж����ݿ��Ƿ����ĳЩ����
  ��3��returning into�������Insert��update,delete����У���dml����޸ĵ��������ݴ�ŵ�������
  �﷨��returning ��,��,, into ����;
  
  update emp set sal=sal+500 where empno=7369;
  select * from emp where empno=7369;
  
  declare
     --����������������Ա���Ĺ��ʺ�Ա�����
     v1 emp.empno%type;
     v2 emp.sal%type;
     
     --rowid ����һ�������������ݵ�rowid
     vid rowid;
  begin
     update emp set sal=sal+500 where empno=7369 returning empno,sal,rowid into v1,v2,vid;
     
     --��ӡ������ֵ
     dbms_output.put_line(v1||','||v2||','||vid);
     
     delete from emp where rowid=vid;
  end;
     
  
  
 2.
