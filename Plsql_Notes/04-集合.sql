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
   i pls_integer;
   tmp number(3);
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
   for i in c.first+1..c.last loop
     for m in c.first..c.last-1 loop
       if c(i) < c(M) then
         tmp := c(m);
         c(m) := c(i);
         c(i) := tmp;
         end if;
       end loop;
     end loop;
     for i in c.first..c.last loop
     dbms_output.put_line(c(i));
     end loop;
     end;
     
declare
   type ctype is table of number(3) index by pls_integer;
   c ctype;
   t ctype;
   i pls_integer;
   
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
     t(c(i)) := 1;
     end loop;
     
     i := t.first;
     loop
       dbms_output.put_line(i);
       exit when i = t.last;
       i := t.next(i);
       end loop;
       end;
