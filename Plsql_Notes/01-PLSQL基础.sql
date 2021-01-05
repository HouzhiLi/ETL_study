PLSQL代码块结构：
declare
  声名部分
begin
  代码块
  exception
    异常处理代码
end;
声名部分：对变量,常量,类型，游标等的定义或声名
代码块：sql语句，以及流程控制语句
exception:异常处理代码块

begin
  dbms_output.put_line('Hello World');  --dbms_output.put_line()输出语句
end;

变量：变量他就保存一个数据（可以是单个的值，也可以是复杂的值）
变量名 数据类型 [:= 初始值];

":=":在plsql代码块中是赋值符号

标识符：数据库中创建对象时，的对象名
    1.不能使用oracle中的关键字，如果要用一个关键字时，可以使用双引号将关键字引起来
    2.长度不能超过30个英文字符的长度
    3.一般以字母开头，可以包括数字，下划线等特殊字符（_,$,#）,不能以数字开头
declare
   --声名一个数字类型的变量
   n number(3):=10;
begin
   dbms_output.put_line(n);
   
   n:=20;  --将变量n值改为20
   
   dbms_output.put_line(n);
end;

常量：常量也是用来保存数据的，但是它只保存一个数据，并且不能修改，在声名时必须赋常量值
常量的声名语法：
常量名 constant 数据类型:=常量值;
declare
   --声名一个常量,保存圆周率
   pi constant number(5,4):=3.1415;
begin
   dbms_output.put_line(pi*power(2,2));
   
   --pi:=3.4;常量是不可以修改的
end;

plsql代码块中的数据类型：
 1.数字类型：
     number(l,s):l表示长度，s表示精度，最长38个长度
     integer:整数类型
     pls_integer/binary_integer:只存放整数
     
     float(浮点型，小数类型),int
     
 2.字符串类型：
     varchar2(长度):变长字符串类型
     char(长度):定长字符串类型
     
     long
     
     rowid:为了存数据库中伪列rowid列的值时使用
     
     select emp.*,rowid from emp;
 3.日期类型
    date:
    timestamp:
 4.布尔类型
   boolean:布尔类型只三种值，true,false,null
   
 5.记录类型：
 record
 记录类型的定义语法：
 type 类型名 is record(
   属性名 数据类型 [default 默认值] [NOT NULL],
   属性名 数据类型 ...,
   ...
   属性名 数据类型
 );
 声名变量
 变量名 类型;
 记录类型的使用：
 变量名.属性名  --获取记录类型中的属性值
 变量名.属性名:=值;
 
 declare
   --定义一个记录类型
   type rtype is record(
      name varchar2(30),
      age number(3),
      sex varchar2(3)
   );
   --声名记录类型变量
   v rtype;
 begin
   v.name:='smith';
   v.age:=18;
   v.sex:='男';
   --打印记录类型的值
   dbms_output.put_line(v.name||','||v.age||','||v.sex);
 end;
 declare
    --定义一个记录类型
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
    
    --声名一个变量
    v rtype;
 begin
    --使用select into语句给记录类型赋值 select 列名,... into 变量 from 表名 where 条件等
    select * into v from emp where empno=7369;
    --打印变量值
    dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
 end;
 6.%type类型
 对象%type:表示取对象的数据类型
 emp.ename%type :表示取表emp，ename列的数据类型 相当于varchar2(10)
 变量名%type ：表示取一个变量的数据类型
 declare
    --声名一个变量，它类型和emp表中job列的类型相同
    v_job emp.job%type;  -- v_job varchar2(9);
    
    v v_job%type;  --表示声名一个变量v，它的类型和变量v_job的类型相同  varchar2(9)
 begin
    v_job:='CLERK';
    
    v:='Smith';
    dbms_output.put_line(v_job);
    dbms_output.put_line(v);
 end;
 
 7.数据类型%rowtype类型
 %rowtype类型：是记录类型和%type类型的结合
 对象%rowtype
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
    --声名一个emp%rowtype类型的变量
    v emp%rowtype;
 begin
    --查询一个员工信息，并将员工信息保存到变量v中
    select * into v from emp where empno=7499;
    --打印变量v的值，v是一个记录类型
    dbms_output.put_line(v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
 end;
 
 游标%rowtype;
 
 8.游标类型，异常类型，集合类型，文件类型等     
 
 
 在PLSQL代码块中执行SQL语句：
 
 1.直接在plsql代码块中执行
 （1）insert,update,delete dml等语句(不包含select)可以直接在plsql代码块中运行
  begin
    update emp set sal=sal+500;
    
    insert into emp(empno,ename,job,sal,deptno) values(7999,'scott','CLERK',1234,10);
    
    delete from emp where sal<1000;
  end;
  在plsql代码块中运行dml语句时，可以使用plsql代码块中的变量作为sql语句的条件
  
  declare
     --声名一个变量
     dno number(4):=50;
     --声名一个变量
     v_dname varchar2(30):='dept1';
     --声名一个变量
     v_loc varchar2(30):='loc1';
     
     --声名一个变量保存一个值
     n number:=300;
  begin
     --insert into dept values(50,'dept1','loc1');
     insert into dept values(dno,v_dname,v_loc);
     
     update emp set sal=sal+n where deptno=10;
  end;
  
  declare
     --声名一个变量保存员工的工作
     v_job varchar2(10):='soft';
  begin
     --修改10部门所有员工的工作
     update emp set job=v_job where deptno=10;
  end;
 select * from emp;
 
 select * from dept;
  (2)执行select语句，代码块中不能直接运行sql部分的select语句
   select into语句的语法：
   select 列名,列名,... into 变量名,... from 表名 where 条件
   表示将数据库中的数据查询到变量中，
   注意：select into语句只能查询单条数据，不能多不能少
   
  --写一个plsql代码块，输入一个员工编号，根据员工编号查询员工的姓名和工作
  select ename,job from emp where empno=&员工编号;
  &在oracle中是取值符号 ，如果是数字类型数据，&变量名 如果是字符串类型数据 '&变量'
  declare
     --声名一个变量保存员工姓名
     v1 emp.ename%type;
     --声名一个变量保存员工的工作
     v2 emp.job%type;
  begin
     select ename,job into v1,v2 from emp where empno=&员工编号;
     --打印变量的值
     dbms_output.put_line(v1||','||v2);
  end;
  
  declare
     --定义一个记录类型
     type rtype is record(
        ename emp.ename%type,
        job emp.job%type
     );
     
     --声名一个记录类型变量
     v rtype;
  begin
     select ename,job into v from emp where empno=&员工编号;
     --打印结果
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  
  declare
     --定义一个记录类型
     type rtype is record(
        ename emp.ename%type,
        job emp.job%type,
        sal emp.sal%type
     );
     
     --声名一个记录类型变量
     v rtype;
  begin
     --当记录类型中的属性比查询结果的列多或者少的时候，into后面不能直接写记录类型变量名
     --select ename,job into v from emp where empno=&员工编号;
     select ename,job into v.ename,v.job from emp where empno=&员工编号;
     --打印结果
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  declare
     --定义一个rowtype类型
     v emp%rowtype;
  begin
     select ename,job into v.ename,v.job from emp where empno=&员工编号;
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  declare
     --声名一个rowtype类型变量
     v emp%rowtype;
  begin
     select * into v from emp where empno=&员工编号;
     dbms_output.put_line(v.ename||','||v.job);
  end;
  
  --聚合函数
  select count(*) from emp where 1=0; #判断数据库是否包含某些数据
  （3）returning into语句用在Insert，update,delete语句中，将dml语句修改的这条数据存放到变量中
  语法：returning 列,列,, into 变量;
  
  update emp set sal=sal+500 where empno=7369;
  select * from emp where empno=7369;
  
  declare
     --声名两个变量保存员工的工资和员工编号
     v1 emp.empno%type;
     v2 emp.sal%type;
     
     --rowid 声名一个变量保存数据的rowid
     vid rowid;
  begin
     update emp set sal=sal+500 where empno=7369 returning empno,sal,rowid into v1,v2,vid;
     
     --打印变量的值
     dbms_output.put_line(v1||','||v2||','||vid);
     
     delete from emp where rowid=vid;
  end;
     
  
  
 2.
