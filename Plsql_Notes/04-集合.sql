����
�����������ͣ����һ������������ͬ�����ݣ����±��ֵ��ɣ��±��������������
Ҳ�������ַ�������
���ϵķ��ࣺ������Ƕ�ױ��䳤����
���ϵ����ԣ�
     first:ȡ�����е�1��Ԫ�ص��±�
     last:ȡ���������һ��Ԫ�ص��±�
     count:ȡ�����е�Ԫ�ظ���
     limit:ȡ����������Ԫ�ظ���������ŵ�Ԫ�ظ�����
     next(�±�)����ʾȡ��������һ��Ԫ�ص��±�
     prior(�±�):��ʾȡ��������һ��Ԫ�ص��±�
     extend(n[,ind]):n��һ����Ȼ�� ind�Ǽ�����ĳ��Ԫ�ص��±�,��������չn��Ԫ�أ�
               ��������2������ʱ����ʾ��չ��n��Ԫ��ֵ��ind�±��Ӧ��ֵ
     delete():ɾ�������е�����Ԫ�� 
     
1.������
���������һ������������ͬ�����ݣ��±�������ַ�����Ҳ���������֣�pls_integer,binary_integer��
   �������Ԫ�ظ��������ƣ���һ���±��һ��ֵ���Ϳ����������������һ��Ԫ��
   ������ֻ����plsql�������ʹ��

���������͵Ķ��壺
type �������� is table of Ԫ��ֵ������ index by �±����������;

���������������
������ ��������;

ʹ�ã�
��������Ҫ��ʼ����Ҳ����Ҫ��չ����һ���±��ֵ�������Ԫ��
ע�⣺��������±��Զ����򣬴�С����
declare
   --����һ������ַ������͵�����������
   type ctype is table of varchar2(30) index by varchar2(30);
   --����һ�����������
   c ctype;
begin
   --�������������Ԫ��
   c('a'):='smith';
   c('1'):='scott';
   c('b'):='alen';
   c('6'):='king';
   --�����������
   dbms_output.put_line('�������count���ԣ�'||c.count); --4
   dbms_output.put_line('�������first���ԣ�'||c.first); --1
   dbms_output.put_line('�������last���ԣ�'||c.last); --b
   dbms_output.put_line('������next(''6'')������'||c.next('6')); --a
   dbms_output.put_line('������prior(''6'')������'||c.prior('6')); --1
   
   
   dbms_output.put_line('�������1��Ԫ��ֵ��'||c(c.first)); --��һ��Ԫ��ֵscott
   dbms_output.put_line('���������һ��Ԫ��ֵ��'||c(c.last)); --���һ��Ԫ��ֵ alen
end;


declare
   --����һ������ַ������͵�����������
   type ctype is table of varchar2(30) index by varchar2(30);
   --����һ�����������
   c ctype;
   --����һ��ѭ���������漯�ϵ��±�
   ind varchar2(30);
begin
   --�������������Ԫ��
   c('a'):='smith';
   c('1'):='scott';
   c('b'):='alen';
   c('6'):='king';
   --���ϵı���loopѭ��
   --��ʼ��ѭ������
   ind:=c.first;
   --loopѭ��
   loop
      /**
        ind=i1
        1   ind=i1    c(i1)ȡ��1��Ԫ�ش�ӡ   i1=c.last������   ind=c.next(i1)=i2
        2   ind=i2    c(i2)...............   i2=c.last .....   ind=c.next(i2)=i3
        ...
        ..
      
      */
      --ѭ�������
      dbms_output.put_line(ind||'->'||c(ind));
      --�˳�ѭ�����
      exit when ind=c.last;
      --ѭ���������
      ind:=c.next(ind);
   end loop;
end;
     
declare
   --����һ������������
   type ctype is table of varchar2(30) index by pls_integer;
   --����һ�����ϱ���
   c ctype;
   
   --����һ���������漯�ϵ��±�
   ind pls_integer;
begin
   --���������Ԫ��
   c(1):='smith';
   c(2):='scott';
   c(3):='alen';
   c(4):='king';
   --whileѭ������
   --��ʼ��ѭ������
   ind:=c.first;
   /***
     ind=1
     1   ind=1   1<=4����      ��ӡc(1)    ind=c.next(1)=2
     2   ind=2   2<=4...       ....c(2)    ind=c.next(2)=3
     3   ind=3   3<=4 ...      ��ӡc(3)    ind=c.next(3)=4
     4   ind=4   4<=4...       ��ӡc(4)    ind=c.next(4)Ϊ��
     5   ind=null null<=4��������  �˳�ѭ��   
   */
   while ind<=c.last loop
      --ѭ�������
      dbms_output.put_line(ind||'-->'||c(ind));
      --ѭ���������
      ind:=c.next(ind);
   end loop;
   dbms_output.put_line(ind);
   
end;


declare
   --����һ������������
   type ctype is table of varchar2(30) index by pls_integer;
   --����һ�����ϱ���
   c ctype;
   
   --����һ���������漯�ϵ��±�
   ind pls_integer;
begin
   --���������Ԫ��
   c(1):='smith';
   c(2):='scott';
   c(3):='alen';
   c(4):='king';
   
   for i in c.first..c.last loop
     dbms_output.put_line(c(i));
   end loop;
   
end loop;

bulk collect���������ʹ����intoǰ��(����������ʹ����bulk collect�����ʱ���±�ֻ������������)
select * bulk collect into ���ϱ��� from emp;
execute immediate select���  bulk collect into ���ϱ���
fetch �α�  bulk collect into ���ϱ���

declare
   --����һ������������
   type ctype is table of emp%rowtype index by pls_integer;
   --����һ�����ϱ���
   c ctype;
begin
   --��ѯ����Ա����Ϣ
   select * bulk collect into c from emp;
   for i in c.first..c.last loop
     dbms_output.put_line(c(i).empno||','||c(i).ename||','||c(i).job||','||c(i).deptno);
   end loop;
end;

declare
   --����һ������������
   type ctype is table of varchar2(30) index by pls_integer;
   --����һ������
   jobs ctype;
   names ctype;
begin
   select ename,job bulk collect into names,jobs from emp;
   for i in names.first..names.last loop
     dbms_output.put_line(names(i)||','||jobs(i));
   end loop;
end;

--˼����
���������������������(�±���������������)
��32,12,33,5,21,44,66,1,3,4�����������������
declare
   type ctype is table of number(3) index by pls_integer;
   c ctype;
   c2 ctype;
   
   --����һ����������c2���±�
   ci pls_integer;
begin
   c(1):=32;
   c(2):=12;
   c(3):=33;
   c(4):=5;
   c(5):=21;
   c(6):=44;
   c(7):=66;
   c(8):=1;
   c(9):=3;
   c(10):=4;
   for i in c.first..c.last loop
     c2(c(i)):=0;
   end loop;
   --����c2ʱ����ʹ��forѭ��
   --��ʼ��ѭ������
   ci:=c2.first;
   --����
   loop
     --ѭ������� c2(ci);
     dbms_output.put_line(ci);
     --�˳�ѭ������
     exit when ci=c2.last;
     --ѭ���������
     ci:=c2.next(ci);
   end loop;
   dbms_output.put_line(rpad('-',50,'-'));
   --��ʼ��ci
   ci:=c2.last;
   loop
     --ѭ�������
     dbms_output.put_line(ci);
     exit when ci=c2.first;
     ci:=c2.prior(ci);
   end loop;
end;

declare
   type ctype is table of number(3) index by pls_integer;
   c ctype;
   
   --����һ������������ʱֵ
   t number;
begin
   c(1):=32;
   c(2):=12;
   c(3):=33;
   c(4):=5;
   c(5):=21;
   c(6):=44;
   c(7):=66;
   c(8):=1;
   c(9):=3;
   c(10):=4;
   for i in 1..9 loop
      /**
        i=1
        2..10
        1 ��     c(1)>c(2)  
      */
      --ð������
      for j in reverse i+1..10 loop
        if c(j-1) < c(j) then
           t:=c(j-1);
           c(j-1):=c(j);
           c(j):=t;
        end if; 
      end loop;
   end loop; 
   
   for i in c.first..c.last loop
     dbms_output.put_line(c(i));
   end loop;
end;


declare
   a number:=5;
   b number:=7;
   --����һ������������ʱֵ
   t number;
begin
   dbms_output.put_line(a);
   dbms_output.put_line(b);
   /**
  --��a��ֵ����t��
   t:=a;
   --��b��ֵ����a��
   a:=b;
   --��t�е�ֵ����b
   b:=t;
   dbms_output.put_line(a);
   dbms_output.put_line(b);
  */
   a:=a+b;  --12
   b:=a-b; --b=a-b=12-7=5
   a:=a-b;  --a=a-b=12-5=7
   dbms_output.put_line(a);
   dbms_output.put_line(b);
end;


2.Ƕ�ױ�
Ƕ�ױ�:�洢һ������������ͬ�����ݣ������±���������������������plsql�������ʹ�ã�
Ҳ���Դ��������ݿ��У�ʹ��ǰ��Ҫ��ʼ������չ��ע�⣺bulk collect into�в���Ҫ��ʼ������չ��

Ƕ�ױ�Ķ����﷨��
type ������ is table of ��������;

ʹ�ò��裺
1.��������
2.��ʼ������
  ������:=������();   --��ʼ��һ���յ�Ƕ�ױ�
  ������:=������(ֵ,ֵ,....); --��ʼ��һ����ֵ��Ƕ�ױ�
3.���Ԫ��
  ��չ
  ������.extend(n)
  ������(�±�):=ֵ;
  
����ʱʹ��forѭ���Ϳ���

declare
   --����һ��Ƕ�ױ�����
   type ttype is table of varchar2(30);
   --����һ��Ƕ�ױ����
   t ttype;
begin
   --��ʼ��Ƕ�ױ�
   t:=ttype(); --��ʼ��һ���յ�Ƕ�ױ�
   --
   dbms_output.put_line(t.count);
   
   --t(1):='xt';--������ֱ�Ӹ�ֵ
   --��չ
   t.extend(1);
   dbms_output.put_line(t.count);
   dbms_output.put_line(t(1));
   --��ֵ
   t(1):='xt';
   dbms_output.put_line(t(1));
   t.extend(1);
   t(2):='xx';
   t.extend(1);
   t(3):='xy';
   for i in t.first..t.last loop
      dbms_output.put_line(i||'-->'||t(i));
   end loop;
   
   --��չ�����ֵ��Ԫ��
   t.extend(5,1);--��չ5��Ԫ�ز��Һ��±���1��Ԫ��ֵ ��ͬ
   
   dbms_output.put_line(rpad('-',50,'-'));
    for i in t.first..t.last loop
      dbms_output.put_line(i||'-->'||t(i));
   end loop;
end;

declare
   --����һ��Ƕ�ױ�����
   type ttype is table of varchar2(30);
   t ttype;
begin
   --��ʼ��Ƕ�ױ�
   t:=ttype('smith','alen','scott','king');
   --��ӡԪ�ظ���
   dbms_output.put_line(t.count);
   --���� 
   for i in t.first..t.last loop
     dbms_output.put_line(i||'-->'||t(i));
   end loop;
end;

--ע�⣺����bulk collect into����в���Ҫ��ʼ������չ
declare
   --����һ��Ƕ�ױ�������Ա��������
   type ttype is table of varchar2(30);
   --����һ��Ƕ�ױ����
   t ttype;
begin
   --ʹ��select into �����ݲ�ѯ������t�У���������ӡ
   select ename bulk collect into t from emp;
   
   for i in t.first..t.last loop
     dbms_output.put_line(t(i));
   end loop;
end;

declare
   --����һ��Ƕ�ױ�����
   type ttype is table of varchar2(30);
   --����һ������
   t ttype;
   --����һ���α�
   cursor cur is select ename from emp;
begin
   --���α�
   open cur;
   fetch cur bulk collect into t;
   --�ر��α�
   close cur;
   --���� Ƕ�ױ����
   for i in t.first..t.last loop
     dbms_output.put_line(t(i));
   end loop;
  
end;

returning  bulk collect into ����:���ؼ����У�����Ҫ��������������

����Ƕ�ױ����ͣ�
create type �������� is table of ��������;
create type tttype is table of varchar2(30);

declare
   --����һ��Ƕ�ױ����
   c tttype;
begin
   select ename bulk collect into c from emp where deptno=10;
   for i in c.first..c.last loop
     dbms_output.put_line(c(i));
   end loop;
end;

�ڽ���ʱʹ��Ƕ�ױ����ͣ�
create table ����1(
  ����  ��������,
  Ƕ�ױ�����  Ƕ�ױ�����
)nested table Ƕ�ױ����� store as ����2;

select 'drop table '||table_name||';' from user_tables where table_name not in('EMP','DEPT','SALGRADE');

create table tab1(
  dno number(5),
  names tttype
)nested table names store as tab2;

insert into tab1 values(10,TTTYPE('SMITH','SCOTT','KING'));

insert into tab1 values(20,TTTYPE('A','B','C'));
select * from tab1;

ʹ��table���Ӳ�ѯ:��ֻ����Լ����У�Ƕ�ױ��䳤���飩�����е��е��Ӳ�ѯ
select * from table(select names from tab1 where dno=20);


3.�䳤��������
�䳤���飺���һ������������ͬ�����ݣ��±�Ҳ�����ӵ��������ͣ�����ʱ��Ҫ
        ָ����󳤶ȣ�ʹ��ǰ��Ҫ��ʼ������չ��bulk collect�в���Ҫ��
�����﷨��
type �������� is varray(��󳤶�) of ��������;

��ʼ���﷨����չ�﷨ͬǶ�ױ�

declare
    --����һ���䳤��������
    type atype is varray(10) of varchar2(30);
    --��������
    arr atype;
begin
    --��ʼ��
    arr:=atype('oracle','mysql','sqllite','hbase');
    --��ӡԪ�ظ���
    dbms_output.put_line('count����:'||arr.count);
    --��ӡ���Ԫ�ظ���
    dbms_output.put_line('limit���ԣ�'||arr.limit);
    
    --arr(5):='mariadb'; --�������
    arr.extend(1);
    arr(5):='mariadb';
    
    --arr.extend(6,1);
    arr.extend(5,1);
    
    --����
    for i in arr.first..arr.last loop
      dbms_output.put_line(arr(i));
    end loop;
end;

declare
   --����һ���䳤�������ͣ���������Ա������
   type atype is varray(10) of varchar2(30);
   --����һ������
   a atype;
begin
   select ename bulk collect into a from emp where deptno=30;
   
end;

�����䳤�������ͣ�
create type �������� is varray(����) of ��������;

create type aatype is varray(20) of varchar2(30);

create table ����(
  ���� ��������,
  �䳤������ �䳤��������
)

create table tab3(
  dno number(5),
  names aatype
)

insert into tab3 values(10,aatype('plsql','java','python','php'));

select * from tab3;

select * from table(select names from tab3 where dno=10);


������ֻ���ڴ������ʹ��
        �±��ַ������������ͣ����ҿ��Բ�����
        û�б߽磬��һ���±��ֵ���Ϳ������һ��Ԫ��
        ����Ҫ��ʼ������չ
Ƕ�ױ��������ڴ������ʹ�ã�Ҳ���Դ��������ݿ���
        �±�ֻ��������������
        û�б߽磬���Ԫ��ʱ����Ҫ����չ
        ��Ҫ��ʼ������չ
�䳤���飺�������ڴ������ʹ�ã�Ҳ���Դ��������ݿ���
         �±�ֻ��������������
         �б߽磬���Ԫ��ʱ����Ҫ����չ
         ��Ҫ��ʼ������չ
         
bulk collect

��������
forall��䣺ֻ�����ڼ�����
�﷨��
forall ���� in ����
   dml��䣨insert,delete,update��
   
дһ������飬������С��3000���˼�н500
declare
   --����һ�����ϴ洢Ա�����
   type itype is table of number(5) index by pls_integer;
   --����һ�����������
   c itype;
begin
   --��ѯ������С��3000��Ա����Ա����ţ����浽����c��
   select empno bulk collect into c from emp where sal<3000;
   for i in c.first..c.last loop
      update emp set sal=sal+500 where empno=c(i);
   end loop;
end;

declare
   --����һ�����ϴ洢Ա�����
   type itype is table of number(5) index by pls_integer;
   --����һ�����������
   c itype;
begin
   --��ѯ������С��3000��Ա����Ա����ţ����浽����c��
   select empno bulk collect into c from emp where sal<3000;
   
   forall i in c.first..c.last
      update emp set sal=sal+500 where empno=c(i);
end;

select * from emp;
