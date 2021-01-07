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
create directory directory as 'e:\data\';


    
