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
   i pls_integer;
   tmp number(3);
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
   for i in c.first+1..c.last loop
     for m in c.first..c.last-1 loop
       if c(i) < c(M) then
         tmp := c(m);
         c(m) := c(i);
         c(i) := tmp;
         end if;
       end loop;
     end loop;
     for i in c.first..c.last loop
     dbms_output.put_line(c(i));
     end loop;
     end;
     
declare
   type ctype is table of number(3) index by pls_integer;
   c ctype;
   t ctype;
   i pls_integer;
   
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
     t(c(i)) := 1;
     end loop;
     
     i := t.first;
     loop
       dbms_output.put_line(i);
       exit when i = t.last;
       i := t.next(i);
       end loop;
       end;
