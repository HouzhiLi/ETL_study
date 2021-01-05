1-键盘接入两个值，打印比较大的值

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
      
2-键盘介入三个值，并按照从大到小依次打印

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

        
4-判断一个年份是不是闰年
润年：能被4整除但不能被100整除   或者被400整除

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


5-体质指数（BMI）=体重（kg）÷身高^2（m）

偏瘦  <= 18.4
正常  18.5 ~ 23.9
过重  24.0 ~ 27.9
肥胖  >= 28.0
现要求输入体重和身高，求出体质指数所在范围

declare
kg number(5,2) := &kg;
m number(3,2) := &m;
bmi number (4,1) := kg / power(m,2);
begin
  case
    when bmi <= 18.4 then
      dbms_output.put_line('偏瘦');
      when bmi between 18.5 and 23.9 then
        dbms_output.put_line('正常');
        when bmi between 24.0 and 27.9 then
          dbms_output.put_line('过重');
          else
            dbms_output.put_line('肥胖');
            end case;
            end;
            
6-输入一个数，判断是奇数还是偶数

declare
m integer := &m;
begin
  if mod(m, 2) = 0 then
    dbms_output.put_line('ou');
    else
      dbms_output.put_line('ji');
      end if;
      end;
      
1.编写一个程序块，从emp表中显示名为“SMITH”的雇员的薪水和职位

declare
v emp%rowtype;
v_ename emp.ename%type := 'SMITH';
v_sql varchar2(300) := 'select * from emp where ename = :1';
begin
  execute immediate v_sql into v using v_ename;
  dbms_output.put_line(v.sal || ', ' || v.job);
  end; 


2.编写一个程序块，接受用户输入一个部门号，从dept表中显示该部门的名称与所在位置

declare
v_deptno dept.deptno%type := &deptno;
v dept%rowtype;
v_sql varchar2(300) := 'select * from dept where deptno = :1';
begin
  execute immediate v_sql into v using v_deptno;
  dbms_output.put_line(v.dname || ', ' || v.loc);
  end;

3.编写一个程序块，利用%type属性，接受一个雇员号，从emp表中显示该雇员的整体薪水(即，薪水加佣金)

declare
v number(7,2); 
v_empno emp.empno%type := &empno; 
v_sql varchar2(300):= 'select nvl(sal, 0) + nvl(comm, 0) as ts from emp where empno = :1';

begin
  execute immediate v_sql into v using v_empno;
  dbms_output.put_line(v);
  end;
  
4.编写一个程序块，利用%rowtype属性，接受一个雇员号，从emp表中显示该雇员的整体薪水

declare
v number(7,2); 
v_emp %rowtype; 
v_sql varchar2(300):= 'select nvl(sal, 0) + nvl(comm, 0) as ts from emp where empno = :1';

begin
  execute immediate v_sql into v using v_empno;
  dbms_output.put_line(v);
  end;



5.某公司要根据雇员的职位来加薪，公司决定按下列加薪结构处理：
   Designation      Raise
   ------------     --------
   clerk            500
   salesman         1000
   analyst          1500
   otherwise        2000
编写一个程序块，接受一个雇员名，从emp表中实现上述加薪处理

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

13.编程序求满足不等式 1+3^2+5^2+…+N^2>2000的最小N值。

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

14.将雇员表中的所有工资小于3000增加400，统计出增加工资的人数及增加的工资数量。

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
  
15.从雇员表中显示工资最高的前五个人的姓名，部门和工资。

begin
  
  for v in (select * from (select * from emp order by sal desc) where rownum < 5) loop
  dbms_output.put_line(v.ename || ', ' || v.deptno || ', ' || v.sal);
  end loop;
  
  end;


6.编写一个程序块，将emp表中雇员名全部显示出来

begin
  for v in (select ename from emp) loop
    dbms_output.put_line(v.ename);
    end loop;
    end; 

7.编写一个程序块，将emp表中前5人的名字显示出来

begin
  for v in (select * from (select * from emp) where rownum <= 5) loop
    dbms_output.put_line(v.ename);
    end loop;
    end;

8.接受两个数相除并且显示结果，如果第二个数为0，则显示消息“除数不能为0”

declare
m number := &m;
n number := &n;
v_sql varchar2(300) := 'select (:1 / :2) as res from dual';
res number;
begin
  if n = 0 then
    dbms_output.put_line('除数不能为0');
    else
      execute immediate v_sql into res using m, n;
      dbms_output.put_line(res);
      end if;
      end;
      
9、计算下面级数当末项小于0.001时的部分和。 
1/(1*2)+1/(2*3)+1/(3*4)+…+1/(n*(n+1))+ ……
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

10、计算s=1*2+2*3+…+N*(N+1),当N=50的值。

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
 
11.编写一个PL/SQL程序块，从emp表中对名字以“A”或"S"开始的所有雇员按他们基本薪水的10%给他们加薪

declare
v_sql varchar2(300) := 'update emp set sal = sal + 0.1*sal where ename like ''A%'' or ename like ''S%''';
begin
  execute immediate v_sql;
  end;
  
  select * from emp;
  
12、两重循环，计算S=1!+2!+…+10!。

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
--声明一个变量保存阶乘结果
m number := 1;
--声明一个变量保存表达式结果
s number := 0;
begin
  for i in 1..10 loop;
  m := 1;
  for j in 1..i loop;
  -- 初始化变量m
  m := m*n;
  -- 计算表达式结果
  s := s + m;
  end loop;
  s := s+m;
  end loop;
  -------------------
  declare
  
  -- 声明一个变量保存阶乘的结果
  m number := 1;
  -- 声明一个变量保存表达式的结果
  s number := 0; 
  begin
    for n in 1..10 loop
      -- 声明一个变量保存阶乘的结果
      m := m*n;
      -- 计算阶乘
      s := s+m;
      end loop;
      dbms_output.put_line(s);
    end;
   
   
