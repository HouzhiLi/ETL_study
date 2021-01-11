1.дһ���洢���̣�����Ա����Ϣ����emp���в���һ��Ա����Ϣ
create or replace procedure p1(v_empno in number,
                               v_ename in varchar2,
                               v_job in varchar2,
                               v_mgr in number,
                               v_hiredate in date,
                               v_sal in number,
                               v_comm in number,
                               v_deptno in number)
is
begin
  insert into emp values(v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno);
end;

begin
  p1(9999,'xx','qa',7369,sysdate,1234,100,10);
end;
create or replace procedure p1(v emp%rowtype)
is
begin
  insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);
end;
--ע�⣺in���ʹ��Σ�����ͨ���Ϳ��������ⷽʽ���Σ���¼���͵ȸ���������Ҫ�Դ�������ʽ��
declare
  --����һ����¼���ͱ���
  e emp%rowtype;
begin
  --��ֵ
  e.empno:=9999;
  e.ename:='ss';
  e.job:='clerk';
  e.sal:=1234;
  e.deptno:=10;
  
  p1(e);
end;
select * from emp;
2.(��̬��)дһ���洢���̣�����һ���ַ�������Ա�����в���һ��Ա����Ϣ���ַ�����ʽ
Ա�����,����,����,�ϼ����,��ְʱ��,Ӷ��,���ű��

select empno||','||ename||','||job||','||mgr||','||hiredate||','||sal||','||comm||','||deptno from emp where empno=7499;

'7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30'

declare
   --����һ�����������ַ���
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --����һ�����������ȡ���
   tmp varchar2(50);
begin
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   tmp:=substr(s,1,instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   
   
   --��2������λ��  instr(s,',',1,2)
   --��ȡ��2�����ݣ��ӵ�1������+1��λ�ÿ�ʼ�����ȣ���2������-��1������-1
   tmp:=substr(s,instr(s,',',1,1)+1,instr(s,',',1,2)-instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   --��3������λ�� instr(s,',',1,3)
   --��ȡ��3�����ݣ��ӵ�2������+1��λ�ÿ�ʼ�����ȣ���3������-��2������-1
   tmp:=substr(s,instr(s,',',1,2)+1,instr(s,',',1,3)-instr(s,',',1,2)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,3)+1,instr(s,',',1,4)-instr(s,',',1,3)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,4)+1,instr(s,',',1,5)-instr(s,',',1,4)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,5)+1,instr(s,',',1,6)-instr(s,',',1,5)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,6)+1,instr(s,',',1,7)-instr(s,',',1,6)-1);
   dbms_output.put_line(tmp);
   
   --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
   tmp:=substr(s,instr(s,',',1,7)+1);
   dbms_output.put_line(tmp);
   --�ַ������ͣ�����ת��
   
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
end;


declare
   --����һ�����������ַ���
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --����һ�����������ȡ���
   tmp varchar2(50);
begin
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   tmp:=substr(s,1,instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   
   for i in 2..7 loop
     tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
     dbms_output.put_line(tmp);
   end loop;
   
   --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
   tmp:=substr(s,instr(s,',',1,7)+1);
   dbms_output.put_line(tmp);
   --�ַ������ͣ�����ת��
   
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
end;


declare
   --����һ�����������ַ���
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --����һ�����������ȡ���
   tmp varchar2(50);
begin
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   tmp:=substr(s,1,instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   
   for i in 1..6 loop
     tmp:=substr(s,instr(s,',',1,i)+1,instr(s,',',1,i+1)-instr(s,',',1,i)-1);
     dbms_output.put_line(tmp);
   end loop;
   
   --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
   tmp:=substr(s,instr(s,',',1,7)+1);
   dbms_output.put_line(tmp);
   --�ַ������ͣ�����ת��
   
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
end;

declare
   --����һ�����������ַ���
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --����һ�����������ȡ���
   tmp varchar2(50);
begin
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   for i in 1..8 loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=8 then
       --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     
   
   end loop;
   --�ַ������ͣ�����ת��
   
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
end;

declare
    s varchar2(300):='7499,ALLEN,SALESMAN,,1981-02-20,1600,300,30';
begin
   --�����ַ���s�ж��ŵĸ���
end;

select length('aaa,bbb,ccc')-length(replace('aaa,bbb,ccc',',','')) from dual;


--'aaaxybbbxyccc' �ַ�����xy����
--��ԭ�ַ�������-�滻�����ַ������ȣ�/���滻���ַ�������
select (length('aaaxybbbxyccc')-length(replace('aaaxybbbxyccc','xy','')))/length('xy') from dual;

declare
   --����һ�����������ַ���
   s varchar2(300):='9990,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --����һ�����������ȡ���
   tmp varchar2(50);
   --����һ��������������
   n number;
   --����һ����������һ��emp���¼
   v emp%rowtype;
begin
   --��ȡ����
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   for i in 1..n loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=n then
       --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     --�ַ������ͣ�����ת��
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
     
   end loop;
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);  
end;

declare
   --����һ�����������ַ���
   s varchar2(300):='9990,ALLEN,NULL,NULL,NULL,1600,NULL,30';
   --����һ�����������ȡ���
   tmp varchar2(50);
   --����һ��������������
   n number;
   --����һ����������һ��emp���¼
   v emp%rowtype;
begin
   --��ȡ����
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   for i in 1..n loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=n then
       --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     --�ж�
     if tmp='NULL' then
       continue;
     end if;
     --�ַ������ͣ�����ת��
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
     
   end loop;
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);  
end;


create or replace procedure p2(s varchar2)
is
   --����һ�����������ȡ���
   tmp varchar2(50);
   --����һ��������������
   n number;
   --����һ����������һ��emp���¼
   v emp%rowtype;
begin
   --��ȡ����
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --�ַ����ֿ�����Ϊ8��ֵ
   --instr(s,',',1,1); --ȡ��1������λ��
   --��1���ַ����Ľ�ȡ����1��ȡ�� ��1������-1�ĳ��� 
   for i in 1..n loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=n then
       --���һ��ֵ�Ļ�ȡ���ӵ�7������+1��λ�ÿ�ʼ����ȡ���ַ����Ľ���
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     --�ж�
     if tmp='NULL' then
       continue;
     end if;
     --�ַ������ͣ�����ת��
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
     
   end loop;
   --���뵽���ݿ⣬ʹ�õ�1��Ĵ洢����
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);  
end;

select * from emp;

�ַ����ָ�
����ת��
����

---�ַ����ָ�
regexp_substr(�ַ�������,������ʽ,��ʼλ��,�ڼ���): ����������ʽ��ȡ�ַ���

select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,1) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,2) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,3) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,4) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,5) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,6) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,7) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,8) from dual;


create or replace procedure p2(s varchar2)
is
   --����һ��������������
   n number;
   --����һ�����������ȡ�����ַ���
   tmp varchar2(100);
   --����һ����������ת���������
   v emp%rowtype;
begin
   --��������
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --
   for i in 1..n loop
     tmp:=regexp_substr(s,'[^,]+',1,i);
     --����ת��
     --�ַ������ͣ�����ת��
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
   end loop;
   --��������
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);
end;
3.дһ���洢���̣���������Ĳ���,�޸�Ա����Ϣ��(Ա�����Ϊ�ش�����)
 ע�����ֻ����Ա����������ô��ֻ�޸�����
     ���������ֵ�����޸�Ա���Ķ����Ϣ
     ���磺����Ա�������������������ʣ���Ҫ��
     ��������������������Ϣ���޸�
create or replace procedure p3(v emp%rowtype)
is

begin
  update emp set ename=nvl(v.ename,ename),
                 job=nvl(v.job,job),
                 sal=nvl(v.sal,sal),
                 comm=nvl(v.comm,comm),
                 hiredate=nvl(v.hiredate,hiredate),
                 mgr=nvl(v.mgr,mgr),
                 deptno=nvl(v.deptno,deptno)
  where empno=v.empno;
end;
select nvl(comm,'��') from emp;

select nvl2(comm,comm||'��','��') from emp;

create or replace procedure p3(v emp%rowtype)
is
   --����һ���ַ�������sql���
   v_sql varchar2(500);
begin
   v_sql:='update emp set ';
   if v.ename is not null then
      v_sql:=v_sql||'ename='''||v.ename||''',';
   end if;
   if v.job is not null then
      v_sql:=v_sql||'job='''||v.job||''',';
   end if;
   if v.mgr is not null then
      v_sql:=v_sql||'mgr='||v.mgr||',';
   end if;
   if v.hiredate is not null then
      v_sql:=v_sql||'hiredate='''||v.hiredate||''',';
   end if;
   if v.sal is not null then
      v_sql:=v_sql||'sal='||v.sal||',';
   end if;
   if v.comm is not null then
      v_sql:=v_sql||'comm='||v.comm||',';
   end if;
   if v.deptno is not null then
      v_sql:=v_sql||'deptno='||v.deptno||',';
   end if;
   --ȥ�����һ������
   v_sql:=substr(v_sql,1,length(v_sql)-1);
   --ƴ������
   v_sql:=v_sql||' where empno='||v.empno;
   dbms_output.put_line(v_sql);
   --ִ��sql���
   execute immediate v_sql;
end;

declare
   e emp%rowtype;
begin
  e.empno:=7369;
  e.ename:='haha';
  e.job:='clerk';
  e.hiredate:=sysdate;
  --e.mgr:=7499;
  --e.sal:=200;
  --e.comm:=100;
  --e.deptno:=10;
  p3(e);
end;

update emp set ename='haha',job='clerk',mgr=7499,hiredate='07-JAN-21',sal=200,comm=100,deptno=10 where empno=7369;
update emp set ename='haha',job='clerk',hiredate='07-JAN-21' where empno=7369
select * from emp where empno=7369;


create or replace procedure p3(v emp%rowtype)
is
   --����һ���ַ�������sql���
   v_sql varchar2(500);
   --����һ��������������
   seq varchar2(1):='';
begin
   v_sql:='update emp set ';
   if v.ename is not null then
      v_sql:=v_sql||seq||'ename='''||v.ename||'''';
      seq:=',';
   end if;
   if v.job is not null then
      v_sql:=v_sql||seq||'job='''||v.job||'''';
      seq:=',';
   end if;
   if v.mgr is not null then
      v_sql:=v_sql||seq||'mgr='||v.mgr;
      seq:=',';
   end if;
   if v.hiredate is not null then
      v_sql:=v_sql||seq||'hiredate='''||v.hiredate||'''';
      seq:=',';
   end if;
   if v.sal is not null then
      v_sql:=v_sql||seq||'sal='||v.sal;
      seq:=',';
   end if;
   if v.comm is not null then
      v_sql:=v_sql||seq||'comm='||v.comm;
      seq:=',';
   end if;
   if v.deptno is not null then
      v_sql:=v_sql||seq||'deptno='||v.deptno;
      seq:=',';
   end if;
   --ƴ������
   v_sql:=v_sql||' where empno='||v.empno;
   dbms_output.put_line(v_sql);
   --ִ��sql���
   execute immediate v_sql;
end;


create or replace procedure p3(v emp%rowtype)
is
   --����һ���ַ�������sql���
   v_sql varchar2(500);
begin
   if v.ename is not null then
      v_sql:=v_sql||',ename='''||v.ename||'''';
   end if;
   if v.job is not null then
      v_sql:=v_sql||',job='''||v.job||'''';
   end if;
   if v.mgr is not null then
      v_sql:=v_sql||',mgr='||v.mgr;
   end if;
   if v.hiredate is not null then
      v_sql:=v_sql||',hiredate='''||v.hiredate||'''';
   end if;
   if v.sal is not null then
      v_sql:=v_sql||',sal='||v.sal;
   end if;
   if v.comm is not null then
      v_sql:=v_sql||',comm='||v.comm;
   end if;
   if v.deptno is not null then
      v_sql:=v_sql||',deptno='||v.deptno;
   end if;
   dbms_output.put_line(v_sql);
   --ȥ����1������
   v_sql:=substr(v_sql,2);
   --ƴ��sql����ǰ��
   v_sql:='update emp set '||v_sql;
   --ƴ������
   v_sql:=v_sql||' where empno='||v.empno;
   dbms_output.put_line(v_sql);
   --ִ��sql���
   execute immediate v_sql;
end;

4.���ҳ���ǰ�û�ģʽ�£�ÿ�ű�ļ�¼������scott�û�Ϊ�������Ӧ���£�
DEPT...................................4
EMP...................................14
BONUS.................................0
SALGRADE.............................5
��ʾ�������û������б�����sqlΪselect table_name from user_tables;
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
6.����һ�����̣�����dept�������һ���¼�¼.��in������
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
14.��дһ���������Ա��н10%�Ĺ��̣���֮�󣬼������Ѿ���Ӷ�ù�Ա����60���£�����������н3000.
