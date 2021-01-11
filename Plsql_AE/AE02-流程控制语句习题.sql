1-���̽�������ֵ����ӡ�Ƚϴ��ֵ

declare 
m number(3) := &m;
n number(3) := &n;
begin
  if m > n then
    dbms_output.put_line(m);
    else
      dbms_output.put_line(n);
      end if;
      end;
      
2-���̽�������ֵ�������մӴ�С���δ�ӡ

declare
a number(3) := &a;
b number(3) := &b;
c number(3) := &c;
begin
  if a>b and a>c then 
    if b>c then
      dbms_output.put_line(a || ', ' || b || ', ' || c);
      else
        dbms_output.put_line(a || ', ' || c || ', ' || b);
        end if;
        elsif b>a and b>c then
          if a>c then
            dbms_output.put_line(b || ', ' || a || ', ' || c);
            else
              dbms_output.put_line(b || ', ' || c || ', ' || a);
              end if;
              else
                if a>b then
                  dbms_output.put_line(c || ', ' || a || ', ' || b);
                  else
                    dbms_output.put_line(c || ', ' || b || ', ' || a);
                    end if;
                    end if;
                    end;
-------------------------------------------------------------------------------------------------                  
declare
n number(3);
v_sql1 varchar2(300) := 'insert into order_num values (:1)';
v_sql varchar2(300) := 'create table order_num (numbers number(3))';

begin
  select count(1) into n from user_tables where table_name = 'ORDER_NUM'; 
  if n = 0 then
    execute immediate v_sql;
    execute immediate v_sql1 using &a;
    execute immediate v_sql1 using &b;
    execute immediate v_sql1 using &c;
    else
    for v in (select * from order_num order by numbers desc) loop
        dbms_output.put_line(v.numbers);
        end loop;
      end if;
      end;
-------------------------------------------------------------------------------------------------------- 
declare
n number(3);
v_num number(3) := &n;
v_sql1 varchar2(300) := 'insert into order_num values (:1)';
v_sql varchar2(300) := 'create table order_num (numbers number(3))';

begin
  select count(1) into n from user_tables where table_name = 'ORDER_NUM'; 
  if n = 0 then
    execute immediate v_sql;
    execute immediate v_sql1 using v_num;
    else
      execute immediate v_sql1 using v_num;
      end if;
      end;

begin  
  for v in (select * from order_num order by numbers desc) loop
        dbms_output.put_line(v.numbers);
        end loop;
        end;

        
4-�ж�һ������ǲ�������
���꣺�ܱ�4���������ܱ�100����   ���߱�400����

declare
y number(4) := &yyyy;
begin
  if mod(y, 4) = 0 and mod(y, 100) <> 0 then
    dbms_output.put_line('rn');
    elsif mod(y, 400) = 0 then
      dbms_output.put_line('en');
      else
        dbms_output.put_line('pn');
        end if;
        end;


5-����ָ����BMI��=���أ�kg�������^2��m��

ƫ��  <= 18.4
����  18.5 ~ 23.9
����  24.0 ~ 27.9
����  >= 28.0
��Ҫ���������غ���ߣ��������ָ�����ڷ�Χ

declare
kg number(5,2) := &kg;
m number(3,2) := &m;
bmi number (4,1) := kg / power(m,2);
begin
  case
    when bmi <= 18.4 then
      dbms_output.put_line('ƫ��');
      when bmi between 18.5 and 23.9 then
        dbms_output.put_line('����');
        when bmi between 24.0 and 27.9 then
          dbms_output.put_line('����');
          else
            dbms_output.put_line('����');
            end case;
            end;
            
6-����һ�������ж�����������ż��

declare
m integer := &m;
begin
  if mod(m, 2) = 0 then
    dbms_output.put_line('ou');
    else
      dbms_output.put_line('ji');
      end if;
      end;
      
1.��дһ������飬��emp������ʾ��Ϊ��SMITH���Ĺ�Ա��нˮ��ְλ

declare
v emp%rowtype;
v_ename emp.ename%type := 'SMITH';
v_sql varchar2(300) := 'select * from emp where ename = :1';
begin
  execute immediate v_sql into v using v_ename;
  dbms_output.put_line(v.sal || ', ' || v.job);
  end; 


2.��дһ������飬�����û�����һ�����źţ���dept������ʾ�ò��ŵ�����������λ��

declare
v_deptno dept.deptno%type := &deptno;
v dept%rowtype;
v_sql varchar2(300) := 'select * from dept where deptno = :1';
begin
  execute immediate v_sql into v using v_deptno;
  dbms_output.put_line(v.dname || ', ' || v.loc);
  end;

3.��дһ������飬����%type���ԣ�����һ����Ա�ţ���emp������ʾ�ù�Ա������нˮ(����нˮ��Ӷ��)

declare
v number(7,2); 
v_empno emp.empno%type := &empno; 
v_sql varchar2(300):= 'select nvl(sal, 0) + nvl(comm, 0) as ts from emp where empno = :1';

begin
  execute immediate v_sql into v using v_empno;
  dbms_output.put_line(v);
  end;
  
4.��дһ������飬����%rowtype���ԣ�����һ����Ա�ţ���emp������ʾ�ù�Ա������нˮ

declare
v number(7,2); 
v_emp %rowtype; 
v_sql varchar2(300):= 'select nvl(sal, 0) + nvl(comm, 0) as ts from emp where empno = :1';

begin
  execute immediate v_sql into v using v_empno;
  dbms_output.put_line(v);
  end;



5.ĳ��˾Ҫ���ݹ�Ա��ְλ����н����˾���������м�н�ṹ����
   Designation      Raise
   ------------     --------
   clerk            500
   salesman         1000
   analyst          1500
   otherwise        2000
��дһ������飬����һ����Ա������emp����ʵ��������н����

declare
v_job emp.job%type; 
v1 number := 500;
v2 number := 1000;
v3 number := 1500;
v4 number := 2000;
v_ename varchar2(10) := '&ename';
v_sql varchar2(300):= 'select job from (select job from emp where ename = :1 order by empno) where rownum = 1';
v_sql1 varchar2(300) := 'update emp set sal = sal + :1 where empno = (select empno from(select * from emp where ename = :2 order by empno) where rownum = 1)';
v_sql2 varchar2(300) := 'update emp set sal = sal + :1 where ename = :1 and job = :2';
v_sql3 varchar2(300) := 'update emp set sal = sal + :1 where ename = :1';

begin
   execute immediate v_sql into v_job using v_ename;
  if v_job = 'clerk' then
    execute immediate v_sql1 using v1, v_ename;
    elsif v_job = 'salesman' then
      execute immediate v_sql1 using v2, v_ename;
      elsif v_job = 'analyst' then
        execute immediate v_sql1 using v3, v_ename;
        else 
          execute immediate v_sql1 using v4, v_ename;
          end if;
          end;
      select * from emp;

13.����������㲻��ʽ 1+3^2+5^2+��+N^2>2000����СNֵ��

declare
i number := 2;
n number := 1;
sum_n  number := 0;
begin
  while sum_n <= 2000 loop
    sum_n := sum_n + power(n,2);
     n := n + i;
     end loop;
     dbms_output.put_line(n-i);
     dbms_output.put_line(sum_n);
     end;

--23

14.����Ա���е����й���С��3000����400��ͳ�Ƴ����ӹ��ʵ����������ӵĹ���������

declare
v_sum number(7,2);
v_member number(3);
v_raise number(7,2) := 400;
v_sql varchar2(300) := 'update emp set sal = sal + :1 where sal < 3000';
v_sql1 varchar2(300) := 'select count(1) from emp where sal < 3000';
v_sql2 varchar2(300) := 'select (:1 * :2) as sum_raise from dual';
begin
  execute immediate v_sql using v_raise;
  execute immediate v_sql1 into v_member;
  execute immediate v_sql2 into v_sum using v_member, v_raise;
  dbms_output.put_line(v_member || ', ' || v_sum);
  end;
  
15.�ӹ�Ա������ʾ������ߵ�ǰ����˵����������ź͹��ʡ�

begin
  
  for v in (select * from (select * from emp order by sal desc) where rownum < 5) loop
  dbms_output.put_line(v.ename || ', ' || v.deptno || ', ' || v.sal);
  end loop;
  
  end;


6.��дһ������飬��emp���й�Ա��ȫ����ʾ����

begin
  for v in (select ename from emp) loop
    dbms_output.put_line(v.ename);
    end loop;
    end; 

7.��дһ������飬��emp����ǰ5�˵�������ʾ����

begin
  for v in (select * from (select * from emp) where rownum <= 5) loop
    dbms_output.put_line(v.ename);
    end loop;
    end;

8.�������������������ʾ���������ڶ�����Ϊ0������ʾ��Ϣ����������Ϊ0��

declare
m number := &m;
n number := &n;
v_sql varchar2(300) := 'select (:1 / :2) as res from dual';
res number;
begin
  if n = 0 then
    dbms_output.put_line('��������Ϊ0');
    else
      execute immediate v_sql into res using m, n;
      dbms_output.put_line(res);
      end if;
      end;
      
9���������漶����ĩ��С��0.001ʱ�Ĳ��ֺ͡� 
1/(1*2)+1/(2*3)+1/(3*4)+��+1/(n*(n+1))+ ����
    ----------------------------
    declare
s number := 0;
n number := 1;
res number:=1;
begin
  while res >=0.001 loop
    res := 1/(n*(n+1));
    n := n+1;
    s := s + res;
    end loop;
    dbms_output.put_line(s);
    end;
    ---------------------------
    declare
s number := 0;
n number := 1;
res number:=1;
begin
   loop
    res := 1/(n*(n+1));
    n := n+1;
    s := s + res;
    exit when res < 0.001;
    end loop;
    dbms_output.put_line(s);
    end;    

10������s=1*2+2*3+��+N*(N+1),��N=50��ֵ��

declare
n number := 1;
s number := 0;
res number;
v_sql varchar2(300) := 'select :1 * :2 as res from dual';
begin
  while n<= 50 loop
    execute immediate v_sql into res using n, n+1;
    s := s + res;
    n := n+1;
    end loop;
    dbms_output.put_line(s);
    end;
    -------------------------
    declare
n number := 1;
s number := 0;
res number;
begin
  while n<= 50 loop
    res := n*(n+1);
    s := s + res;
    n := n+1;
    end loop;
    dbms_output.put_line(s);
    end;
 
11.��дһ��PL/SQL����飬��emp���ж������ԡ�A����"S"��ʼ�����й�Ա�����ǻ���нˮ��10%�����Ǽ�н

declare
v_sql varchar2(300) := 'update emp set sal = sal + 0.1*sal where ename like ''A%'' or ename like ''S%''';
begin
  execute immediate v_sql;
  end;
  
  select * from emp;
  
12������ѭ��������S=1!+2!+��+10!��

declare
m number := 1;
n number := 1;
s number := 0;
res number := 1;
begin     
  while m <= 10 loop
    
  while n<=m loop
    res := res * n;
    n := n + 1;
    end loop;
    
    s := s + res;
    m := m+1;
    end loop;
    
    dbms_output.put_line(s);
    end;
    ----------------------------------------
    declare
s number := 0;
res number := 1;
begin
  for m in 1..3 loop
    for n in 1..m loop
      res := res * n;
      end loop;
      s := s + res;
      end loop;
      dbms_output.put_line(s);
      end;
--------------------------------------
--����һ����������׳˽��
m number := 1;
--����һ������������ʽ���
s number := 0;
begin
  for i in 1..10 loop;
  m := 1;
  for j in 1..i loop;
  -- ��ʼ������m
  m := m*n;
  -- ������ʽ���
  s := s + m;
  end loop;
  s := s+m;
  end loop;
  -------------------
  declare
  
  -- ����һ����������׳˵Ľ��
  m number := 1;
  -- ����һ������������ʽ�Ľ��
  s number := 0; 
  begin
    for n in 1..10 loop
      -- ����һ����������׳˵Ľ��
      m := m*n;
      -- ����׳�
      s := s+m;
      end loop;
      dbms_output.put_line(s);
    end;
   
   
