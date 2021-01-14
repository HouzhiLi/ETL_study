declare
cursor cur is select table_name from user_tables where table_name not in ('EMP', 'DEPT', 'SALGRADE');
begin
  for v in cur loop
    dbms_output.put_line('drop table ' || v.table_name || ';');
    end loop;
    end;
