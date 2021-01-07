declare
myexc exception;
v_boardline varchar2(100):= rpad('-', 50, '-');
pragma exception_init(myexc, -00001);
begin
/*  begin
   dbms_standard.raise_application_error(-20001, 'invalid password');
  exception 
    when myexc then
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    end;*/
    dbms_output.put_line(v_boardline);
begin
  insert into dept values(10, 'a', 'b');
  exception
    when myexc then
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);   
      end;
  /*  begin
      raise myexc;
      exception 
        when myexc then
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        end;*/
    dbms_output.put_line(v_boardline);
    end;
-----------------------------------------------------------------------------------------------
utl_file.file_type -- 文件变量类型
utl_file.fopen(directory_name, file_name, open_mode); -- 打开文件的方法，目录名是oracle中directory对象的名字必须大写，打开方式 r： 表示只读/w：表示写/a：表示追加
utl_file.get_line(v_file, v_char) -- 读取文件的一行内容，将内容保存到字符串变量中
utl_file.put_line(v_file, content) -- 向文件中写入一行内容
utl_file.fclose(v_file) -- 关闭文件

创建目录
create directory directory_name as 'syspath'; -- 需要oracle用户有读写权限
create directory filepath as 'e:\data';
drop directory directory;
grant drop any directory to scott;

declare
f utl_file.file_type;
begin
  f := utl_file.fopen('FILEPATH', 'test.txt', 'w');
  utl_file.put_line(f, 'aaa');
  utl_file.put_line(f, 'bbb');
  utl_file.fclose(f);
  end;

declare
f utl_file.file_type;
v varchar2(300);
begin
  f := utl_file.fopen('FILEPATH', 'test.txt', 'r');
  begin
  loop
    utl_file.get_line(f, v);
    dbms_output.put_line(v);
    end loop;
    exception 
      when no_data_found then
        null;
        end;
        utl_file.fclose(f);
        end;
 
-----------------------------------------------------------------------   

--将dept表中数据写入到csv文件中
declare
f utl_file.file_type;
cursor cur is select deptno || ',' || dname || ',' || loc as s from dept;
begin
  f := utl_file.fopen('FILEPATH', 'test.txt', 'w');
  for v in cur loop
    utl_file.put_line(f, v.s);
    end loop;
  utl_file.fclose(f);
  end;

--将csv文件导入到备份表中
create table dept_bak as select * from dept where 1 = 0;
select * from dept_bak;

declare
f utl_file.file_type;
v varchar2(300);
cursor cur is select * from dept_bak;
begin
  f := utl_file.fopen('FILEPATH', 'test.txt', 'r');
  begin
  loop
    utl_file.get_line(f, v);
    dbms_output.put_line(v);
    insert into dept_bak values (substr(v, 1, instr(v, ',', 1, 1)-1), substr(v, instr(v, ',', 1, 1)+1, instr(v, ',', 1, 2) - (instr(v, ',', 1, 1)+1)), substr(v, instr(v, ',', 1, 2)+1));
    end loop;
    exception 
      when no_data_found then
        null;
        end;
        utl_file.fclose(f);
    dbms_output.put_line(rpad('-', 50, '-'));    
        for v in cur loop
          dbms_output.put_line(v.deptno|| ', ' || v.dname|| ', ' || v.loc);
          end loop;
          rollback;
        end;
        


