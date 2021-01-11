--1�����α���ʾ���в��ű�������ƣ��Լ�����ӵ�е�Ա��������

select t1.deptno, t1.dname, count(t2.empno)
  from dept t1
  left join emp t2
    on t1.deptno = t2.deptno
 group by t1.deptno, t1.dname;
 
declare
   --����һ���α�
   cursor cur is select t1.deptno,t1.dname,count(t2.empno) a from dept t1 left join emp t2 on t1.deptno=t2.deptno group by t1.deptno,t1.dname;
   --����һ�����������α��һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --�����α�
   loop
     --fetch into
     fetch cur into v;
     --�˳�����
     exit when cur%notfound;
     --ѭ�������
     dbms_output.put_line(v.deptno||','||v.dname||','||v.a);
   end loop;
   --�ر��α�
   close cur;
end;

--��ѯ��������Ϣ�����ݲ��ű�ţ���ѯ�ò��ŵ�����
declare
   --����һ���α�
   cursor cur is select * from dept;
   --����һ�����������α��һ����¼
   v cur%rowtype;
   --����һ����������Ա������
   n number;
begin
   --ʹ���α��ȡ��������Ϣ
   --���α�
   open cur;
   --����
   fetch cur into v;
   while cur%found loop
     --���ݲ��ű�Ų�ѯ�����µ�Ա������
     select count(*) into n from emp where deptno=v.deptno;
     --��ӡ��Ϣ
     dbms_output.put_line(v.deptno||','||v.dname||','||n);
     --fetch into
     fetch cur into v;
   end loop;
   --�ر��α�
   close cur;
end;

--2�����α�����%rowcountʵ�����ǰʮ��Ա������Ϣ��

declare
   --����һ���α�
   cursor cur is select * from emp;
   --����һ�����������α��һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --����
   loop
      --fetch into
      fetch cur into v;
      --�˳�ѭ�����
      exit when cur%notfound or cur%rowcount>=11;
      --ѭ�������
      dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   
   end loop;
   --�ر��α�
   close cur;
end;

declare
   --�����α�
   cursor cur is select * from emp;
   --����һ�����������α��һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --����
   fetch cur into v;
   while cur%found and cur%rowcount<=10 loop
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
     fetch cur into v;
   end loop;
   --�ر��α�
   close cur;
end;

declare
   --����һ���α�
   cursor cur is select * from emp;
begin
   for v in cur loop
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
     exit when cur%rowcount>=10;  
   end loop;
end;
--3��ͨ��ʹ���α�����ʾdept���еĲ������ƣ�������Ӧ��Ա���б���ʾ������ʹ��˫��ѭ������
declare
   --����һ���α꣬��������dept���еĲ�����Ϣ
   cursor c1 is select * from dept;
   --����һ���α꣬���ݲ��ű�Ų�ѯ�����µ�Ա����Ϣ
   cursor c2(dno number) is select * from emp where deptno=dno; 
begin
   for v1 in c1 loop
      --������ȡ������Ϣ
      dbms_output.put_line('��������:'||v1.dname);
      --���ݲ��ű�Ų�ѯ�������µ�Ա����Ϣ
      for v2 in c2(v1.deptno) loop
        dbms_output.put_line(v2.ename);
      end loop;
      
      ---����ָ���
      dbms_output.put_line(rpad('-',50,'-'));
   end loop;
end;

select t1.dname,t2.ename from dept t1 left join emp t2 on t1.deptno=t2.deptno order by t1.dname;

declare
   --����һ���α�
   cursor cur is select t1.dname,t2.ename from dept t1 left join emp t2 on t1.deptno=t2.deptno order by t1.dname;
   --�����������������沿������,v_old��v_new�������ж��Ƿ���һ���µĲ��ţ�������µĲ������ӡ������Ϣ�������ͬ��ʾ������Ϣ�Ѿ���ӡ������Ҫ�ٴδ�ӡ��ֻ��Ҫ��ӡԱ������
   v_old varchar2(30):='';
   v_new varchar2(30):='';
begin
   for v in cur loop
     --���������Ʒ������v_new��
     v_new:=v.dname;
     --�ж�v_new��v_old�Ƿ���ͬ
     if v_new != v_old or v_old is null then
        --��v_new����Ĳ��ŷ���v_old��
        v_old:=v_new;
        dbms_output.put_line(rpad('-',50,'-'));
        --��ӡ��������
        dbms_output.put_line('��������:'||v_new);
        --��ӡԱ������
        dbms_output.put_line(v.ename);
     else
       --��ʾ v_new=v_old,ֻ��ӡԱ������
        dbms_output.put_line(v.ename);
     end if;
   
   end loop;
end;

--4������һ�����źţ�ʹ��Forѭ������emp������ʾ�ò��ŵ����й�Ա��������������нˮ��
declare
   --����һ���α�
   cursor cur is select ename,job,sal from emp where deptno=&���ű��;
begin
   for v in cur loop
      dbms_output.put_line(v.ename||','||v.job||','||v.sal);
   end loop;
end;
declare
   --����һ���α�
   cursor cur(dno number) is select ename,job,sal from emp where deptno=dno;
begin
   for v in cur(&���ű��) loop
      dbms_output.put_line(v.ename||','||v.job||','||v.sal);
   end loop;
end;


--5����дһ������飬��emp����ǰ5�˵����֣�������Ĺ��ʵȼ���salgrade����ʾ������
select ename,grade from emp join salgrade on sal between losal and hisal where rownum<=5;
declare
   --����һ���α�
   cursor cur is select ename,grade from emp join salgrade on sal between losal and hisal where rownum<=5;
   --����һ�����������α��һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --����
   loop
     --fetch into
     fetch cur into v;
     --�˳�ѭ�����
     exit when cur%notfound;
     --��ӡ���
     dbms_output.put_line(v.ename||','||v.grade);
   end loop;
   --�ر��α�
   close cur;
  
end;

declare
   --����һ���α�
   cursor cur is select ename,grade from emp join salgrade on sal between losal and hisal;
   --����һ�����������α��һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --����
   loop
     --fetch into
     fetch cur into v;
     --�˳�ѭ�����
     exit when cur%notfound or cur%rowcount>=6;
     --��ӡ���
     dbms_output.put_line(v.ename||','||v.grade);
   end loop;
   --�ر��α�
   close cur;
end;

declare
   --����һ���α�
   cursor cur is select ename,sal from emp where rownum<=5;
   --����һ����������Ա���Ĺ��ʵȼ�
   s number;
   
begin
   for v in cur loop
     --�Ȳ�ѯǰ5��Ա����Ϣ
   
     --����Ա���Ĺ�����salgrade���в�ѯԱ���Ĺ��ʵȼ�
     select grade into s from salgrade where v.sal between losal and hisal;
     --��ӡ���
     dbms_output.put_line(v.ename||','||s);
   end loop;
end;

--6���ô��������α�������ű��Ϊ10�� 30��Ա����Ϣ��
declare
    --����һ���α꣬���벿�ű�ţ����ݲ��ű�Ų�ѯԱ����Ϣ
    cursor cur(dno number) is select * from emp where deptno=dno;
    --����һ�����������α��һ����¼
    v cur%rowtype;
begin
    --��ѯ10�Ų��ŵ�Ա��
    --���α�
    open cur(10);
    --����
    fetch cur into v;
    while cur%found loop
       dbms_output.put_line(v.ename||','||v.job||','||v.sal||','||v.deptno);
       fetch cur into v;
    end loop;
    --�ر��α�
    close cur;
    
    --��ѯ30�Ų��ŵ�Ա��
    --���α�
    open cur(30);
    --����
    fetch cur into v;
    while cur%found loop
       dbms_output.put_line(v.ename||','||v.job||','||v.sal||','||v.deptno);
       fetch cur into v;
    end loop;
    --�ر��α�
    close cur;
end;

--7��ʹ�ô��������α꣬ʵ�ֽ���һ���������ƣ���emp������ʾ�ò��ŵ����й�Ա��������������нˮ��
select ename,job,sal from emp where deptno in (select deptno from dept where dname='');
select ename,job,sal from emp where exists (select 1 from dept where emp.deptno=deptno and dname='');

declare
   --����һ���α�
   cursor cur(v_dname varchar2) is select ename,job,sal from emp where deptno in (select deptno from dept where dname=v_dname);
   --����һ�����������α��е�һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur('&��������');
   --����
   loop
      fetch cur into v;
      exit when cur%notfound;
      dbms_output.put_line(v.ename||','||v.job||','||v.sal);
   end loop;
   --�ر��α�
   close cur;
end;

select * from dept;


--8�����α��ȡ�������볬��2000�� salesman.
select * from emp where sal+nvl(comm,0)>2000 and job='SALESMAN';

declare
    --����һ���α�
    cursor cur is select * from emp where sal+nvl(comm,0)>2000 and job='SALESMAN';
begin
    for v in cur loop
      dbms_output.put_line(v.ename);
    end loop;
end;
--9����дһ��PL/SQL����飬��emp���ж�������"A"��"S"��ʼ�����й�Ա�����ǻ���нˮ��10%�����Ǽ�н��
declare
   --����һ���α�
   cursor cur is select * from emp where ename like 'A%' or ename like 'S%';
begin
   for v in cur loop
      update emp set sal=sal*1.1 where empno=v.empno;
   end loop;
end;


declare
   --����һ���α�
   cursor cur is select sal from emp where ename like 'A%' or ename like 'S%' for update;
begin
   for v in cur loop
      update emp set sal=sal*1.1 where current of cur; --where current of cur ��ʾ�����α굱ǰ�е�����
   end loop;
end;


--10������salgrade���еı�׼����Ա����н��1��5%��2��4%��3��3%��4��2%��5��1%�� 
--����ӡ���ÿ���ˣ���нǰ��Ĺ��ʡ�
select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 


declare
   --����һ���α�
   cursor cur is select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 
begin
   for v in cur loop
     --��ȡ��ÿһ��Ա������Ϣ empno ename sal grade
     case grade
       when 1 then
         update emp set sal=sal*1.05 where empno=v.empno;
       when 2 then
         update emp set sal=sal*1.04 where empno=v.empno;
       when 3 then
         update emp set sal=sal*1.03 where empno=v.empno;
       when 4 then
         update emp set sal=sal*1.02 where empno=v.empno;
       else
         update emp set sal=sal*1.01 where empno=v.empno;
     end case;
   end loop;
  
end;

declare
   --����һ���α�
   cursor cur is select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 
begin
   for v in cur loop
     --��ȡ��ÿһ��Ա������Ϣ empno ename sal grade
     dbms_output.put(v.ename||'��нǰ�Ĺ���:'||v.sal);
     case v.grade
       when 1 then
         v.sal:=v.sal*1.05;
       when 2 then
         v.sal:=v.sal*1.04;
       when 3 then
         v.sal:=v.sal*1.03;
       when 4 then
         v.sal:=v.sal*1.02;
       else
         v.sal:=v.sal*1.01;
     end case;
     update emp set sal=v.sal where empno=v.empno;
     dbms_output.put_line(',��н��Ĺ���:'||v.sal);
   end loop; 
end;


declare
   --����һ���α�
   cursor cur is select empno,ename,sal,grade from emp join salgrade on sal between losal and hisal; 
   --����һ�����������н��Ĺ���
   v_sal emp.sal%type;
begin
   for v in cur loop
     --��ȡ��ÿһ��Ա������Ϣ empno ename sal grade
     case v.grade
       when 1 then
         v_sal:=v.sal*1.05;
       when 2 then
         v_sal:=v.sal*1.04;
       when 3 then
         v_sal:=v.sal*1.03;
       when 4 then
         v_sal:=v.sal*1.02;
       else
         v_sal:=v.sal*1.01;
     end case;
     update emp set sal=v_sal where empno=v.empno;
     dbms_output.put_line(v.ename||'��нǰ�Ĺ���:'||v.sal||',��н��Ĺ���:'||v_sal);
   end loop; 
end;
