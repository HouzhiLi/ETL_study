1.���̿������
(1) if���
�﷨��
if �������ʽ; then
  plsql ��䣨sql�������̿�����䣩
  end if
  ���������ʽ����ʱ������then��end֮��Ĵ���
  --�жϱ��Ƿ���ڣ���������ڣ��򴴽���
  --��������ڣ�����һ��dept_sum�����ܲ����µ�������ƽ�����ʣ��ܹ��ʣ���߹��ʣ���͹���
declare
--����һ�����������ѯ���
n number(1); 
begin
  --�ж����ݿ����Ƿ����dept_sum���ű�
  --ͨ����ѯ���ݿ��ֵ���ͼ�ж�
  --select count(table_name) from user_tables where table_name = 'dept_num'; --���>0��ʾ�����
  select count(1) into n from user_tables where table_name = 'dept_sum';
  if n = 0 then 
    --����dept_sum��
    execute immediate 'create table dept_sum(deptno number, member number, avg_sal number(8,2), sum_sal number(8,2), max_sal number(8,2), min_sal number(8,2))';
  end if;
  --�粻���ڣ��򴴽���
  --��������һ������
  execute immediate 'insert into dept_sum select deptno, count(1), avg(sal), sum(sal), max(sal), min(sal) from emp group by deptno'; 
  end;
(2) if else
�﷨
if �������ʽ then
  plsql ���
  else
    plsql���
    end if;
    --дһ�����룬��������ֵ���Ƚϴ�С����ӡ�ϴ�ֵ
    declare
    --�������������ֱ𱣴����������ֵ
    m number := &m;
    n number := &n;
    begin
      if m > n then
        dbms_output.put_line(m);
        else
          dbms_output.put_line(n);
          end if;
          end;
          
(3) if elsif
�﷨
if �������ʽ then
  plsql���
  elsif �������ʽ then
    plsql���
    elsif �������ʽ then
      ...
      else
        plsql���
        end if��
        ��ʾ��һ����������ʱ��ִ����Ӧ��then����Ĵ���
        --����һ���ɼ������ݳɼ����ж������в�
        --60���� ��
        --60-70 ��
        --70-80 ��
        --80���� ��
        declare
        --����һ���������������ֵ
        score number(4,1) := &score;
        begin
          if score < 60 then
            dbms_output.put_line('��');
            elsif score >= 60 and score <70 then
              dbms_output.put_line('��');
              elsif score >= 70 and score < 80 then
                dbms_output.put_line('��');
                else
                  dbms_output.put_line('��');
                  end if;
                  end;
        
(4) case ���
�﷨��
case 
  when �������ʽ then
    plsql���;
     when �������ʽ then
    plsql���;
    ...
    else
      plsql���
      end case;
�﷨2��
case ���ʽ
  when ���1 then
    plsql sentances;
    when res2 then
      plsql sentances;
      ...
      else
        plsql sentances;
        end case;
        similar to decode funcation: --���ʽ����һ���̶��Ľ������ǰ�ý���ͺ���when���оٵĽ����ͬʱ��ִ�ж�Ӧ�� plsql���
declare
--
score number(4,1) := &sc;
begin
  case when score < 60 then
    dbms_output.put_line('d');
    when score < 70 then 
      dbms_output.put_line('c');
      when score < 80 then
        dbms_output.put_line('b');
        else
          dbms_output.put_line('a');
          end case;
          end;     
-- �ܷ�����Ĵ�����case�ĵڶ����﷨��д
floor(score/10)
0-60      0,1,2,3,4,5         ��
60-70    6                        ��
70-80   7                         ��
80-100  8, 9, 10               ��

declare 
score number(4,1) := &sc;
begin
  case floor(score/10)
    when 10 then
      dbms_output.put_line('a');
      when 9 then
        dbms_output.put_line('a');
        when 8 then
          dbms_output.put_line('a');
          when 7 then
            dbms_output.put_line('b');
            when 6 then
              dbms_output.put_line('c');
              else
                dbms_output.put_line('d');
                end case;
                end;
(5) loop
�﷨��
ѭ������ͬ�����ƵĴ����ظ�ִ��
loop
  ѭ�������;
  �˳�ѭ�����;
  ѭ���������;
  end loop;
ѭ�������������ʵ����Ҫ���ܺ�ҵ��Ĵ���
�˳�ѭ����䣺��������ѭ������
ѭ��������䣺��֤ѭ�����������˳�
--��ӡ1-9
ѭ������룺dbms_output.put_line();

declare
n number := 1;
begin
loop
      dbms_output.put_line(n);
      exit when n = 9;
      n := n+1;
      end loop;
      end;
      
(6)while
�﷨��
while ѭ������ loop
  ѭ�������;
  ѭ���������;
  end loop
  
  declare 
  n number := 1;
  begin
    while n <= 9 loop
      dbms_output.put_line(n);
      n := n+1;
      end loop;
      end; 
      
(7)for
�﷨��
for ѭ������ in [reverse] ����|�α�|select��� loop
  --ѭ�������
  end loop;
  
  reverse����ʾ��ת
  ���ϣ���ʾ�򵥵����������ּ��� 1-9 1..9 ��ʾ�򵥵� 1-9 �����ּ���

begin
  for n in 1..9 loop
    dbms_output.put_line(n);
    end loop;
    end;
    forѭ���������ڱ����й̶��߽磬nѭ������û����declare������������ֻ����forѭ����ʹ��

begin 
  for n in reverse 1..9 loop
    dbms_output.put_line(n);
    end loop;
    end;    

--дһ������飬���÷���ѭ��������emp����10�Ų��ŵ�����Ա����Ϣ
begin 
  for v /* ��¼����*/ in (select * from emp where deptno = 10) loop
    dbms_output.put_line(v.empno || ', ' || v.ename);
    end loop;
    end;
    
loop: ��Ҫ����ѭ�����������������ڴ��������ط�ʹ�ã�ѭ�����⣩
�������˳�ѭ������
��Ҫѭ���������
while: ��Ҫ����ѭ�����������������ڴ��������ط�ʹ�ã�ѭ�����⣩
������ѭ������
��Ҫѭ���������
for��ѭ����������Ҫ������ֻ����ѭ����ʹ�ñ�����������һ�����ּ���ʱ��ѭ��������һ����ͨ������������һ��select���ʱ��ѭ��������һ����¼����
����������Ҫ����
����Ҫѭ���������
forѭ�����Ա���select���Ĳ�ѯ�����

exit����ѭ���������˳�ѭ�������

begin
  for n in 1..9 loop
    --��n=5ʱִ��exit
    if n = 5 then 
      exit;
      end if;
      dbms_output.put_line(n);
      end loop;
       dbms_output.put_line('----');
      end;
      --1, 2, 3, 4, ----
      
continue���˳�����ѭ����������һ��ѭ��

begin
  for n in 1..9 loop
    --��n=5ʱִ��exit
    if n = 5 then 
      continue;
      end if;
      dbms_output.put_line(n);
      end loop;
       dbms_output.put_line('----');
      end;
      --1, 2, 3, 4, 6, 7, 8, 9, ----
      
return����ʾ��������(return����Ĵ��붼����ִ��)

begin
  for n in 1..9 loop
    --��n=5ʱִ��exit
    if n = 5 then 
      return;
      end if;
      dbms_output.put_line(n);
      end loop;
       dbms_output.put_line('----');
      end;
      -- 1, 2, 3, 4
      
null�������

--˼���⣺ʹ��loop��whileѭ����ʵ������forѭ����Ч��

dbms_output.put_line(); ��ӡ������
dbms_output.put('\n'); ��ӡ�������У����뻻�в�����ʾ
dbms_output.newline(); ����
