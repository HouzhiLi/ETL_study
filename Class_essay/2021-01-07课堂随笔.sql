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
utl_file.file_type -- �ļ���������
utl_file.fopen(directory_name, file_name, open_mode); -- ���ļ��ķ�����Ŀ¼����oracle��directory��������ֱ����д���򿪷�ʽ r�� ��ʾֻ��/w����ʾд/a����ʾ׷��
utl_file.get_line(v_file, v_char) -- ��ȡ�ļ���һ�����ݣ������ݱ��浽�ַ���������
utl_file.put_line(v_file, content) -- ���ļ���д��һ������
utl_file.fclose(v_file) -- �ر��ļ�

����Ŀ¼
create directory directory_name as 'syspath'; -- ��Ҫoracle�û��ж�дȨ��
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

--��dept��������д�뵽csv�ļ���
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

--��csv�ļ����뵽���ݱ���
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
        


