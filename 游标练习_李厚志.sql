--1�����α���ʾ���в��ű�������ƣ��Լ�����ӵ�е�Ա��������
declare
cursor cur is select d.deptno dno, d.dname, count(1) nums from dept d, emp e where d.deptno = e.deptno(+) group by d.deptno, d.dname;
v cur%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    exit when cur%notfound;
    dbms_output.put_line(v.dno|| ', ' || v.dname|| ', ' || v.nums);
    end loop;
    close cur;
    end;
    
--2�����α�����%rowcountʵ�����ǰʮ��Ա������Ϣ��

declare
cursor cur is select * from emp;
v cur%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.deptno|| ', ' || v.mgr|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.hiredate);
    exit when cur%rowcount = 10;
    end loop;
    close cur;
    end;
    
--3��ͨ��ʹ���α�����ʾdept���еĲ������ƣ�������Ӧ��Ա���б���ʾ������ʹ��˫��ѭ������
declare
cursor cur1 is select deptno, dname from dept;
begin
  for v in cur1 loop
     dbms_output.put_line(v.dname);
     for m in (select * from emp where deptno = v.deptno) loop
       dbms_output.put_line(m.empno|| ', ' || m.ename|| ', ' || m.deptno);
       end loop;
       end loop;
       end;
       ------------------
declare
cursor cur1 is select deptno, dname from dept;
cursor cur2 (dno number) is select * from emp where deptno = dno;
begin
  for v in cur1 loop
    dbms_output.put_line(v.dname);
    for m in cur2(v.deptno) loop
       dbms_output.put_line(m.empno|| ', ' || m.ename|| ', ' || m.deptno);
      end loop;
      end loop;
      end;
      
--4������һ�����źţ�ʹ��Forѭ������emp������ʾ�ò��ŵ����й�Ա��������������нˮ��
declare
v_dno number := &dno;
cursor cur is select ename, job, sal from emp where deptno = v_dno;
begin
  for v in cur loop
    dbms_output.put_line(v.ename|| ', ' || v.job|| ', ' || v.sal);
    end loop;
    end;


--5����дһ������飬��emp����ǰ5�˵����֣�������Ĺ��ʵȼ���salgrade����ʾ������
declare
cursor cur is select e.ename, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;
v cur%rowtype;
begin
  open cur;
  loop
    fetch cur into v;
    dbms_output.put_line(v.ename || ', ' ||  v.grade);
    exit when cur%rowcount = 5;
    end loop;
    close cur;
    end;

--6���ô��������α�������ű��Ϊ10�� 30��Ա����Ϣ��
declare 
cursor cur(dno number) is select * from emp where deptno = dno;
begin
  for v in cur(10) loop
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.mgr|| ', ' || v.deptno|| ', ' || v.hiredate);
    end loop;
    
    for v in cur(30) loop
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.mgr|| ', ' || v.deptno|| ', ' || v.hiredate);
    end loop;
    end;
    
--7��ʹ�ô��������α꣬ʵ�ֽ���һ���������ƣ���emp������ʾ�ò��ŵ����й�Ա��������������нˮ��
declare
v_dname dept.dname%type := '&dname';
cursor cur(dept_name v_dname%type) is select e.ename, e.job, e.sal from emp e, dept d where e.deptno(+) = d.deptno and d.dname = dept_name;
begin
  for v in cur(v_dname) loop
    dbms_output.put_line(v.ename|| ', ' || v.job|| ', ' || v.sal);
    end loop;
    end;

--8�����α��ȡ�������볬��2000�� salesman.
declare
cursor cur(v_sal number, v_job emp.job%type) is select * from emp where sal > v_sal and job = v_job;
begin
  for v in cur(2000, 'SALESMAN') loop
    dbms_output.put_line(v.empno|| ', ' || v.ename|| ', ' || v.job|| ', ' || v.sal|| ', ' || v.comm|| ', ' || v.mgr|| ', ' || v.deptno|| ', ' || v.hiredate);
    end loop;
    end;

--9����дһ��PL/SQL����飬��emp���ж�������"A"��"S"��ʼ�����й�Ա�����ǻ���нˮ��10%�����Ǽ�н��
declare
cursor cur is select * from emp where instr(ename, 'A') = 1 or instr(ename, 'S') = 1;
begin
  for v in cur loop
    update emp set sal = sal * 1.1 where empno = v.empno;
    end loop;
    end;
    select * from emp;
  
--10������salgrade���еı�׼����Ա����н��1��5%��2��4%��3��3%��4��2%��5��1%�� 
--����ӡ���ÿ���ˣ���нǰ��Ĺ��ʡ�
declare
cursor cur is select * from emp e, salgrade s where e.sal between s.losal and s.hisal;
v_emp emp%rowtype;
begin
   for v in  cur loop
     if v.grade = 1 then
       update emp set sal = sal * 1.05 where empno = v.empno;
       elsif v.grade = 2 then
         update emp set sal = sal * 1.04 where empno = v.empno;
         elsif v.grade = 3 then
           update emp set sal = sal * 1.03 where empno = v.empno;
           elsif v.grade = 4 then
             update emp set sal = sal * 1.02 where empno = v.empno;
             else
               update emp set sal = sal * 1.01 where empno = v.empno;
               end if;
               select * into v_emp from emp where empno = v.empno;
               dbms_output.put_line(v.empno || ', before: ' || v.sal || ', after: ' || v_emp.sal);
               end loop;
               rollback;
               end;
               
