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
create directory directory as 'e:\data\';


    
