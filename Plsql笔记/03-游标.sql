�α�
�α꣺oracle������sql���ʱ�����sql������һ�����������α���ָ�������������һ����ַ
      �α���Ի�ȡ��sql����ִ�н��,��Ϊ��ʽ�α����ʾ�α�
�α����ԣ�
%found:�������ͣ����α굱ǰָ������ݲ�Ϊ��ʱ������true,���򷵻�false
%notfound:�������ͣ���%found�෴�����α�ָ�������Ϊ��ʱ������true ���򷵻�false
%isopen:�������ͣ���ǰ�α��ʱ����true���α�δ��ʱ����false
%rowcount:�������ͣ������α�ĵ�ǰ��¼��������������ȡ�α��еļ�¼������Ҳ����������¼�α굱ǰ���ݵ��к�

�α��ʹ�ò��裺
δ��ʱ %isopen = false
%rowcount,%found��%notfound��ֵ��Ч
1.���α�
%isopen=true
%rowcount=0
%found��%notfound��ֵ��Ч
open �α�����|�α����
2.ʹ���α�
fetch �α� into ����;
�α���������ʱ
%found=true
%notfound=false
%rowcount��ֵ�����������+1
�α�ȡ�����һ������֮��
%found=false
%notfound=true
%rowcount��ֵ��ʾ��������
3.�ر��α�
close �α�
%found,%notfound,%rowcount��������
%isopen=false

select * from emp;

1����ʽ�α�
��ִ��dml��䣨insert,update,delete��ʱ��oracle����һ����sql���α꣬����ʹ��sql����%rowcount���ԣ�
��ȡ��ɾ������޸ĵ����ݿ���������
sql%rowcount
begin
  update emp set sal=sal+500 where sal<3000;
  dbms_output.put_line(sql%rowcount);
end;
2����ʽ�α�
��ʽ�α������select���
�α�Ķ����﷨��
cursor �α� is select���;
���α�
open �α�
�����α꣨ʹ��fetch into��䣩
fetch �α� into ����
�ر��α�
close �α�

������loopѭ��,whileѭ����forѭ��

declare
   --����һ���α�
   cursor cur is select * from dept;
   --%rowtype   dept%rowtype  cur%rowtype
   v cur%rowtype;
   
begin
   --���α�
   open cur;
   --δִ��fetch intoǰ%found��%notfound������
   if cur%found then
     dbms_output.put_line('true');
   end if;
   if cur%notfound then
     dbms_output.put_line('true');
   end if;
   dbms_output.put_line(cur%rowcount); ---��ӡ0
   --����
   dbms_output.put_line('-----------------------------------------');
   fetch cur into v;
   if cur%found then
     dbms_output.put_line('true1');  --��ӡtrue
   end if;
   if cur%notfound then
     dbms_output.put_line('true2');
   end if;
   dbms_output.put_line(cur%rowcount);
   dbms_output.put_line('-----------------------------------------');
   fetch cur into v;
   fetch cur into v;
   fetch cur into v;
   fetch cur into v;
   if cur%found then
     dbms_output.put_line('true3'); 
   end if;
   if cur%notfound then
     dbms_output.put_line('true4'); --��������������֮��%notfound=true
   end if;
   dbms_output.put_line(cur%rowcount); --��ʾ��������������
   --�ر��α�
   close cur;
  
end;

declare
   --����һ���α�
   cursor cur is select * from dept;
   --����һ�����������α��е�һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --ȡ�α��е����ݣ�fetch into
   fetch cur into v;
   --���ݴ���
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
      --ȡ�α��е����ݣ�fetch into
   fetch cur into v;
   --���ݴ���
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
      --ȡ�α��е����ݣ�fetch into
   fetch cur into v;
   --���ݴ���
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
      --ȡ�α��е����ݣ�fetch into
   fetch cur into v;
   --���ݴ���
   dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
   --�ر��α�
   close cur;
end;
begin
  for v in (select * from dept) loop
    dbms_output.put_line(v.deptno||','||v.dname||','||v.loc);
  end loop;
end;

--loopѭ�������α�
declare
   --����һ���α�
   cursor cur is select * from emp;
   --����һ�����������α��һ����¼
   v cur%rowtype;
begin
   --���α�
   open cur;
   --����
   loop
      --ִ��fetch into���
      fetch cur into v;
      --�ж��˳�����
      exit when cur%notfound;
      --ѭ������룬ʵ�ֹ��ܵĴ���
      dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
      
   end loop;
   dbms_output.put_line('������������'||cur%rowcount);
   --�ر��α�
   close cur;
end;

--whileѭ�������α�
declare
   --����һ���α�
   cursor cur is select * from emp;
   --����һ�����������α��е�һ����¼
   v cur%rowtype;
begin
  --���α�
  open cur;
  --ִ��fetch��䣬ȡ�α��еĵ�1������
  fetch cur into v;
  --����
  while cur%found and cur%rowcount<=4 loop  --û��ִ��fetch into���ǰ��%found��%notfound������ true=1>0 false=0<1
     --ѭ���壬��������
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
     --ѭ���������
     fetch cur into v;
  end loop;
  
  --�ر��α�
  close cur;
end;

--forѭ�������α�
declare
   --����һ���α�
   cursor cur is select * from emp;
begin
   for v in cur loop --v�������ھֲ�����    
     --ѭ�������
     dbms_output.put_line(cur%rowcount||','||v.empno||','||v.ename||','||v.job||','||v.mgr||','||v.hiredate||','||v.sal||','||v.comm||','||v.deptno);
   end loop;
end;

declare
   --����һ���������ͱ���
   b boolean:=false;
begin
   while b loop
     dbms_output.put_line('a');
     
   end loop;
end;


ȫ�ֱ����;ֲ�������Ե�

declare
   v1 varchar2(30):='hello'; --begin --end֮�䶼������ ȫ�ֱ���
begin
   for n in 1..9 loop  --nֻ����loop ��end loop ֮��ʹ�ã��ֲ�����
     dbms_output.put_line(v1);
     dbms_output.put_line(n);
   end loop;
   dbms_output.put_line(v1);
end;

declare
   v1 varchar2(30):='hh'; --ȫ�ֱ���
begin
   --�ӿ�
   declare
      v2 varchar2(30):='aa';  --�ֲ�����
   begin
       --v2����ʹ��
       --v1Ҳ����ʹ��
   end;
   --ֻ��ʹ��v1
end;
