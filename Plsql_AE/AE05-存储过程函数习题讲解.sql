1.写一个存储过程，输入员工信息，在emp表中插入一条员工信息
create or replace procedure p1(v_empno in number,
                               v_ename in varchar2,
                               v_job in varchar2,
                               v_mgr in number,
                               v_hiredate in date,
                               v_sal in number,
                               v_comm in number,
                               v_deptno in number)
is
begin
  insert into emp values(v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno);
end;

begin
  p1(9999,'xx','qa',7369,sysdate,1234,100,10);
end;
create or replace procedure p1(v emp%rowtype)
is
begin
  insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);
end;
--注意：in类型传参（仅普通类型可以以任意方式传参，记录类型等复杂类型需要以传变量方式）
declare
  --声名一个记录类型变量
  e emp%rowtype;
begin
  --设值
  e.empno:=9999;
  e.ename:='ss';
  e.job:='clerk';
  e.sal:=1234;
  e.deptno:=10;
  
  p1(e);
end;
select * from emp;
2.(变态题)写一个存储过程，输入一个字符串，在员工表中插入一条员工信息，字符串格式
员工编号,姓名,工作,上级编号,入职时间,佣金,部门编号

select empno||','||ename||','||job||','||mgr||','||hiredate||','||sal||','||comm||','||deptno from emp where empno=7499;

'7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30'

declare
   --声名一个变量保存字符串
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --声名一个变量保存截取结果
   tmp varchar2(50);
begin
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   tmp:=substr(s,1,instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   
   
   --第2个逗号位置  instr(s,',',1,2)
   --截取第2个数据，从第1个逗号+1的位置开始，长度：第2个逗号-第1个逗号-1
   tmp:=substr(s,instr(s,',',1,1)+1,instr(s,',',1,2)-instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   --第3个逗号位置 instr(s,',',1,3)
   --截取第3个数据，从第2个逗号+1的位置开始，长度：第3个逗号-第2个逗号-1
   tmp:=substr(s,instr(s,',',1,2)+1,instr(s,',',1,3)-instr(s,',',1,2)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,3)+1,instr(s,',',1,4)-instr(s,',',1,3)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,4)+1,instr(s,',',1,5)-instr(s,',',1,4)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,5)+1,instr(s,',',1,6)-instr(s,',',1,5)-1);
   dbms_output.put_line(tmp);
   tmp:=substr(s,instr(s,',',1,6)+1,instr(s,',',1,7)-instr(s,',',1,6)-1);
   dbms_output.put_line(tmp);
   
   --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
   tmp:=substr(s,instr(s,',',1,7)+1);
   dbms_output.put_line(tmp);
   --字符串类型，类型转换
   
   --插入到数据库，使用第1题的存储过程
end;


declare
   --声名一个变量保存字符串
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --声名一个变量保存截取结果
   tmp varchar2(50);
begin
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   tmp:=substr(s,1,instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   
   for i in 2..7 loop
     tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
     dbms_output.put_line(tmp);
   end loop;
   
   --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
   tmp:=substr(s,instr(s,',',1,7)+1);
   dbms_output.put_line(tmp);
   --字符串类型，类型转换
   
   --插入到数据库，使用第1题的存储过程
end;


declare
   --声名一个变量保存字符串
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --声名一个变量保存截取结果
   tmp varchar2(50);
begin
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   tmp:=substr(s,1,instr(s,',',1,1)-1);
   dbms_output.put_line(tmp);
   
   for i in 1..6 loop
     tmp:=substr(s,instr(s,',',1,i)+1,instr(s,',',1,i+1)-instr(s,',',1,i)-1);
     dbms_output.put_line(tmp);
   end loop;
   
   --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
   tmp:=substr(s,instr(s,',',1,7)+1);
   dbms_output.put_line(tmp);
   --字符串类型，类型转换
   
   --插入到数据库，使用第1题的存储过程
end;

declare
   --声名一个变量保存字符串
   s varchar2(300):='7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --声名一个变量保存截取结果
   tmp varchar2(50);
begin
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   for i in 1..8 loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=8 then
       --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     
   
   end loop;
   --字符串类型，类型转换
   
   --插入到数据库，使用第1题的存储过程
end;

declare
    s varchar2(300):='7499,ALLEN,SALESMAN,,1981-02-20,1600,300,30';
begin
   --计算字符串s中逗号的个数
end;

select length('aaa,bbb,ccc')-length(replace('aaa,bbb,ccc',',','')) from dual;


--'aaaxybbbxyccc' 字符串中xy个数
--（原字符串长度-替换所的字符串长度）/被替换的字符串长度
select (length('aaaxybbbxyccc')-length(replace('aaaxybbbxyccc','xy','')))/length('xy') from dual;

declare
   --声名一个变量保存字符串
   s varchar2(300):='9990,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30';
   --声名一个变量保存截取结果
   tmp varchar2(50);
   --声名一个变量保存列数
   n number;
   --声名一个变量保存一条emp表记录
   v emp%rowtype;
begin
   --获取列数
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   for i in 1..n loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=n then
       --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     --字符串类型，类型转换
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
     
   end loop;
   --插入到数据库，使用第1题的存储过程
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);  
end;

declare
   --声名一个变量保存字符串
   s varchar2(300):='9990,ALLEN,NULL,NULL,NULL,1600,NULL,30';
   --声名一个变量保存截取结果
   tmp varchar2(50);
   --声名一个变量保存列数
   n number;
   --声名一个变量保存一条emp表记录
   v emp%rowtype;
begin
   --获取列数
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   for i in 1..n loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=n then
       --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     --判断
     if tmp='NULL' then
       continue;
     end if;
     --字符串类型，类型转换
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
     
   end loop;
   --插入到数据库，使用第1题的存储过程
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);  
end;


create or replace procedure p2(s varchar2)
is
   --声名一个变量保存截取结果
   tmp varchar2(50);
   --声名一个变量保存列数
   n number;
   --声名一个变量保存一条emp表记录
   v emp%rowtype;
begin
   --获取列数
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --字符串分开，分为8个值
   --instr(s,',',1,1); --取第1个逗号位置
   --第1个字符串的截取，从1截取到 第1个逗号-1的长度 
   for i in 1..n loop
     if i=1 then
       tmp:=substr(s,1,instr(s,',',1,i)-1);
       dbms_output.put_line(tmp);
     elsif i=n then
       --最后一个值的获取，从第7个逗号+1的位置开始，截取到字符串的结束
       tmp:=substr(s,instr(s,',',1,i-1)+1);
       dbms_output.put_line(tmp);
     else
       tmp:=substr(s,instr(s,',',1,i-1)+1,instr(s,',',1,i)-instr(s,',',1,i-1)-1);
       dbms_output.put_line(tmp);
     end if;
     --判断
     if tmp='NULL' then
       continue;
     end if;
     --字符串类型，类型转换
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
     
   end loop;
   --插入到数据库，使用第1题的存储过程
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);  
end;

select * from emp;

字符串分割
类型转换
插入

---字符串分割
regexp_substr(字符串变量,正则表达式,开始位置,第几个): 根据正则表达式截取字符串

select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,1) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,2) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,3) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,4) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,5) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,6) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,7) from dual;
select regexp_substr('7499,ALLEN,SALESMAN,7698,1981-02-20,1600,300,30','[^,]+',1,8) from dual;


create or replace procedure p2(s varchar2)
is
   --声名一个变量保存列数
   n number;
   --声名一个变量保存截取到的字符串
   tmp varchar2(100);
   --声名一个变量保存转换后的数据
   v emp%rowtype;
begin
   --计算列数
   select length(s)-length(replace(s,',',''))+1 into n from dual;
   --
   for i in 1..n loop
     tmp:=regexp_substr(s,'[^,]+',1,i);
     --类型转换
     --字符串类型，类型转换
     case i 
       when 1 then
         v.empno:=to_number(tmp,'9999');
       when 2 then
         v.ename:=tmp;
       when 3 then 
         v.job:=tmp;
       when 4 then
         v.mgr:=to_number(tmp,'9999');
       when 5 then
         v.hiredate:=to_date(tmp,'yyyy-mm-dd');
       when 6 then
         v.sal:=to_number(tmp,'9999');
       when 7 then
         v.comm:=to_number(tmp,'9999');
       when 8 then
         v.deptno:=to_number(tmp,'9999');
     end case;
   end loop;
   --插入数据
   insert into emp values(v.empno,v.ename,v.job,v.mgr,v.hiredate,v.sal,v.comm,v.deptno);
end;
3.写一个存储过程，根据输入的参数,修改员工信息，(员工编号为必传参数)
 注：如果只输入员工姓名，那么就只修改姓名
     如果输入多个值，则修改员工的多个信息
     例如：输入员工的姓名、工作、工资，则要求
     把姓名、工作、工资信息都修改
create or replace procedure p3(v emp%rowtype)
is

begin
  update emp set ename=nvl(v.ename,ename),
                 job=nvl(v.job,job),
                 sal=nvl(v.sal,sal),
                 comm=nvl(v.comm,comm),
                 hiredate=nvl(v.hiredate,hiredate),
                 mgr=nvl(v.mgr,mgr),
                 deptno=nvl(v.deptno,deptno)
  where empno=v.empno;
end;
select nvl(comm,'无') from emp;

select nvl2(comm,comm||'￥','无') from emp;

create or replace procedure p3(v emp%rowtype)
is
   --声名一个字符串保存sql语句
   v_sql varchar2(500);
begin
   v_sql:='update emp set ';
   if v.ename is not null then
      v_sql:=v_sql||'ename='''||v.ename||''',';
   end if;
   if v.job is not null then
      v_sql:=v_sql||'job='''||v.job||''',';
   end if;
   if v.mgr is not null then
      v_sql:=v_sql||'mgr='||v.mgr||',';
   end if;
   if v.hiredate is not null then
      v_sql:=v_sql||'hiredate='''||v.hiredate||''',';
   end if;
   if v.sal is not null then
      v_sql:=v_sql||'sal='||v.sal||',';
   end if;
   if v.comm is not null then
      v_sql:=v_sql||'comm='||v.comm||',';
   end if;
   if v.deptno is not null then
      v_sql:=v_sql||'deptno='||v.deptno||',';
   end if;
   --去除最后一个逗号
   v_sql:=substr(v_sql,1,length(v_sql)-1);
   --拼接条件
   v_sql:=v_sql||' where empno='||v.empno;
   dbms_output.put_line(v_sql);
   --执行sql语句
   execute immediate v_sql;
end;

declare
   e emp%rowtype;
begin
  e.empno:=7369;
  e.ename:='haha';
  e.job:='clerk';
  e.hiredate:=sysdate;
  --e.mgr:=7499;
  --e.sal:=200;
  --e.comm:=100;
  --e.deptno:=10;
  p3(e);
end;

update emp set ename='haha',job='clerk',mgr=7499,hiredate='07-JAN-21',sal=200,comm=100,deptno=10 where empno=7369;
update emp set ename='haha',job='clerk',hiredate='07-JAN-21' where empno=7369
select * from emp where empno=7369;


create or replace procedure p3(v emp%rowtype)
is
   --声名一个字符串保存sql语句
   v_sql varchar2(500);
   --声名一个变量保存间隔符
   seq varchar2(1):='';
begin
   v_sql:='update emp set ';
   if v.ename is not null then
      v_sql:=v_sql||seq||'ename='''||v.ename||'''';
      seq:=',';
   end if;
   if v.job is not null then
      v_sql:=v_sql||seq||'job='''||v.job||'''';
      seq:=',';
   end if;
   if v.mgr is not null then
      v_sql:=v_sql||seq||'mgr='||v.mgr;
      seq:=',';
   end if;
   if v.hiredate is not null then
      v_sql:=v_sql||seq||'hiredate='''||v.hiredate||'''';
      seq:=',';
   end if;
   if v.sal is not null then
      v_sql:=v_sql||seq||'sal='||v.sal;
      seq:=',';
   end if;
   if v.comm is not null then
      v_sql:=v_sql||seq||'comm='||v.comm;
      seq:=',';
   end if;
   if v.deptno is not null then
      v_sql:=v_sql||seq||'deptno='||v.deptno;
      seq:=',';
   end if;
   --拼接条件
   v_sql:=v_sql||' where empno='||v.empno;
   dbms_output.put_line(v_sql);
   --执行sql语句
   execute immediate v_sql;
end;


create or replace procedure p3(v emp%rowtype)
is
   --声名一个字符串保存sql语句
   v_sql varchar2(500);
begin
   if v.ename is not null then
      v_sql:=v_sql||',ename='''||v.ename||'''';
   end if;
   if v.job is not null then
      v_sql:=v_sql||',job='''||v.job||'''';
   end if;
   if v.mgr is not null then
      v_sql:=v_sql||',mgr='||v.mgr;
   end if;
   if v.hiredate is not null then
      v_sql:=v_sql||',hiredate='''||v.hiredate||'''';
   end if;
   if v.sal is not null then
      v_sql:=v_sql||',sal='||v.sal;
   end if;
   if v.comm is not null then
      v_sql:=v_sql||',comm='||v.comm;
   end if;
   if v.deptno is not null then
      v_sql:=v_sql||',deptno='||v.deptno;
   end if;
   dbms_output.put_line(v_sql);
   --去除第1个逗号
   v_sql:=substr(v_sql,2);
   --拼接sql语句的前面
   v_sql:='update emp set '||v_sql;
   --拼接条件
   v_sql:=v_sql||' where empno='||v.empno;
   dbms_output.put_line(v_sql);
   --执行sql语句
   execute immediate v_sql;
end;

4.查找出当前用户模式下，每张表的记录数，以scott用户为例，结果应如下：
DEPT...................................4
EMP...................................14
BONUS.................................0
SALGRADE.............................5
提示：查找用户下所有表名的sql为select table_name from user_tables;
5.某cc表数据如下：
c1 c2
--------------
1 西
1 安
1 的
2 天
2 气
3 好
……
转换为
1 西安的
2 天气
3 好
要求：不能改变表结构及数据内容
6.创建一个过程，能向dept表中添加一个新记录.（in参数）
7.创建一个过程，从emp表中带入雇员的姓名，返回该雇员的薪水值。（out参数）
8.对所有员工,如果该员工职位是MANAGER，并且在DALLAS工作那么就给他薪金加15％；如果该员工职位是CLERK，并且在NEW YORK工作那么就给他薪金扣除5％;其他情况不作处理
对所有员工,如果该员工部门是SALES，并且工资少于1500那么就给他薪金加15％；如果该员工部门是RESEARCH，并且职位是CLERK那么就给他薪金增加5％;其他情况不作处理 
9.对直接上级是'BLAKE'的所有员工，按照参加工作的时间加薪：
81年6月以前的加薪10％
81年6月以后的加薪5％
10.编写一PL/SQL，对所有的"销售员"(SALESMAN)增加佣金500.
11.编写一个PL/SQL程序块，对名字以"A"或"S"开始的所有雇员按他们的基本薪水的10%加薪。
12.编写一PL/SQL，以提升两个资格最老的"职员"为"高级职员"。（工作时间越长，优先级越高）
13.显示EMP中的第四条记录。
14.编写一个给特殊雇员加薪10%的过程，这之后，检查如果已经雇佣该雇员超过60个月，则给他额外加薪3000.
