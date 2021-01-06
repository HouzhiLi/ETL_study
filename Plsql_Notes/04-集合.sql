集合
集合数据类型，存放一组数据类型相同的数据，由下标和值组成，下标可以是数字类型
也可以是字符串类型
集合的分类：索引表，嵌套表，变长数组
集合的属性：
     first:取集合中第1个元素的下标
     last:取集合中最后一个元素的下标
     count:取集合中的元素个数
     limit:取集合中最大的元素个数（最多存放的元素个数）
     next(下标)：表示取集合中下一个元素的下标
     prior(下标):表示取集合中上一个元素的下标
     extend(n[,ind]):n是一个自然数 ind是集合中某个元素的下标,将集合扩展n个元素，
               如果传入第2个参数时，表示扩展的n个元素值是ind下标对应的值
     delete():删除集合中的所有元素 
     
1.索引表
索引表：存放一组数据类型相同的数据，下标可以是字符串，也可以是数字（pls_integer,binary_integer）
   索引表的元素个数不限制，给一个下标和一个值，就可以在索引表中添加一个元素
   索引表只能在plsql代码块中使用

索引表类型的定义：
type 类型名称 is table of 元素值的类型 index by 下标的数据类型;

声名索引表变量：
变量名 类型名称;

使用：
索引表不需要初始化，也不需要扩展，给一个下标和值就能添加元素
注意：索引表的下标自动排序，从小到大
declare
   --定义一个存放字符串类型的索引表类型
   type ctype is table of varchar2(30) index by varchar2(30);
   --声名一个索引表变量
   c ctype;
begin
   --给索引表中添加元素
   c('a'):='smith';
   c('1'):='scott';
   c('b'):='alen';
   c('6'):='king';
   --索引表的属性
   dbms_output.put_line('索引表的count属性：'||c.count); --4
   dbms_output.put_line('索引表的first属性：'||c.first); --1
   dbms_output.put_line('索引表的last属性：'||c.last); --b
   dbms_output.put_line('索引表next(''6'')方法：'||c.next('6')); --a
   dbms_output.put_line('索引表prior(''6'')方法：'||c.prior('6')); --1
   
   
   dbms_output.put_line('索引表第1个元素值：'||c(c.first)); --第一个元素值scott
   dbms_output.put_line('索引表最后一个元素值：'||c(c.last)); --最后一个元素值 alen
end;


declare
   --定义一个存放字符串类型的索引表类型
   type ctype is table of varchar2(30) index by varchar2(30);
   --声名一个索引表变量
   c ctype;
   --声名一个循环变量保存集合的下标
   ind varchar2(30);
begin
   --给索引表中添加元素
   c('a'):='smith';
   c('1'):='scott';
   c('b'):='alen';
   c('6'):='king';
   --集合的遍历loop循环
   --初始化循环变量
   ind:=c.first;
   --loop循环
   loop
      /**
        ind=i1
        1   ind=i1    c(i1)取第1个元素打印   i1=c.last不成立   ind=c.next(i1)=i2
        2   ind=i2    c(i2)...............   i2=c.last .....   ind=c.next(i2)=i3
        ...
        ..
      
      */
      --循环体语句
      dbms_output.put_line(ind||'->'||c(ind));
      --退出循环语句
      exit when ind=c.last;
      --循环控制语句
      ind:=c.next(ind);
   end loop;
end;
     
declare
   --定义一个索引表类型
   type ctype is table of varchar2(30) index by pls_integer;
   --声名一个集合变量
   c ctype;
   
   --声名一个变量保存集合的下标
   ind pls_integer;
begin
   --给集合添加元素
   c(1):='smith';
   c(2):='scott';
   c(3):='alen';
   c(4):='king';
   --while循环遍历
   --初始化循环变量
   ind:=c.first;
   /***
     ind=1
     1   ind=1   1<=4成立      打印c(1)    ind=c.next(1)=2
     2   ind=2   2<=4...       ....c(2)    ind=c.next(2)=3
     3   ind=3   3<=4 ...      打印c(3)    ind=c.next(3)=4
     4   ind=4   4<=4...       打印c(4)    ind=c.next(4)为空
     5   ind=null null<=4条不成立  退出循环   
   */
   while ind<=c.last loop
      --循环体语句
      dbms_output.put_line(ind||'-->'||c(ind));
      --循环控制语句
      ind:=c.next(ind);
   end loop;
   dbms_output.put_line(ind);
   
end;


declare
   --定义一个索引表类型
   type ctype is table of varchar2(30) index by pls_integer;
   --声名一个集合变量
   c ctype;
   
   --声名一个变量保存集合的下标
   ind pls_integer;
begin
   --给集合添加元素
   c(1):='smith';
   c(2):='scott';
   c(3):='alen';
   c(4):='king';
   
   for i in c.first..c.last loop
     dbms_output.put_line(c(i));
   end loop;
   
end loop;

bulk collect语句它可以使用在into前面(索引表类型使用在bulk collect语句中时，下标只能是数字类型)
select * bulk collect into 集合变量 from emp;
execute immediate select语句  bulk collect into 集合变量
fetch 游标  bulk collect into 集合变量

declare
   --定义一个索引表类型
   type ctype is table of emp%rowtype index by pls_integer;
   --声名一个集合变量
   c ctype;
begin
   --查询所有员工信息
   select * bulk collect into c from emp;
   for i in c.first..c.last loop
     dbms_output.put_line(c(i).empno||','||c(i).ename||','||c(i).job||','||c(i).deptno);
   end loop;
end;

declare
   --定义一个索引表类型
   type ctype is table of varchar2(30) index by pls_integer;
   --声名一个变量
   jobs ctype;
   names ctype;
begin
   select ename,job bulk collect into names,jobs from emp;
   for i in names.first..names.last loop
     dbms_output.put_line(names(i)||','||jobs(i));
   end loop;
end;

--思考题
索引表变量中有如下数据(下标连续的数字类型)
（32,12,33,5,21,44,66,1,3,4）将下面的数据排序
declare
   type ctype is table of number(3) index by pls_integer;
   c ctype;
   c2 ctype;
   
   --声名一个变量保存c2的下标
   ci pls_integer;
begin
   c(1):=32;
   c(2):=12;
   c(3):=33;
   c(4):=5;
   c(5):=21;
   c(6):=44;
   c(7):=66;
   c(8):=1;
   c(9):=3;
   c(10):=4;
   for i in c.first..c.last loop
     c2(c(i)):=0;
   end loop;
   --遍历c2时不能使用for循环
   --初始化循环变量
   ci:=c2.first;
   --遍历
   loop
     --循环体语句 c2(ci);
     dbms_output.put_line(ci);
     --退出循环条件
     exit when ci=c2.last;
     --循环控制语句
     ci:=c2.next(ci);
   end loop;
   dbms_output.put_line(rpad('-',50,'-'));
   --初始化ci
   ci:=c2.last;
   loop
     --循环体语句
     dbms_output.put_line(ci);
     exit when ci=c2.first;
     ci:=c2.prior(ci);
   end loop;
end;

declare
   type ctype is table of number(3) index by pls_integer;
   c ctype;
   
   --声名一个变量保存临时值
   t number;
begin
   c(1):=32;
   c(2):=12;
   c(3):=33;
   c(4):=5;
   c(5):=21;
   c(6):=44;
   c(7):=66;
   c(8):=1;
   c(9):=3;
   c(10):=4;
   for i in 1..9 loop
      /**
        i=1
        2..10
        1 次     c(1)>c(2)  
      */
      --冒泡排序
      for j in reverse i+1..10 loop
        if c(j-1) < c(j) then
           t:=c(j-1);
           c(j-1):=c(j);
           c(j):=t;
        end if; 
      end loop;
   end loop; 
   
   for i in c.first..c.last loop
     dbms_output.put_line(c(i));
   end loop;
end;


declare
   a number:=5;
   b number:=7;
   --声名一个变量保存临时值
   t number;
begin
   dbms_output.put_line(a);
   dbms_output.put_line(b);
   /**
  --把a的值放入t中
   t:=a;
   --把b的值放入a中
   a:=b;
   --把t中的值放入b
   b:=t;
   dbms_output.put_line(a);
   dbms_output.put_line(b);
  */
   a:=a+b;  --12
   b:=a-b; --b=a-b=12-7=5
   a:=a-b;  --a=a-b=12-5=7
   dbms_output.put_line(a);
   dbms_output.put_line(b);
end;


2.嵌套表
嵌套表:存储一组数据类型相同的数据，它的下标是连续的整数，可以在plsql代码块中使用，
也可以创建在数据库中，使用前需要初始化和扩展（注意：bulk collect into中不需要初始化和扩展）

嵌套表的定义语法：
type 类型名 is table of 数据类型;

使用步骤：
1.声名变量
2.初始化变量
  变量名:=类型名();   --初始化一个空的嵌套表
  变量名:=类型名(值,值,....); --初始化一个有值的嵌套表
3.添加元素
  扩展
  变量名.extend(n)
  变量名(下标):=值;
  
遍历时使用for循环就可以

declare
   --定义一个嵌套表类型
   type ttype is table of varchar2(30);
   --声名一个嵌套表变量
   t ttype;
begin
   --初始化嵌套表
   t:=ttype(); --初始化一个空的嵌套表
   --
   dbms_output.put_line(t.count);
   
   --t(1):='xt';--不允许直接赋值
   --扩展
   t.extend(1);
   dbms_output.put_line(t.count);
   dbms_output.put_line(t(1));
   --赋值
   t(1):='xt';
   dbms_output.put_line(t(1));
   t.extend(1);
   t(2):='xx';
   t.extend(1);
   t(3):='xy';
   for i in t.first..t.last loop
      dbms_output.put_line(i||'-->'||t(i));
   end loop;
   
   --扩展多个带值的元素
   t.extend(5,1);--扩展5个元素并且和下标是1的元素值 相同
   
   dbms_output.put_line(rpad('-',50,'-'));
    for i in t.first..t.last loop
      dbms_output.put_line(i||'-->'||t(i));
   end loop;
end;

declare
   --定义一个嵌套表类型
   type ttype is table of varchar2(30);
   t ttype;
begin
   --初始化嵌套表
   t:=ttype('smith','alen','scott','king');
   --打印元素个数
   dbms_output.put_line(t.count);
   --遍历 
   for i in t.first..t.last loop
     dbms_output.put_line(i||'-->'||t(i));
   end loop;
end;

--注意：用在bulk collect into语句中不需要初始化和扩展
declare
   --定义一个嵌套表保存所有员工的姓名
   type ttype is table of varchar2(30);
   --声名一个嵌套表变量
   t ttype;
begin
   --使用select into 将数据查询到变量t中，并遍历打印
   select ename bulk collect into t from emp;
   
   for i in t.first..t.last loop
     dbms_output.put_line(t(i));
   end loop;
end;

declare
   --定义一个嵌套表类型
   type ttype is table of varchar2(30);
   --声名一个变量
   t ttype;
   --定义一个游标
   cursor cur is select ename from emp;
begin
   --打开游标
   open cur;
   fetch cur bulk collect into t;
   --关闭游标
   close cur;
   --遍历 嵌套表变量
   for i in t.first..t.last loop
     dbms_output.put_line(t(i));
   end loop;
  
end;

returning  bulk collect into 变量:返回几个列，就需要几个变量来保存

创建嵌套表类型：
create type 类型名称 is table of 数据类型;
create type tttype is table of varchar2(30);

declare
   --声名一个嵌套表变量
   c tttype;
begin
   select ename bulk collect into c from emp where deptno=10;
   for i in c.first..c.last loop
     dbms_output.put_line(c(i));
   end loop;
end;

在建表时使用嵌套表类型：
create table 表名1(
  列名  数据类型,
  嵌套表列名  嵌套表类型
)nested table 嵌套表列名 store as 表名2;

select 'drop table '||table_name||';' from user_tables where table_name not in('EMP','DEPT','SALGRADE');

create table tab1(
  dno number(5),
  names tttype
)nested table names store as tab2;

insert into tab1 values(10,TTTYPE('SMITH','SCOTT','KING'));

insert into tab1 values(20,TTTYPE('A','B','C'));
select * from tab1;

使用table的子查询:它只能针对集合列（嵌套表，变长数组），单行单列的子查询
select * from table(select names from tab1 where dno=20);


3.变长数组类型
变长数组：存放一组数据类型相同的数据，下标也是连接的数字类型，定义时需要
        指定最大长度，使用前需要初始化和扩展（bulk collect中不需要）
定义语法：
type 类型名称 is varray(最大长度) of 数据类型;

初始化语法和扩展语法同嵌套表

declare
    --定义一个变长数组类型
    type atype is varray(10) of varchar2(30);
    --声名变量
    arr atype;
begin
    --初始化
    arr:=atype('oracle','mysql','sqllite','hbase');
    --打印元素个数
    dbms_output.put_line('count属性:'||arr.count);
    --打印最大元素个数
    dbms_output.put_line('limit属性：'||arr.limit);
    
    --arr(5):='mariadb'; --不允许的
    arr.extend(1);
    arr(5):='mariadb';
    
    --arr.extend(6,1);
    arr.extend(5,1);
    
    --遍历
    for i in arr.first..arr.last loop
      dbms_output.put_line(arr(i));
    end loop;
end;

declare
   --定义一个变长数组类型，用来保存员工姓名
   type atype is varray(10) of varchar2(30);
   --声名一个变量
   a atype;
begin
   select ename bulk collect into a from emp where deptno=30;
   
end;

创建变长数组类型：
create type 类型名称 is varray(长度) of 数据类型;

create type aatype is varray(20) of varchar2(30);

create table 表名(
  列名 数据类型,
  变长数组列 变长数组类型
)

create table tab3(
  dno number(5),
  names aatype
)

insert into tab3 values(10,aatype('plsql','java','python','php'));

select * from tab3;

select * from table(select names from tab3 where dno=10);


索引表：只能在代码块中使用
        下标字符串和数字类型，并且可以不连续
        没有边界，给一个下标和值，就可以添加一个元素
        不需要初始化和扩展
嵌套表：即可以在代码块中使用，也可以创建在数据库中
        下标只能是连续的数字
        没有边界，添加元素时，需要先扩展
        需要初始化和扩展
变长数组：即可以在代码块中使用，也可以创建在数据库中
         下标只能是连续的数字
         有边界，添加元素时，需要先扩展
         需要初始化和扩展
         
bulk collect

批量处理
forall语句：只能用在集合上
语法：
forall 变量 in 集合
   dml语句（insert,delete,update）
   
写一个代码块，给工资小于3000的人加薪500
declare
   --定义一个集合存储员工编号
   type itype is table of number(5) index by pls_integer;
   --声名一个索引表变量
   c itype;
begin
   --查询出工资小于3000的员工的员工编号，保存到集合c中
   select empno bulk collect into c from emp where sal<3000;
   for i in c.first..c.last loop
      update emp set sal=sal+500 where empno=c(i);
   end loop;
end;

declare
   --定义一个集合存储员工编号
   type itype is table of number(5) index by pls_integer;
   --声名一个索引表变量
   c itype;
begin
   --查询出工资小于3000的员工的员工编号，保存到集合c中
   select empno bulk collect into c from emp where sal<3000;
   
   forall i in c.first..c.last
      update emp set sal=sal+500 where empno=c(i);
end;

select * from emp;
