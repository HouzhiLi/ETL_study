declare
myexc exception;
v_boardline varchar2(100):= rpad('-', 50, '-');
pragma exception_init(myexc, -20001);
begin
  begin
   dbms_standard.raise_application_error(-20001, 'takamikazu');
  exception 
    when myexc then
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    end;
    dbms_output.put_line(v_boardline);
    begin
      raise myexc;
      exception when myexc then
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
        end;
    dbms_output.put_line(v_boardline);
    end;
