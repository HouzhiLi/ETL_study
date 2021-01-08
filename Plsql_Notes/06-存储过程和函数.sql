存储过程
存储过程：它是一个有名字的PLSQL代码块，用来实现某个业务或功能。
   可以有参数，也可以没有参数，只能在plsql代码块中使用，不能在sql语句中使用
   没有返回值，但是有输出参数，它的参数有三种类型：输入参数，输出参数，输入输出参数
   
存储过程的创建语法：
create [or replace] procedure 存储过程名[(参数 in|out|in out 参数的数据类型[:=默认值],...)]
is
   --声名部分
begin
   --代码块
   --异常处理代码
end;

procedure:存储过程关键字
存储过程名:需要符合标识符命名规范
in|out|in out:分别表示输入|输出|输入输出

create or replace procedure p1
is
begin
   dbms_output.put_line('Hello PLSQL');
end;

存储过程的调用方法：
1.在代码块中调用
begin
   存储过程名[(参数)];
end;

begin
  p1;
end;
begin
  p1();
end;
2.使用call（sql命令）命令调用
call 存储过程名([参数]);

call p1();

3.使用exec(sqlplus命令)命令调用
exec 存储过程名([参数]);

exec p1();

(1)in参数
in输入参数：它不在程序块中修改，可以以任意方式值参（3种传参方式都可以）,它关键字可以省略不写

--写一个存储过程，传入一个部门编号，根据部门编号查询部门下的员工，并打印员工信息
create or replace procedure p2(dno in number)
is
begin
   for v in (select * from emp where deptno=dno) loop
      --打印员工信息
      dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   end loop;
end;

begin
  p2(10); 
end;

declare
   --声名一个变量保存部门编号
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
   --修改dno的值
   ---dno:=20;  in 类型参数不可以修改
   for v in (select * from emp where deptno=dno) loop
      --打印员工信息
      dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   end loop;
end;

create or replace procedure p2(dno number)
is
begin
   --修改dno的值
   ---dno:=20;  in 类型参数不可以修改
   for v in (select * from emp where deptno=dno) loop
      --打印员工信息
      dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.sal||','||v.deptno);
   end loop;
end;

(2)out参数
out输出参数：参数值在程序中可以修改，必须以传变量的方式传参，将程序的运行结果传外部程序使用

--写一个存储过程，根据传入部门编号，根据部门编号查询出员工的人数
create or replace procedure p3(dno number,n out number) --dno是一个输入参数   n表示一个输出参数
is

begin
   select count(*) into n from emp where deptno=dno;
end;

declare
  --声名一个变量保存员工人数
  s number;
begin
  p3(20,s);   --out参数将数据传外部调用程序
  --打印s的值
  dbms_output.put_line(s);
end;

（3）in out参数
in out输入输出参数：结合了in和out参数的特点，在程序中可以修改它的值，传参时只能以变量的方式传参

--写一个存储过程，根据员工编号，查询员工信息，并将员工信息，传给外部程序
create or replace procedure p4(eno in number,v out emp%rowtype)
is
begin
  select * into v from emp where empno=eno;
end;
select * from emp;
declare
   --声名一个记录类型变量
   e emp%rowtype;
begin
   p4(7499,e);
   --打印员工信息
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
    --打印员工信息
   dbms_output.put_line(e.empno||','||e.ename||','||e.job||','||e.mgr||','||e.sal||','||e.deptno);
end;

in参数：传入一个不可变数据，调用时必须要有值（值在代码中被使用到，数据是有意义）
out参数：传入一个空变量，没有数据
in out参数：传入一个变量，变量中有数据，数据被使用到


--写一个存储过程，根据部门编号查询部门下的人数
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

2.函数
函数：是一个有名字的plsql代码块，用来实现数学计算或功能的.它有返回值，在使用时
必须使用到返回值，参数类型有in,out,in out,可以在sql语句中使用，还可以在plsql代码块中使用

函数的定义语法：
create [or replace] function 函数名(参数 in|out|in out 数据类型[:=默认值])
return 返回值类型
is
   --声名部分
begin
   --代码块
   return语句;
   --异常处理
end;

--创建一个函数，传入矩形的长和宽，计算矩形的面积
create or replace function fn1(w in number,h number)
return number
is
   --声名一个变量保存矩形的面积
   s number;
begin
   s:=w*h;
   --返回结果
   return s;
end;

函数的调用（必须使用到返回值）：
（1）在sql中调用
select fn1(3,4) from dual;

(2)在plsql中调用（必须使用返回值）
declare
  --声名一个变量
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
    dbms_output.put_line('矩形的面积大于10');
  end if;
end;


--写一个函数，传入一个员工编号，如果员工的工资小于2000,那么给员工加薪500，函数返回1;
--  如果员工工资大于等于2000，不给他加薪 函数返回0

--返回1或0
状态值：
--1表示给员工加薪了
--0表示没有加薪

--执行update语句
create or replace function fn2(eno number)
return number
is
   --声名一个变量保存员工的工资
   v_sal number;
begin
   select sal into v_sal from emp where empno=eno;
   --判断工资是否小于2000
   if v_sal<2000 then
      --如果工资小于2000给他加薪500
      update emp set sal=sal+500 where empno=eno;
      return 1;
   else
      --工资大于2000,不加薪，返回0
      return 0;
   end if;
end;
--selec语句中调用的函数不能使用dml操作
begin
   if fn2(7566)=1 then
      dbms_output.put_line('加薪');
   else
      dbms_output.put_line('未加薪');
   end if;
end;



select * from emp;


--函数的递归调用（自已调用自已）
--写一个函数，计算一个数的阶乘 
create or replace function fn3(n number)
return number
is
   --声名一个变量保存阶乘结果
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
     1    n=5     n<=2不成立   n*fn4(n-1)=5*fn4(4)=5*4*fn4(3)=5*4*3*fn4(2)=5*4*3*2
            fn4(4)   n=4     n<=2不成立  n*fn4(n-1)=4*fn4(3) =4*3*fn4(2)=4*3*2 
            fn4(3)   n=3     .........   n*fn4(n-1)=3*fn4(2)=3*2
            fn4(2)   n=2     条件成立   返回 n  2
     
  
  */
  if n<=2 then
    --如果n小于等于2时，阶乘等于n本身
    return n;
  else
    return n*fn4(n-1);
  end if;
end;

递归调用：必须有一个临界条件，当前条件满足时，返回一个固定的值
          其次他做的事必须有一个规律
 

select fn4(6) from dual;
