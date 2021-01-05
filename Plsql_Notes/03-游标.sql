游标
游标：oracle在运行sql语句时，会给sql语句分配一个缓冲区，游标是指向这个缓冲区的一个地址
      游标可以获取到sql语句的执行结果,分为隐式游标和显示游标
游标属性：
%found:布尔类型，当游标当前指向的数据不为空时，返回true,否则返回false
%notfound:布尔类型，和%found相反，当游标指向的数据为空时，返回true 否则返回false
%isopen:布尔类型，当前游标打开时返回true，游标未打开时返回false
%rowcount:数字类型，返回游标的当前记录数，可以用来获取游标中的记录条数，也可以用来记录游标当前数据的行号

游标的使用步骤：
未打开时 %isopen = false
%rowcount,%found和%notfound的值无效
1.打开游标
%isopen=true
%rowcount=0
%found和%notfound的值无效
open 游标名称|游标变量
2.使用游标
fetch 游标 into 变量;
游标中有数据时
%found=true
%notfound=false
%rowcount的值，会逐个增加+1
游标取到最后一条数据之后
%found=false
%notfound=true
%rowcount的值表示数据条数
3.关闭游标
close 游标
%found,%notfound,%rowcount不可以用
%isopen=false

select * from emp;

1）隐式游标
在执行dml语句（insert,update,delete）时，oracle给了一个叫sql的游标，可以使用sql调用%rowcount属性，
获取增删改语句修改的数据库数据条数
sql%rowcount
begin
  update emp set sal=sal+500 where sal<3000;
  dbms_output.put_line(sql%rowcount);
end;
2）显式游标
显式游标是针对select语句
游标的定义语法：
cursor 游标 is select语句;
打开游标
open 游标
遍历游标（使用fetch into语句）
fetch 游标 into 变量
关闭游标
close 游标

遍历：loop循环,while循环，for循环

declare
   --定义一个游标
   cursor cur is select * from dept;
   --%rowtype   dept%rowtype  cur%rowtype
   v cur%rowtype;
   
begin
   --打开游标
   open cur;
   --未执行fetch into前%found和%notfound不可用
   if cur%found then
     dbms_output.put_line('true');
   end if;
   if cur%notfound then
     dbms_output.put_line('true');
   end if;
   dbms_output.put_line(cur%rowcount); ---打印0
   --遍历
   dbms_output.put_line('-----------------------------------------');
   fetch cur into v;
   if cur%found then
     dbms_output.put_line('true1');  --打印true
   end if;
   if cur%notfound then
     dbms_output.put_line('true2');
   end if;
   dbms_output.put_line(cur%rowcount);
   dbms_output.put_line('-----------------------------------------');
   fetch cur into v;
   fetch cur into v;
   fetch cur into v;
   fetch cur into v;
   if cur%found then
     dbms_output.put_line('true3'); 
   end if;
   if cur%notfound then
     dbms_output.put_line('true4'); --处理完所有数据之后，%notfound=true
   end if;
   dbms_output.put_line(cur%rowcount); --表示的是数据总条数
   --关闭游标
   close cur;
  
end;

declare
   --定义一个游标
   cursor cur is select * from dept;
   --声名一个变量保存游标中的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --取游标中的数据，fetch into
   fetch cur into v;
   --数据处理
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
      --取游标中的数据，fetch into
   fetch cur into v;
   --数据处理
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
      --取游标中的数据，fetch into
   fetch cur into v;
   --数据处理
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
      --取游标中的数据，fetch into
   fetch cur into v;
   --数据处理
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
   --关闭游标
   close cur;
end;
begin
  for v in (select * from dept) loop
    dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
  end loop;
end;

--loop循环遍历游标
declare
   --定义一个游标
   cursor cur is select * from emp;
   --声名一个变量保存游标的一条记录
   v cur%rowtype;
begin
   --打开游标
   open cur;
   --遍历
   loop
      --执行fetch into语句
      fetch cur into v;
      --判断退出条件
      exit when cur%notfound;
      --循环体代码，实现功能的代码
      dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
      
   end loop;
   dbms_output.put_line('数据总条数：'||cur%rowcount);
   --关闭游标
   close cur;
end;

--while循环遍历游标
declare
   --定义一个游标
   cursor cur is select * from emp;
   --声名一个变量保存游标中的一条记录
   v cur%rowtype;
begin
  --打开游标
  open cur;
  --执行fetch语句，取游标中的第1条数据
  fetch cur into v;
  --遍历
  while cur%found and cur%rowcount<=4 loop  --没有执行fetch into语句前，%found和%notfound不可用 true=1>0 false=0<1
     --循环体，处理数据
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
     --循环控制语句
     fetch cur into v;
  end loop;
  
  --关闭游标
  close cur;
end;

--for循环遍历游标
declare
   --定义一个游标
   cursor cur is select * from emp;
begin
   for v in cur loop --v变量属于局部变量    
     --循环体语句
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
   end loop;
end;

declare
   --声名一个布尔类型变量
   b boolean:=false;
begin
   while b loop
     dbms_output.put_line('a');
     
   end loop;
end;


全局变量和局部变量相对的

declare
   v1 varchar2(30):='hello'; --begin --end之间都可以用 全局变量
begin
   for n in 1..9 loop  --n只能在loop 和end loop 之间使用，局部变量
     dbms_output.put_line(v1);
     dbms_output.put_line(n);
   end loop;
   dbms_output.put_line(v1);
end;

declare
   v1 varchar2(30):='hh'; --全局变量
begin
   --子块
   declare
      v2 varchar2(30):='aa';  --局部变量
   begin
       --v2可以使用
       --v1也可以使用
   end;
   --只能使用v1
end;
