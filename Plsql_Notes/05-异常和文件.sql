�쳣���ļ���д��
1.�쳣
�쳣���������й����г��ֵĴ��󣬰�������,���ݿ⣬Ӳ��������ȴ���
�쳣�Ĳ������׳��쳣�Ͳ����쳣�������쳣��
�쳣�ķ��ࣺϵͳ�����쳣���Զ����쳣
1)�����쳣
ORA-00904: invalid column name ��Ч����
ORA-00942: table or view does not exist �������ͼ������
ORA-01400: cannot insert NULL into () ���ܽ���ֵ����
ORA-00936:��ȱ�ٱ��ʽ
ORA-00933:��SQL ����δ��ȷ����
ORA-01722:����Ч���֣���һ���������ͼ���ַ������͵�ֵ���������Ͷ���ɣ�
ORA-06530: ACCESS_INTO_NULL��
      Your program attempts to assign values to the attributes of an uninitialized (atomically null) object.
��ͼ��ֵд��δ�������������
ORA-06592: CASE_NOT_FOUND
     None of th choice in the WHEN clauses of a CASE statement is selected, and there is no ELSE clause.
case����ʽ����û�з�֧���
ORA-06531: COLLECTION_IS_NULL
     Your program attempts to apply collection methods othe than EXIST to an uninitialized(atomically null) nested table or varray, or th program attempts to assign values to the elements of an uninitialized nested table or varray.
��ͼ����������δ��ʼ����Ƕ�ױ���
ORA-06511: CURSOR_ALREADY_OPEN
     Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened. A cursor FOR loop automatically opens the cursor to which it refers. So, your program cannot open that cursor inside the loop.
��ͼ���Ѿ��򿪵�ָ�룮ָ���Ѿ��򿪣�Ҫ�ٴδ򿪱����ȹرգ�
ORA-00001: DUP_VAL_ON_INDEX
     Your program attempts to store duplicate values in a database column that is constrained by a unique index.
���ݿ��ֶδ洢�ظ�������Ψһֵ��ͻ
ORA-01001: INVALID_CURSOR����Чָ��
    Your program attempts an illegal cursor operation such as closing an unopened cursor.
�Ƿ�ָ�����������ر�δ�򿪵�ָ��
ORA-01722: INVALID_NUMBER����Ч����
     In a SQL statement, the conversion of a character string into a number fails because the string does not represent a valid number. (In procedural statements, VALUE_ERROR is raised.) This exception is also raised when the LIMIT-clause expression in a bulk FETCH statement does not evaluate to a positive number.
��sql����У��ַ���������ת�������޷����ַ���ת������Ч���֣��˴���Ҳ������Ϊ��limit�Ӿ���ʽ��fetch����޷���Ӧָ������
ORA-01017: LOGIN_DENIED���ܾ�����
     Your program attempts to log on to Oracle with an invalid username and/or password.
��ͼ����Ч���û����������¼oracle

ORA-01403: NO_DATA_FOUND �����ݷ���
     A SELECT INTO statement returns no rows, or your program references a deleted element in a nested table or an uninitialized element in an index-by table. SQL aggregate functions such as AVG and SUM always return a value or a null. So, a SELECT INTO statement that calls an aggregate function never raises NO_DATA_FOUND. The FETCH statement is expected to return no rows eventually, so when that happens, no exception is raised.

ORA-01012: NOT_LOGGED_ON   δ��¼
     Your program issues a database call without being connected to Oracle.
���������ݿ������δ��oracle��������

ORA-06501: PROGRAM_ERROR �������
     PL/SQL has an internal problem.
pl/sqlϵͳ����

ORA-06504: ROWTYPE_MISMATCH �����Ͳ�ƥ��
    The host cursor variable and PL/SQL cursor variable involved in an assignment have incompatible return types.
For example, when an open host cursor variable is passed to a stored subprogram, the return types of the actual and formal parameters must be compatible.

ORA-30625: SELF_IS_NULL
     Your program attempts to call a MEMBER method on a null instance. That is, the built-in parameter SELF (which is always the first parameter passed to a MEMBER method) is null.

ORA-06500: STORAGE_ERROR �洢����
     PL/SQL runs out of memory or memory has been corrupted.
PL/SQL�����ڴ�������ڴ��ͻ
     
ORA-06533: SUBSCRIPT_BEYOND_COUNT   �Ӿ䳬������
      Your program references a nested table or varray element using an index number larger than the number of elements in the collection.

ORA-06532: SUBSCRIPT_OUTSIDE_LIMIT   �Ӿ�Ƿ�����
Your program references a nested table or varray element using an index number (-1 for example) that is outside the legal range.

ORA-01410: SYS_INVALID_ROWID   ��Ч���ֶ���
   The conversion of a character string into a universal rowid fails because the character string does not represent a valid rowid.
ORA-00051: TIMEOUT_ON_RESOURCE    ��Դ�ȴ���ʱ
A time-out occurs while Oracle is waiting for a resource.
ORA-01422: TOO_MANY_ROWS    ���س���һ��
A SELECT INTO statement returns more han one row.
ORA-06502: VALUE_ERROR   ֵ����
An arithmetic, conversion, truncation, or size-constraint error occurs. For example, when your program selects a column value into a character variable, if the value is longer than the declared length of the variable, PL/SQL aborts the assignment and raises VALUE_ERROR. In procedural statements, VALUE_ERROR is raised if the conversion of a character string into a number fails. (In SQL statements, INVALID_NUMBER is raised.)
ORA-01476: ZERO_DIVIDE ��0����
Your program attempts to divide a number by zero.

declare
   ��������;
begin
   �����;
   --�쳣������(�����쳣��������)
   exception
     when �쳣���� then
       �쳣�������
     when �쳣���� then
       �쳣�������
       ...
     when others then
       �쳣�������
end;
declare
  --����һ������
  v emp%rowtype;
begin
  select * into v from emp where 1=0;
  /*
  exception --���񲢴����쳣
    when no_data_found then
      dbms_output.put_line('���������');
  */
end;

sqlcode:�����쳣�ı���,no_data_found���صı�����100,
sqlerrm:�����쳣����Ϣ

declare
  --����һ������
  v emp%rowtype;
begin
  select * into v from emp where 1=0;
  
  exception --���񲢴����쳣
    when no_data_found then
      dbms_output.put_line('���������');
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


2.�Զ����쳣
�﷨��
�쳣����  exception;  --����һ���쳣

declare
  myexc exception; --����һ���쳣
begin
  null;
end;

�׳��쳣�﷨��
raise �쳣����;  --�׳�һ���Զ����쳣
dbms_standard.raise_application_error(�쳣����,'�쳣��Ϣ'); --�׳�һ��ҵ���쳣�������Զ����쳣�����ȡֵ��Χ-20000~-20999

declare
  myexc exception; --����һ���쳣
begin
  raise myexc;
  exception
    when myexc then
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);
end;

begin
  --�׳�һ��ҵ���쳣��Ӧ���쳣��
  dbms_standard.raise_application_error(-20001,'�ҵ��쳣');
  exception 
    when others then
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);
end;

�쳣�󶨣�
pragma exception_init(�쳣����,�쳣����); --д��declare���ֵ�

declare
   --�Զ���һ���쳣����
   myexc exception;
   --���Զ����쳣�󶨵�-20001
   pragma exception_init(myexc,-20001);
begin
   --�׳�һ��ҵ���쳣��Ӧ���쳣��
   dbms_standard.raise_application_error(-20001,'�ҵ��쳣');
   exception 
     when myexc then
       dbms_output.put_line(sqlcode);
       dbms_output.put_line(sqlerrm);
end;

declare
   --����һ���쳣����
   myexc exception;
   --��������ͻ�쳣�󶨵�myexc
   pragma exception_init(myexc,-00001);
begin
   insert into dept values(10,'aa','bb');
   exception
     when myexc then
       dbms_output.put_line(sqlcode);
       dbms_output.put_line(sqlerrm);
end;

ע�⣺begin��exception��֮���Ǵ���鲿�֣�
exception��end֮�����д��붼���쳣������룬ֻ���ڳ����쳣ʱ����ִ��






declare
   --����һ���쳣����
   myexc exception;
   --��������ͻ�쳣�󶨵�myexc
   pragma exception_init(myexc,-00001);
begin
   --����һ��������Ϣ
   insert into dept values(50,'aa','bb');
   
   exception
     when myexc then
       dbms_output.put_line(sqlcode);
       dbms_output.put_line(sqlerrm);
       --���ò������Ա��
   dbms_output.put_line('����Ա����Ϣ');
end;


declare
   --����һ���쳣����
   myexc exception;
   --��������ͻ�쳣�󶨵�myexc
   pragma exception_init(myexc,-00001);
begin
   begin
     --����һ��������Ϣ
     insert into dept values(10,'aa','bb');
     
     exception
       when myexc then
         dbms_output.put_line(sqlcode);
         dbms_output.put_line(sqlerrm);
         --���ò������Ա��
   end;
   dbms_output.put_line('����Ա����Ϣ');
end;

3.�ļ���д
utl_file.file_type:�ļ�����
utl_file.fopen(Ŀ¼·��,�ļ�����,��д��ʽ)�����ļ��ķ���
Ŀ¼·����ָoracle��directory���������,Ŀ¼��Ҫ��д�����ַ����ķ�ʽ����
          directory��Ŀ¼������һ��������ϵĵ�ַ��·����
      �﷨��
       create directory Ŀ¼�� as Ŀ¼·��;
       
       create directory ospath as '/home/oracle';  --����һ��Ŀ¼ָ��/home/oracleĿ¼
       
       create directory filepath as 'd:/data';
       
 �ļ����ƣ��ַ������͵�����
 ��д��ʽ���ַ�������
            r:��ʾ��ȡ�ļ�
            w:��ʾд�ļ�
            a:��ʾ׷��      


utl_file.put_line(�ļ�����,д�������)�����ļ���д������
�ļ�����:utl_file.file_type�ļ�����
д������ݣ��ַ�������

utl_file.get_line(�ļ��������ַ�������):��ȡ�ļ���һ�����ݣ��������ݱ��浽�ַ���������
�ļ�������utl_file.file_type����

utl_file.fclose(�ļ�����):�ر��ļ�
�ļ�����:utl_file.file_type�ļ�����


1.�����ļ�����
2.���ļ������ļ�������ֵ��
3.����д�ļ�
4.�ر��ļ�

--д�ļ�����
declare
   --����һ���ļ�����
   f utl_file.file_type;
   
begin
   --���ļ�  ��test.txt������ʱ�����Զ�����һ���µ��ļ�������ļ����ڣ���ô�Ὣԭ�ļ�����ɾ������д���µ�����
   f:=utl_file.fopen('OSPATH','test.txt','w');
   --���ļ���д������
   utl_file.put_line(f,'Oracle');
   
   utl_file.put_line(f,'SQL');
   
   utl_file.put_line(f,'PLSQL');
   --�ر��ļ�
   utl_file.fclose(f);
   
end;
declare
   --����һ���ļ�����
   f utl_file.file_type;
   
begin
   --���ļ�  ��test.txt������ʱ�����Զ�����һ���µ��ļ�������ļ����ڣ���ô�Ὣԭ�ļ�����ɾ������д���µ�����
   f:=utl_file.fopen('OSPATH','test.txt','w');
   --���ļ���д������
   utl_file.put_line(f,'1234');

   --�ر��ļ�
   utl_file.fclose(f);
end;

--���ļ���׷������
declare
   --����һ���ļ�����
   f utl_file.file_type;
begin
   --���ļ� a��ʽ ���ļ�������ʱ�����Զ��������ļ�������ļ����ڣ������ļ����һ���������
   f:=utl_file.fopen('OSPATH','2.txt','a');
   --д������
   utl_file.put_line(f,'haha');
   utl_file.put_line(f,'xixi');
   --�ر��ļ�
   utl_file.fclose(f);
end;

--��ȡ�ļ�
declare
   --����һ���ļ�����
   f utl_file.file_type;
   --����һ�����������ȡ�����ļ�һ������
   v varchar2(200);
begin
   --���ļ�
   f:=utl_file.fopen('OSPATH','2.txt','r');
   --��ȡ�ļ�һ�����ݵ�����v��
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   --��ȡ�ļ�һ�����ݵ�����v��
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   
   --��ȡ�ļ�һ�����ݵ�����v��
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   --��ȡ�ļ�һ�����ݵ�����v��
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   
   --��ȡ�ļ�һ�����ݵ�����v��
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   --��ȡ�ļ�һ�����ݵ�����v��
   utl_file.get_line(f,v);
   dbms_output.put_line(v);
   
   --utl_file.get_line(f,v); ����ȡ�����ʱ��û�����ݻᱨno_data_found�쳣
   --�ر��ļ�
   utl_file.fclose(f);
end;


declare
   --����һ���ļ�����
   f utl_file.file_type;
   --����һ�����������ȡ�����ļ�һ������
   v varchar2(200);
begin
   --���ļ�
   f:=utl_file.fopen('OSPATH','2.txt','r');
   loop  --�˳�ѭ��ʹ��no_data_found�쳣
     --��ȡ�ļ�һ�����ݵ�����v��   
     begin
        utl_file.get_line(f,v);
        dbms_output.put_line(v);
        exception
          when no_data_found then
            exit;
     end;
   end loop;
   --utl_file.get_line(f,v); ����ȡ�����ʱ��û�����ݻᱨno_data_found�쳣
   --�ر��ļ�
   utl_file.fclose(f);
end;


declare
   --����һ���ļ�����
   f utl_file.file_type;
   --����һ�����������ȡ�����ļ�һ������
   v varchar2(200);
begin
   --���ļ�
   f:=utl_file.fopen('OSPATH','2.txt','r');
   begin
      loop  --�˳�ѭ��ʹ��no_data_found�쳣
     --��ȡ�ļ�һ�����ݵ�����v��   
     
       
        utl_file.get_line(f,v);
        dbms_output.put_line(v);
      
      end loop;
      exception
          when no_data_found then
            null;
   end;
   --utl_file.get_line(f,v); ����ȡ�����ʱ��û�����ݻᱨno_data_found�쳣
   --�ر��ļ�
   utl_file.fclose(f);
end;


--������д��
declare
   --����һ���ļ�����
   f utl_file.file_type;
   --����һ�����������ȡ�����ļ�һ������
   v varchar2(200);
begin
   --���ļ�
   f:=utl_file.fopen('OSPATH','2.txt','r');
   loop  --�˳�ѭ��ʹ��no_data_found�쳣
   --��ȡ�ļ�һ�����ݵ�����v��       
      utl_file.get_line(f,v);
      dbms_output.put_line(v);       
   end loop;
   --utl_file.get_line(f,v); ����ȡ�����ʱ��û�����ݻᱨno_data_found�쳣
   --�ر��ļ�
   exception
      when no_data_found then
          utl_file.fclose(f);
end;

--дһ�����뽫����Ա����������д���ļ���
declare
   --�����ļ�����
   f utl_file.file_type;
   
begin
   --���ļ�
   f:=utl_file.fopen('OSPATH','enames.txt','w');
   for v in (select ename from emp) loop
     utl_file.put_line(f,v.ename); --��Ա������д���ļ���
   end loop;
   --�ر��ļ�
   utl_file.fclose(f);
end;


--дһ�����򽫲��ű��е����ݱ��浽�ļ���
declare
   --����һ���ļ�����
   f utl_file.file_type;
   
begin
   --���ļ�
   f:=utl_file.fopen('OSPATH','dept.dat','w');
   for v in (select deptno||','||dname||','||loc s from dept) loop
      utl_file.put_line(f,v.s);
   end loop;
   --�ر��ļ�
   utl_file.fclose(f);
end;

--��������뱣���ļ��ļ������뵽һ�ű��У������Ѵ�������dept��ṹ��ͬ��
