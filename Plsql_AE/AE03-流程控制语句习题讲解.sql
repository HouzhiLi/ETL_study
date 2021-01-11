1-键盘接入两个值，打印比较大的值
declare
  --声名两个变量保存输入的值
  m number:=&m;
  n number:=&n;
begin
  if m> n then
    dbms_output.put_line(m);
  else
    dbms_output.put_line(n);
  end if;
end;

2-键盘介入三个值，并按照从大到小依次打印
declare
   --声名三个变量保存三个值
   x number:=&x;
   y number:=&y;
   z number:=&z;
begin
   if x>=y and y>=z then
     dbms_output.put_line('x='||x||',y='||y||',z='||z);
   elsif x>=z and z>=y then
     dbms_output.put_line('x='||x||',z='||z||',y='||y);
   elsif y>=x and x>=z then
     dbms_output.put_line('y='||y||',x='||x||',z='||z);
   elsif y>=z and z>=x then
     dbms_output.put_line('y='||y||',z='||z||',x='||x);
   elsif z>=x and x>=y then
     dbms_output.put_line('z='||z||',x='||x||',y='||y);
   else
     dbms_output.put_line('z='||z||',y='||y||',x='||x);
   end if;
end;
  

declare
   --声名三个变量保存三个值
   x number:=&x;
   y number:=&y;
   z number:=&z;
begin
   --x和y
   if x>y then
     --x>y
     --x和z比较取最大值
     if x>z then
        --x>y  x>z  比较 y和z
        if y>z then
            --x>y x>z y>z --x>y>z
            dbms_output.put_line('x='||x||',y='||y||',z='||z);
        else
            --x>y x>z  z>y  --x>z>y
            dbms_output.put_line('x='||x||',z='||z||',y='||y);
        end if;
     else
        --x>y  z>=x  z>x>y
        dbms_output.put_line('z='||z||',x='||x||',y='||y);
     end if;
   else
      --y>=x  比较 y和z取最大值
      if y>z then
        --y>z y>=x 比较 x和z
        if x>z then
          --y>z y>x x>z  y>x>z
          dbms_output.put_line('y='||y||',x='||x||',z='||z);
        else
          --y>z y>x z>x  y>z>x
          dbms_output.put_line('y='||y||',z='||z||',x='||x);
        end if;
      else
        --z>=y  y>=x   z>y>x
        dbms_output.put_line('z='||z||',y='||y||',x='||x);
      end if;
   end if;
end; 

declare
   --声名三个变量保存三个值
   x number:=&x;
   y number:=&y;
   z number:=&z;
begin
   ---建一张表将三个值保存
   --利用sql的排序功能排序
   --删除这张表
   for v in  (select * from 
   (select 'x' s,x n from dual 
   union all 
   select 'y' s,y n from dual 
   union all 
   select 'z' s,z n from dual) order by n desc) loop
      dbms_output.put_line(v.s||'='||v.n);
   end loop;
end;

select * from (
select 'x' s, 1 n from dual
union all
select 'y' s, 2 n from dual
union all
select 'z' s, 3 n from dual)
order by n desc;

create table tt(
  name varhcar2(2),
  n number(10)
);




4-判断一个年份是不是闰年
润年：能被4整除但不能被100整除   或者被400整除
declare
   --声名一个变量保存一个年份
   n number(4):=&年;
begin
   if (mod(n,4)=0 and mod(n,100)!=0) or mod(n,400)=0 then
       dbms_output.put_line(n||'是闰年');
   else
       dbms_output.put_line(n||'不是闰年');
   end if; 
end;


5-体质指数（BMI）=体重（kg）÷身高^2（m）

偏瘦  <= 18.4
正常  18.5 ~ 23.9
过重  24.0 ~ 27.9
肥胖  >= 28.0
现要求输入体重和身高，求出体质指数所在范围

declare
   --声名三个变量，分别保存体重，身高，体制指数
   w number(4,1):=&体重;
   h number(3,2):=&身高;
   
   s number(4,2);
begin
   --计算体质指数
   s:=w/(h*h); --w/h/h  w/power(h,2)
   --根据条件判断身体状况
   if s<=18.4 then
     dbms_output.put_line('偏瘦');
   elsif s<=23.9 then
     dbms_output.put_line('正常');
   elsif s<=27.9 then
     dbms_output.put_line('过重');
   else
     dbms_output.put_line('肥胖');
   end if;
   
end;

6-输入一个数，判断是奇数还是偶数
declare
   --声名一个变量保存输入的值
   n number:=&数;
begin
   if mod(n,2)=0 then
      dbms_output.put_line(n||'是偶数');
   else
      dbms_output.put_line(n||'是奇数');
   end if;
end;

1.编写一个程序块，从emp表中显示名为“SMITH”的雇员的薪水和职位
declare
   --声名两个变量保存查询结果
   v_sal emp.sal%type;
   v_job emp.job%type;
begin
   select sal,job into v_sal,v_job from emp where ename='SMITH';
   --打印结果
   dbms_output.put_line(v_sal||','||v_job);
end;

begin
   for v in (select sal,job from emp where ename='SMITH' ) loop
     dbms_output.put_line(v.sal||','||v.job);
   end loop;
end;

2.编写一个程序块，接受用户输入一个部门号，从dept表中显示该部门的名称与所在位置

declare
  --声名一个变量保存部门编号
  dno number:=&部门编号;
  --声名一个变量保存部门信息
  v dept%rowtype;
begin
  select * into v from dept where deptno=dno;
  --打印结果
  dbms_output.put_line(v.dname||','||v.loc);
end;


3.编写一个程序块，利用%type属性，接受一个雇员号，从emp表中显示该雇员的整体薪水(即，薪水加佣金)
declare
   --声名一个变量保存员工编号
   eno number:=&员工编号;
   --声名一个变量保存员工的整体薪水
   v_salary number;
begin
   select sal+nvl(comm,0) into v_salary from emp where empno=eno;
   --打印结果
   dbms_output.put_line(v_salary);
end;

declare
   --声名一个变量保存员工编号
   eno number:=&员工编号;
   --声名一个变量保存员工的整体薪水
   v_salary number;
   v_comm number;
begin
   select sal,nvl(comm,0) into v_salary,v_comm from emp where empno=eno;
   --打印结果
   dbms_output.put_line(v_salary+v_comm);
end;


4.编写一个程序块，利用%rowtype属性，接受一个雇员号，从emp表中显示该雇员的整体薪水

declare
   --声名一个emp%rowtype类型变量
   v emp%rowtype;
begin
   --接收一个员工编号
   v.empno:=&员工编号;
   select sal+nvl(comm,0) into v.sal from emp where empno=v.empno;
   
   dbms_output.put_line(v.sal);
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
   --声名一个变量接收一个员工姓名
   v_ename emp.ename%type:='&员工姓名';
begin
   update emp set sal=case 
         when job=upper('clerk') then sal+500 
         when job=upper('salesman') then sal+1000
         when job=upper('analyst') then sal+1500
         else
           sal+2000
         end  where ename=v_ename; 
          
end;

select * from emp;
select 'drop trigger '||object_name||';' from user_objects where object_type='TRIGGER';

declare

begin
   update emp set sal=sal+500 where ename='&员工姓名' and job=upper('clerk');
   update emp set sal=sal+1000 where ename='&员工姓名' and job=upper('salesman');
   update emp set sal=sal+1500 where ename='&员工姓名' and job=upper('analyst');
   update emp set sal=sal+2000 where ename='&员工姓名' and job not in (upper('analyst'),upper('salesman'),upper('clerk'));
end;


declare
   --声名一个变量保存员工信息
   v emp%rowtype;
begin
   --根据员工姓名查询员工信息
   select * into v from emp where ename='&员工姓名';
   --使用if进行判断
   if v.job=upper('clerk') then
      update emp set sal=sal+500 where empno=v.empno;  
   elsif v.job=upper('salesman') then
      update emp set sal=sal+1000 where empno=v.empno;
   elsif v.job=upper('analyst') then
      update emp set sal=sal+1500 where empno=v.empno;
   else
      update emp set sal=sal+2000 where empno=v.empno;
   end if;
   
end;

declare
   --声名一个变量保存员工信息
   v emp%rowtype;
begin
   --根据员工姓名查询员工信息
   select * into v from emp where ename='&员工姓名';
   --使用if进行判断
   if v.job=upper('clerk') then
      v.sal:=v.sal+500;
   elsif v.job=upper('salesman') then
      v.sal:=v.sal+1000;
   elsif v.job=upper('analyst') then
      v.sal:=v.sal+1500;
   else
      v.sal:=v.sal+2000;
   end if;
   update emp set sal=v.sal where empno=v.empno;
   
end;



drop trigger T8;
drop trigger T7;
drop trigger T6;
drop trigger T5;
drop trigger T4;
drop trigger T3;
drop trigger T2;
drop trigger T1;



13.编程序求满足不等式 1+3^2+5^2+…+N^2>2000的最小N值。
+
1   1^2   power(n,2)
3   3^2   power(n,2)
5   5^2   power(n,2)
s:=0;

s:=s+pwer(n,2)


declare
   --声名一个变量n ,循环变量
   n number:=1;
   
   --声名一个变量s，保存表达式的求和结果 
   s number:=0;
begin
   /**
     n=1 s=0
     
     1   n=1    s=s+power(n,2)0+1=1    s>2000条件不成立   n=n+2=3
     2   n=3    s=s+power(n,2)1+3^2    s>2000。。。。。   n=n+2=5
     3   n=5    ...................    ...............    n=n+2=7
     ....
     
     假设n=x的时候退出循环
         n=x-2  s=1+....(x-2)^2        ...............    n=n+2=x
         n=x    s=1+........x^2        s>2000成立退出循环
     
   */
   loop
      --循环体语句
      s:=s+power(n,2);
      --退出循环语句
      exit when s>2000;
      --循环控制语句
      n:=n+2;
   
   end loop;
   
   dbms_output.put_line(n);
end;

declare
   --声名一个变量n ,循环变量
   n number:=1;
   
   --声名一个变量s，保存表达式的求和结果 
   s number:=0;
begin
   /**
      n=1  s=0
      
      1  n=1   s<2000   s=s1         n=n+2=3
      2  n=3   s1<2000  s=s1+s3      n=n+2=5
      3  n=5   s1+s3<2000   s=s1+..s5  n=7
      ....
      设置到x时值刚好小于2000  x+2
      
         nx   s1+..+sx-2 <2000   s=s1+...sx  n=x+2
         x+2  s1+..+sx<2000     s=s1+sx+2    n=x+4
         x+4  s1+s2+..sx+2退出
   */
   while s<=2000 loop
      --循环体语句
      s:=s+power(n,2);  --1.  power(1,2)
      --循环控制语句
      n:=n+2;
   
   end loop;
   dbms_output.put_line(n-2);
end;

declare
   s number:=0;
   --声名一个变量保存n的值
   i number;
begin
  /**
    1    n=1   s=s1     s>2000    i=n=1
    2    conitnue;
    3    n=3   s=s1+s3  s>2000    i=3
    .....
        假设 n=x时 s1+s3....sx>2000
        n=x-2  s=s1+s3...+sx-2    s1+s3+...+sx-2<2000   i=x-2
        n=x    s=s1+...+sx        s1+s3....+sx>2000退出   
  */
  for n in 1..50 loop
     if mod(n,2)=0 then
        continue;
     end if; 
     --循环体语句
      s:=s+power(n,2);
      --退出循环语句
      exit when s>2000;
      --赋值
      i:=n;
  end loop;
  dbms_output.put_line(i+2);
end;



14.将雇员表中的所有工资小于3000增加400，统计出增加工资的人数及增加的工资数量。
declare
  --声名一个变量保存员工人数
  n number;
begin
   --查询工资小于3000的人数
   select count(1) into n from emp where sal<3000;
   --给小3000的人加400
   update emp set sal=sal+400 where sal<3000;
   --打印结果
   dbms_output.put_line('人数：'||n||',工资数量：'||(n*400));
end;

declare
   --声名一个变量，用来统计人数
   n number:=0;
begin
   for v in (select * from emp where sal<3000) loop
      --人数+1
      n:=n+1;
      update emp set sal=sal+400 where empno=v.empno;
   end loop;
   dbms_output.put_line('人数：'||n||',工资数量：'||(n*400));
end;


begin
   update emp set sal=sal+400 where sal<3000;
   dbms_output.put_line('人数：'||sql%rowcount||',工资数量：'||(sql%rowcount * 400));
end;

15.从雇员表中显示工资最高的前五个人的姓名，部门和工资。

begin
   for v in (select * from (select * from emp order by sal desc) where rownum<=5) loop
     
     dbms_output.put_line(v.ename||','||v.deptno||','||v.sal);
   end loop;
end;

declare
   n number:=0;
begin
   /**
    n=0
    1   n=n+1=0+1=1    打印
    2   n=n+1=2        ...
    ....
    5   n=n+1=5        打印   
   */
   for v in (select empno,ename,job,mgr,sal,hiredate,comm,deptno from emp order by sal desc) loop
     n:=n+1;
     dbms_output.put_line(v.ename||','||v.deptno||','||v.sal);
     exit when n=5;
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
   for v in (select ename from emp where rownum<=5) loop
     dbms_output.put_line(v.ename);
   end loop;
end;


8.接受两个数相除并且显示结果，如果第二个数为0，则显示消息“除数不能为0”
declare
   --声名两个变量，分别保存被除数和除数
   m number:=&被除数;
   n number:=&除数;
begin
   if n=0 then
     dbms_output.put_line('除数不能为零');
   else
     dbms_output.put_line(m/n);
   end if;
end;

9、计算下面级数当末项小于0.001时的部分和。 
1/(1*2)+1/(2*3)+1/(3*4)+…+1/(n*(n+1))+ ……
declare
   --声名一个变量保存每一项的值 1/(n*(n+1))
   s number;
   --声名一个变量保存，保存表达式的和  1/(1*2) +...1/(n*(n+1))
   t number:=0; 
   --声名一个循环变量n
   n number:=1;
begin
   /**
     s=?    t=0   n=1
     
     1  n=1    s=s1     t=t+s=s1    s1<0.001条件不成立    n=n+1
     2  n=2    s=s2     t=s1+s2     s2<...............    n=n+1=3
     3  n=3    s=s3     t=s1+s2+s3  s3<..............     ......
     .........
     假设n=x  sx<0.001
        n=x-1  s=sx-1   t=s1+..sx-1  sx-1 不成立          n=n+1=x
        n=x    s=sx     t=s1+....sx  sx<0.001 成立退出
   
   */
   loop
      --循环体语句 ，计算每项的值 s的值
      s:=1/(n*(n+1));
      t:=t+s;
      --退出循环语句
      exit when s<0.001;
      --循环控制语句
      n:=n+1;
   end loop;
   
   dbms_output.put_line(t);
end;


10、计算s=1*2+2*3+…+N*(N+1),当N=50的值。
declare
   --声名一个变量保存表式的结果
   s number:=0;
begin
   for n in 1..50 loop
     --循环体语句
     s:=s+n*(n+1);
   end loop;
   --打印结果
   dbms_output.put_line(s);
end;

11.编写一个PL/SQL程序块，从emp表中对名字以“A”或"S"开始的所有雇员按他们基本薪水的10%给他们加薪
begin
  update emp set sal=sal*1.1 where ename like 'A%' or ename like 'S%';
end;

begin
   for v in (select * from emp where ename like 'A%' or ename like 'S%') loop 
     update emp set sal=sal*1.1 where empno=v.empno;
   end loop;
end;

begin
   for v in (select * from emp) loop
     if instr(v.ename,'A')=1 or instr(v.ename,'S')=1 loop
       update emp set sal=sal*1.1 where empno=v.empno;
     end if;
   end loop;
end;

12、两重循环，计算S=1!+2!+…+10!。!表示阶乘
5！=5*4*3*2*1
declare
  --声名一个变量保存阶乘结果
  m number:=1;
begin
  for n in 1..5 loop
     m:=m*n;
  end loop;
end; 
declare
  --声名一个变量保存阶乘 结果
  m number:=1;
  --声名一个变量保存表达式的结果
  s number:=0;
begin
  /**
    外1 
       1      i =1   m=1
                        内 for j in 1..1 loop
                         1    m:=m*j 1*1=1!
                     
                        s=s+m=0+1=1!
       2      i=2    m=1
                        内  for j  in 1..2 loop
                        1  j=1  m=m*j=1*1
                        2  j=2 m=m*j=1*2=2！
                        s=s+m=1!+2!
       3      i=3    m=1
                        内  for j in 1..3 loop
                        
                        1  j=1  m=m*j=1*1
                        2  j=2  m=m*j=1*2
                        3  j=3  m=m*j=1*2*3=3！
                        s=s+m=1!+2!+3!
  
  
  */  


  for i in 1..10 loop
    ---初始化变量m
    m:=1;
    for j in 1..i loop
      m:=m*j;
    end loop;
    --计算表达式的结果
    s:=s+m;
  end loop;
  
  dbms_output.put_line(s);
end;

declare
   --声名一个变量保存表达式的结果
   s number:=0;
   --声名一个变量保存阶乘的结果
   m number:=1;
begin
   /**
     s=0  m=1
     
     1  n=1   m=m*n=1*1=1!   s=s+m=0+1!=1!
     2  n=2   m=m*n=1!*2=2!  s=s+m=1!+2!
     3  n=3   m=m*n=2!*3=3!  s=s+m=1!+2!+3!
     4  n=4   m=m*n=3!*4=4!  s=s+m=1!+2!+3!+4!
   */
   for n in 1..10 loop
     --计算阶乘 
     m:=m*n;
     --计算表达式的结果
     s:=s+m;
   end loop;
   dbms_output.put_line(s);
end;



打印9*9乘法表

1*1=1
1*2=2 2*2=4
。。。。。。。。。

                     1*1=1
               1*2=2 2*2=4
               
begin
   --外层循环表示行
   for i in 1..9 loop
     --内层循环表示列
     for j in 1..i loop
        dbms_output.put(rpad(j||'*'||i||'='||(i*j)||' ',7,' '));
     end loop;
     --换行
     dbms_output.put_line(''); --dbms_output.new_line();
   end loop;
end;

                                                        1*1=1   1  8*7
                                                 1*2=2  2*2=4   2  7*7
                                          1*3=3  2*3=6  3*3=9   3  6*7
                                   1*4=4  2*4=8  3*4=12 4*4=16  4  5*7
                            1*5=5  2*5=10 3*5=15 4*5=20 5*5=25  5  4*7
                     1*6=6  2*6=12 3*6=18 4*6=24 5*6=30 6*6=36  6  3*7
              1*7=7  2*7=14 3*7=21 4*7=28 5*7=35 6*7=42 7*7=49  7  2*7
       1*8=8  2*8=16 3*8=24 4*8=32 5*8=40 6*8=48 7*8=56 8*8=64  8  1*7
1*9=9  2*9=18 3*9=27 4*9=36 5*9=45 6*9=54 7*9=63 8*9=72 9*9=81  9  0*7

begin
   --外层循环表示行
   for i in reverse 1..9 loop
     --打印空格
     /*
     for j in  1..(9-i)*7 loop
       dbms_output.put(' ');
     end loop;
     */
     dbms_output.put(rpad(' ',((9-i)*7),' '));
     --内层循环表示列
     for j in 1..i loop
        dbms_output.put(rpad(j||'*'||i||'='||(i*j)||' ',7,' '));
     end loop;
     --换行
     dbms_output.put_line(''); --dbms_output.new_line();
   end loop;
end;
                     *       空格
     *        1      1        5
    ***       2      3        4
   *****      3      5        3
  *******     4      7        2
 *********    5      9        1
***********   6      11       0
                    2n-1     6-n
                    
                    
begin
  --控制行数
  for i in 1..6 loop
    --打印空格
    for j in 1..6-i loop
      dbms_output.put(' ');
    end loop;
    --打印*
    for j in 1..(2*i-1) loop
      dbms_output.put('*');
    end loop;
    --换行
    dbms_output.new_line();
  end loop;
end;

declare
  --声名一个变量保存行数
  n number:=&行数;

begin
  --控制行数
  for i in 1..n loop
    --打印空格
    for j in 1..n-i loop
      dbms_output.put(' ');
    end loop;
    --打印*
    for j in 1..(2*i-1) loop
      dbms_output.put('*');
    end loop;
    --换行
    dbms_output.new_line();
  end loop;
end;


                     *       空格
     *        1      1        5
    * *       2      3        4
   *   *      3      5        3
  *     *     4      7        2
 *       *    5      9        1
* * * * * *   6      11       0
                    2n-1     6-n


begin
  --控制行数
  for i in 1..6 loop
    --打印空格
    for j in 1..6-i loop
      dbms_output.put(' ');
    end loop;
    --打印*
    for j in 1..(2*i-1) loop
      --处理第一行
      if i=1 then
        dbms_output.put('*');
      elsif i=6 then
        --奇数打印*,偶数打印空格
        if mod(j,2)=1 then
          --处理最后一行
          dbms_output.put('* ');
        end if;
      else
        --处理其他行
        if j=1 or j=(2*i-1) then
          dbms_output.put('*');
        else
          dbms_output.put(' ');
        end if;
      end if;      
    end loop;
    --换行
    dbms_output.new_line();
  end loop;
end;

declare
  n number:=&行数;
begin
  --控制行数
  for i in 1..n loop
    --打印空格
    for j in 1..n-i loop
      dbms_output.put(' ');
    end loop;
    --打印*
    for j in 1..(2*i-1) loop
      --处理第一行
      if i=1 then
        dbms_output.put('*');
      elsif i=n then
        --奇数打印*,偶数打印空格
        if mod(j,2)=1 then
          --处理最后一行
          dbms_output.put('* ');
        end if;
      else
        --处理其他行
        if j=1 or j=(2*i-1) then
          dbms_output.put('*');
        else
          dbms_output.put(' ');
        end if;
      end if;      
    end loop;
    --换行
    dbms_output.new_line();
  end loop;
end;

