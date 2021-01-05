1.流程控制语句
(1) if语句
语法：
if 条件表达式; then
  plsql 语句（sql语句和流程控制语句）
  end if
  当条件表达式成立时，运行then和end之间的代码
  --判断表是否存在，如果不存在，则创建表
  --如果表不存在，创建一张dept_sum表，汇总部门下的人数，平均工资，总工资，最高工资，最低工资
declare
--声明一个变量保存查询结果
n number(1); 
begin
  --判断数据库中是否存在dept_sum这张表
  --通过查询数据库字典视图判断
  --select count(table_name) from user_tables where table_name = 'dept_num'; --如果>0表示表存在
  select count(1) into n from user_tables where table_name = 'dept_sum';
  if n = 0 then 
    --创建dept_sum表
    execute immediate 'create table dept_sum(deptno number, member number, avg_sal number(8,2), sum_sal number(8,2), max_sal number(8,2), min_sal number(8,2))';
  end if;
  --如不存在，则创建表
  --向表中添加一个数据
  execute immediate 'insert into dept_sum select deptno, count(1), avg(sal), sum(sal), max(sal), min(sal) from emp group by deptno'; 
  end;
(2) if else
语法
if 条件表达式 then
  plsql 语句
  else
    plsql语句
    end if;
    --写一个代码，输入两个值，比较大小，打印较大值
    declare
    --声明两个变量分别保存输入的两个值
    m number := &m;
    n number := &n;
    begin
      if m > n then
        dbms_output.put_line(m);
        else
          dbms_output.put_line(n);
          end if;
          end;
          
(3) if elsif
语法
if 条件表达式 then
  plsql语句
  elsif 条件表达式 then
    plsql语句
    elsif 条件表达式 then
      ...
      else
        plsql语句
        end if；
        表示当一个条件成立时，执行相应的then后面的代码
        --输入一个成绩，根据成绩来判断优良中差
        --60以下 差
        --60-70 中
        --70-80 良
        --80以上 优
        declare
        --声明一个变量保存输入的值
        score number(4,1) := &score;
        begin
          if score < 60 then
            dbms_output.put_line('差');
            elsif score >= 60 and score <70 then
              dbms_output.put_line('中');
              elsif score >= 70 and score < 80 then
                dbms_output.put_line('良');
                else
                  dbms_output.put_line('优');
                  end if;
                  end;
        
(4) case 语句
语法：
case 
  when 条件表达式 then
    plsql语句;
     when 条件表达式 then
    plsql语句;
    ...
    else
      plsql语句
      end case;
语法2：
case 表达式
  when 结果1 then
    plsql sentances;
    when res2 then
      plsql sentances;
      ...
      else
        plsql sentances;
        end case;
        similar to decode funcation: --表达式返回一个固定的结果，当前置结果和后置when所列举的结果相同时，执行对应的 plsql语句
declare
--
score number(4,1) := &sc;
begin
  case when score < 60 then
    dbms_output.put_line('d');
    when score < 70 then 
      dbms_output.put_line('c');
      when score < 80 then
        dbms_output.put_line('b');
        else
          dbms_output.put_line('a');
          end case;
          end;     
-- 能否将上面的代码用case的第二种语法来写
floor(score/10)
0-60      0,1,2,3,4,5         差
60-70    6                        中
70-80   7                         良
80-100  8, 9, 10               优

declare 
score number(4,1) := &sc;
begin
  case floor(score/10)
    when 10 then
      dbms_output.put_line('a');
      when 9 then
        dbms_output.put_line('a');
        when 8 then
          dbms_output.put_line('a');
          when 7 then
            dbms_output.put_line('b');
            when 6 then
              dbms_output.put_line('c');
              else
                dbms_output.put_line('d');
                end case;
                end;
(5) loop
语法：
循环是相同或相似的代码重复执行
loop
  循环体语句;
  退出循环语句;
  循环控制语句;
  end loop;
循环体语句是用来实现主要功能和业务的代码
退出循环语句：用来设置循环次数
循环控制语句：保证循环可以正常退出
--打印1-9
循环体代码：dbms_output.put_line();

declare
n number := 1;
begin
loop
      dbms_output.put_line(n);
      exit when n = 9;
      n := n+1;
      end loop;
      end;
      
(6)while
语法：
while 循环条件 loop
  循环体语句;
  循环控制语句;
  end loop
  
  declare 
  n number := 1;
  begin
    while n <= 9 loop
      dbms_output.put_line(n);
      n := n+1;
      end loop;
      end; 
      
(7)for
语法：
for 循环变量 in [reverse] 集合|游标|select语句 loop
  --循环体语句
  end loop;
  
  reverse：表示反转
  集合：表示简单的连续的数字集合 1-9 1..9 表示简单的 1-9 的数字集合

begin
  for n in 1..9 loop
    dbms_output.put_line(n);
    end loop;
    end;
    for循环，适用于遍历有固定边界，n循环变量没有在declare部分声明所以只能在for循环中使用

begin 
  for n in reverse 1..9 loop
    dbms_output.put_line(n);
    end loop;
    end;    

--写一个代码块，利用佛如循环，遍历emp表中10号部门的所有员工信息
begin 
  for v /* 记录类型*/ in (select * from emp where deptno = 10) loop
    dbms_output.put_line(v.empno || ', ' || v.ename);
    end loop;
    end;
    
loop: 需要声明循环变量，变量可以在代码的任意地方使用（循环内外）
条件：退出循环条件
需要循环控制语句
while: 需要声明循环变量，变量可以在代码的任意地方使用（循环内外）
条件：循环条件
需要循环控制语句
for：循环变量不需要声明，只能在循环内使用变量，当便利一个数字集合时，循环变量是一个普通变量，当遍历一个select语句时，循环变量是一个记录类型
条件：不需要条件
不需要循环控制语句
for循环可以遍历select语句的查询结果集

exit：在循环中用来退出循环的语句

begin
  for n in 1..9 loop
    --当n=5时执行exit
    if n = 5 then 
      exit;
      end if;
      dbms_output.put_line(n);
      end loop;
       dbms_output.put_line('----');
      end;
      --1, 2, 3, 4, ----
      
continue：退出本次循环，继续下一次循环

begin
  for n in 1..9 loop
    --当n=5时执行exit
    if n = 5 then 
      continue;
      end if;
      dbms_output.put_line(n);
      end loop;
       dbms_output.put_line('----');
      end;
      --1, 2, 3, 4, 6, 7, 8, 9, ----
      
return：表示结束程序(return后面的代码都不会执行)

begin
  for n in 1..9 loop
    --当n=5时执行exit
    if n = 5 then 
      return;
      end if;
      dbms_output.put_line(n);
      end loop;
       dbms_output.put_line('----');
      end;
      -- 1, 2, 3, 4
      
null：空语句

--思考题：使用loop和while循环来实现上面for循环的效果

dbms_output.put_line(); 打印并换行
dbms_output.put('\n'); 打印但不换行，必须换行才能显示
dbms_output.newline(); 换行
