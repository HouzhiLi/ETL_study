异常和文件读写：
1.异常
异常：程序运行过程中出现的错误，包括程序,数据库，硬件，网络等错误
异常的操作：抛出异常和捕获异常（处理异常）
异常的分类：系统内置异常和自定义异常
1)内置异常
ORA-00904: invalid column name 无效列名
ORA-00942: table or view does not exist 表或者视图不存在
ORA-01400: cannot insert NULL into () 不能将空值插入
ORA-00936:　缺少表达式
ORA-00933:　SQL 命令未正确结束
ORA-01722:　无效数字：（一般可能是企图将字符串类型的值填入数字型而造成）
ORA-06530: ACCESS_INTO_NULL　
      Your program attempts to assign values to the attributes of an uninitialized (atomically null) object.
企图将值写入未初化对象的属性
ORA-06592: CASE_NOT_FOUND
     None of th choice in the WHEN clauses of a CASE statement is selected, and there is no ELSE clause.
case语句格式有误，没有分支语句
ORA-06531: COLLECTION_IS_NULL
     Your program attempts to apply collection methods othe than EXIST to an uninitialized(atomically null) nested table or varray, or th program attempts to assign values to the elements of an uninitialized nested table or varray.
企图将集合填入未初始化的嵌套表中
ORA-06511: CURSOR_ALREADY_OPEN
     Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened. A cursor FOR loop automatically opens the cursor to which it refers. So, your program cannot open that cursor inside the loop.
企图打开已经打开的指针．指针已经打开，要再次打开必须先关闭．
ORA-00001: DUP_VAL_ON_INDEX
     Your program attempts to store duplicate values in a database column that is constrained by a unique index.
数据库字段存储重复，主键唯一值冲突
ORA-01001: INVALID_CURSOR　无效指针
    Your program attempts an illegal cursor operation such as closing an unopened cursor.
非法指针操作，例如关闭未打开的指针
ORA-01722: INVALID_NUMBER　无效数字
     In a SQL statement, the conversion of a character string into a number fails because the string does not represent a valid number. (In procedural statements, VALUE_ERROR is raised.) This exception is also raised when the LIMIT-clause expression in a bulk FETCH statement does not evaluate to a positive number.
在sql语句中，字符数字类型转换错误，无法将字符串转化成有效数字．此错误也可能因为在limit从句表达式中fetch语句无法对应指定数字
ORA-01017: LOGIN_DENIED　拒绝访问
     Your program attempts to log on to Oracle with an invalid username and/or password.
企图用无效的用户名或密码登录oracle

ORA-01403: NO_DATA_FOUND 无数据发现
     A SELECT INTO statement returns no rows, or your program references a deleted element in a nested table or an uninitialized element in an index-by table. SQL aggregate functions such as AVG and SUM always return a value or a null. So, a SELECT INTO statement that calls an aggregate function never raises NO_DATA_FOUND. The FETCH statement is expected to return no rows eventually, so when that happens, no exception is raised.

ORA-01012: NOT_LOGGED_ON   未登录
     Your program issues a database call without being connected to Oracle.
程序发送数据库命令，但未与oracle建立连接

ORA-06501: PROGRAM_ERROR 程序错误
     PL/SQL has an internal problem.
pl/sql系统问题

ORA-06504: ROWTYPE_MISMATCH 行类型不匹配
    The host cursor variable and PL/SQL cursor variable involved in an assignment have incompatible return types.
For example, when an open host cursor variable is passed to a stored subprogram, the return types of the actual and formal parameters must be compatible.

ORA-30625: SELF_IS_NULL
     Your program attempts to call a MEMBER method on a null instance. That is, the built-in parameter SELF (which is always the first parameter passed to a MEMBER method) is null.

ORA-06500: STORAGE_ERROR 存储错误
     PL/SQL runs out of memory or memory has been corrupted.
PL/SQL运行内存溢出或内存冲突
     
ORA-06533: SUBSCRIPT_BEYOND_COUNT   子句超出数量
      Your program references a nested table or varray element using an index number larger than the number of elements in the collection.

ORA-06532: SUBSCRIPT_OUTSIDE_LIMIT   子句非法数量
Your program references a nested table or varray element using an index number (-1 for example) that is outside the legal range.

ORA-01410: SYS_INVALID_ROWID   无效的字段名
   The conversion of a character string into a universal rowid fails because the character string does not represent a valid rowid.
ORA-00051: TIMEOUT_ON_RESOURCE    资源等待超时
A time-out occurs while Oracle is waiting for a resource.
ORA-01422: TOO_MANY_ROWS    返回超过一行
A SELECT INTO statement returns more han one row.
ORA-06502: VALUE_ERROR   值错误
An arithmetic, conversion, truncation, or size-constraint error occurs. For example, when your program selects a column value into a character variable, if the value is longer than the declared length of the variable, PL/SQL aborts the assignment and raises VALUE_ERROR. In procedural statements, VALUE_ERROR is raised if the conversion of a character string into a number fails. (In SQL statements, INVALID_NUMBER is raised.)
ORA-01476: ZERO_DIVIDE 除0错误
Your program attempts to divide a number by zero.

declare
   声名部分;
begin
   代码块;
   --异常处理部分(捕获异常，并处理)
   exception
     when 异常名称 then
       异常处理代码
     when 异常名称 then
       异常处理代码
       ...
     when others then
       异常处理代码
end;
declare
  --声名一个变量
  v emp%rowtype;
begin
  select * into v from emp where 1=0;
  /*
  exception --捕获并处理异常
    when no_data_found then
      dbms_output.put_line('程序出错了');
  */
end;

sqlcode:返回异常的编码,no_data_found返回的编码是100,
sqlerrm:返回异常的信息

declare
  --声名一个变量
  v emp%rowtype;
begin
  select * into v from emp where 1=0;
  
  exception --捕获并处理异常
    when no_data_found then
      dbms_output.put_line('程序出错了');
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);
  
end;

begin
  dbms_output.put_line(5/0);
  exception
    when others then
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);
end;


2.自定义异常
语法：
异常变量  exception;  --定义一个异常

declare
  myexc exception; --定义一个异常
begin
  null;
end;

抛出异常语法：
raise 异常变量;  --抛出一个自定义异常
dbms_standard.raise_application_error(异常编码,'异常信息'); --抛出一个业务异常，其中自定义异常编码的取值范围-20000~-20999

declare
  myexc exception; --定义一个异常
begin
  raise myexc;
  exception
    when myexc then
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);
end;

begin
  --抛出一个业务异常（应用异常）
  dbms_standard.raise_application_error(-20001,'我的异常');
  exception 
    when others then
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);
end;

异常绑定：
pragma exception_init(异常变量,异常编码); --写在declare部分的

declare
   --自定义一个异常变量
   myexc exception;
   --将自定义异常绑定到-20001
   pragma exception_init(myexc,-20001);
begin
   --抛出一个业务异常（应用异常）
   dbms_standard.raise_application_error(-20001,'我的异常');
   exception 
     when myexc then
       dbms_output.put_line(sqlcode);
       dbms_output.put_line(sqlerrm);
end;

declare
   --定义一个异常变量
   myexc exception;
   --将主键冲突异常绑定到myexc
   pragma exception_init(myexc,-00001);
begin
   insert into dept values(10,'aa','bb');
   exception
     when myexc then
       dbms_output.put_line(sqlcode);
       dbms_output.put_line(sqlerrm);
end;

注意：begin和exception的之间是代码块部分，
exception和end之间所有代码都是异常处理代码，只有在出现异常时可能执行






declare
   --定义一个异常变量
   myexc exception;
   --将主键冲突异常绑定到myexc
   pragma exception_init(myexc,-00001);
begin
   --插入一个部门信息
   insert into dept values(50,'aa','bb');
   
   exception
     when myexc then
       dbms_output.put_line(sqlcode);
       dbms_output.put_line(sqlerrm);
       --给该部门添加员工
   dbms_output.put_line('插入员工信息');
end;


declare
   --定义一个异常变量
   myexc exception;
   --将主键冲突异常绑定到myexc
   pragma exception_init(myexc,-00001);
begin
   begin
     --插入一个部门信息
     insert into dept values(10,'aa','bb');
     
     exception
       when myexc then
         dbms_output.put_line(sqlcode);
         dbms_output.put_line(sqlerrm);
         --给该部门添加员工
   end;
   dbms_output.put_line('插入员工信息');
end;

3.文件读写
utl_file.file_type:文件类型
utl_file.fopen(目录路径,文件名称,读写方式)：打开文件的方法
目录路径：指oracle中directory对象的名字,目录名要大写，以字符串的方式传入
          directory：目录，保存一个计算机上的地址（路径）
      语法：
       create directory 目录名 as 目录路径;
       
       create directory ospath as '/home/oracle';  --创建一个目录指向/home/oracle目录
       
       create directory filepath as 'd:/data';
       
 文件名称：字符串类型的数据
 读写方式：字符串类型
            r:表示读取文件
            w:表示写文件
            a:表示追加      


utl_file.put_line(文件变量,写入的内容)：向文件中写入内容
文件变量:utl_file.file_type文件类型
写入的内容：字符串类型

utl_file.get_line(文件变量，字符串变量):读取文件的一行内容，并将内容保存到字符串变量中
文件变量：utl_file.file_type类型

utl_file.fclose(文件变量):关闭文件
文件变量:utl_file.file_type文件类型


1.声名文件变量
2.打开文件（给文件变量赋值）
3.读或写文件
4.关闭文件

--写文件代码
declare
   --声名一个文件变量
   f utl_file.file_type;
   
begin
   --打开文件  当test.txt不存在时，会自动创建一个新的文件，如果文件存在，那么会将原文件内容删除，再写入新的内容
   f:=utl_file.fopen('OSPATH','test.txt','w');
   --向文件中写入内容
   utl_file.put_line(f,'Oracle');
   
   utl_file.put_line(f,'SQL');
   
   utl_file.put_line(f,'PLSQL');
   --关闭文件
   utl_file.fclose(f);
   
end;
declare
   --声名一个文件变量
   f utl_file.file_type;
   
begin
   --打开文件  当test.txt不存在时，会自动创建一个新的文件，如果文件存在，那么会将原文件内容删除，再写入新的内容
   f:=utl_file.fopen('OSPATH','test.txt','w');
   --向文件中写入内容
   utl_file.put_line(f,'1234');

   --关闭文件
   utl_file.fclose(f);
end;

--向文件中追加内容
declare
   --声名一个文件变量
   f utl_file.file_type;
begin
   --打开文件 a方式 当文件不存在时，会自动创建新文件，如果文件存在，会在文件最后一行添加内容
   f:=utl_file.fopen('OSPATH','2.txt','a');
   --写入内容
   utl_file.put_line(f,'haha');
   utl_file.put_line(f,'xixi');
   --关闭文件
   utl_file.fclose(f);
end;

--读取文件
declare
   --声名一个文件变量
   f utl_file.file_type;
   --声名一个变量保存读取到的文件一行内容
   v varchar2(200);
begin
   --打开文件
   f:=utl_file.fopen('OSPATH','2.txt','r');
   --读取文件一行内容到变量v中
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   --读取文件一行内容到变量v中
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   
   --读取文件一行内容到变量v中
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   --读取文件一行内容到变量v中
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   
   --读取文件一行内容到变量v中
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   --读取文件一行内容到变量v中
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   
   --utl_file.get_line(f,v); 当读取到最后时，没有数据会报no_data_found异常
   --关闭文件
   utl_file.fclose(f);
end;


declare
   --声名一个文件变量
   f utl_file.file_type;
   --声名一个变量保存读取到的文件一行内容
   v varchar2(200);
begin
   --打开文件
   f:=utl_file.fopen('OSPATH','2.txt','r');
   loop  --退出循环使用no_data_found异常
     --读取文件一行内容到变量v中   
     begin
        utl_file.get_line(f,v);
        dbms_output.put_line(v);
        exception
          when no_data_found then
            exit;
     end;
   end loop;
   --utl_file.get_line(f,v); 当读取到最后时，没有数据会报no_data_found异常
   --关闭文件
   utl_file.fclose(f);
end;


declare
   --声名一个文件变量
   f utl_file.file_type;
   --声名一个变量保存读取到的文件一行内容
   v varchar2(200);
begin
   --打开文件
   f:=utl_file.fopen('OSPATH','2.txt','r');
   begin
      loop  --退出循环使用no_data_found异常
     --读取文件一行内容到变量v中   
     
       
        utl_file.get_line(f,v);
        dbms_output.put_line(v);
      
      end loop;
      exception
          when no_data_found then
            null;
   end;
   --utl_file.get_line(f,v); 当读取到最后时，没有数据会报no_data_found异常
   --关闭文件
   utl_file.fclose(f);
end;


--不建议写法
declare
   --声名一个文件变量
   f utl_file.file_type;
   --声名一个变量保存读取到的文件一行内容
   v varchar2(200);
begin
   --打开文件
   f:=utl_file.fopen('OSPATH','2.txt','r');
   loop  --退出循环使用no_data_found异常
   --读取文件一行内容到变量v中       
      utl_file.get_line(f,v);
      dbms_output.put_line(v);       
   end loop;
   --utl_file.get_line(f,v); 当读取到最后时，没有数据会报no_data_found异常
   --关闭文件
   exception
      when no_data_found then
          utl_file.fclose(f);
end;

--写一个代码将所有员工的姓名，写到文件中
declare
   --声名文件变量
   f utl_file.file_type;
   
begin
   --打开文件
   f:=utl_file.fopen('OSPATH','enames.txt','w');
   for v in (select ename from emp) loop
     utl_file.put_line(f,v.ename); --将员工姓名写入文件中
   end loop;
   --关闭文件
   utl_file.fclose(f);
end;


--写一个程序将部门表中的数据保存到文件中
declare
   --声名一个文件变量
   f utl_file.file_type;
   
begin
   --打开文件
   f:=utl_file.fopen('OSPATH','dept.dat','w');
   for v in (select deptno||','||dname||','||loc s from dept) loop
      utl_file.put_line(f,v.s);
   end loop;
   --关闭文件
   utl_file.fclose(f);
end;

--将上面代码保存文件文件，插入到一张表中（表自已创建，和dept表结构相同）
