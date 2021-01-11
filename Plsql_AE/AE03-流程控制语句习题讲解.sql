1-���̽�������ֵ����ӡ�Ƚϴ��ֵ
declare
  --���������������������ֵ
  m number:=&m;
  n number:=&n;
begin
  if m> n then
    dbms_output.put_line(m);
  else
    dbms_output.put_line(n);
  end if;
end;

2-���̽�������ֵ�������մӴ�С���δ�ӡ
declare
   --��������������������ֵ
   x number:=&x;
   y number:=&y;
   z number:=&z;
begin
   if x>=y and y>=z then
     dbms_output.put_line('x='||x||',y='||y||',z='||z);
   elsif x>=z and z>=y then
     dbms_output.put_line('x='||x||',z='||z||',y='||y);
   elsif y>=x and x>=z then
     dbms_output.put_line('y='||y||',x='||x||',z='||z);
   elsif y>=z and z>=x then
     dbms_output.put_line('y='||y||',z='||z||',x='||x);
   elsif z>=x and x>=y then
     dbms_output.put_line('z='||z||',x='||x||',y='||y);
   else
     dbms_output.put_line('z='||z||',y='||y||',x='||x);
   end if;
end;
  

declare
   --��������������������ֵ
   x number:=&x;
   y number:=&y;
   z number:=&z;
begin
   --x��y
   if x>y then
     --x>y
     --x��z�Ƚ�ȡ���ֵ
     if x>z then
        --x>y  x>z  �Ƚ� y��z
        if y>z then
            --x>y x>z y>z --x>y>z
            dbms_output.put_line('x='||x||',y='||y||',z='||z);
        else
            --x>y x>z  z>y  --x>z>y
            dbms_output.put_line('x='||x||',z='||z||',y='||y);
        end if;
     else
        --x>y  z>=x  z>x>y
        dbms_output.put_line('z='||z||',x='||x||',y='||y);
     end if;
   else
      --y>=x  �Ƚ� y��zȡ���ֵ
      if y>z then
        --y>z y>=x �Ƚ� x��z
        if x>z then
          --y>z y>x x>z  y>x>z
          dbms_output.put_line('y='||y||',x='||x||',z='||z);
        else
          --y>z y>x z>x  y>z>x
          dbms_output.put_line('y='||y||',z='||z||',x='||x);
        end if;
      else
        --z>=y  y>=x   z>y>x
        dbms_output.put_line('z='||z||',y='||y||',x='||x);
      end if;
   end if;
end; 

declare
   --��������������������ֵ
   x number:=&x;
   y number:=&y;
   z number:=&z;
begin
   ---��һ�ű�����ֵ����
   --����sql������������
   --ɾ�����ű�
   for v in  (select * from 
   (select 'x' s,x n from dual 
   union all 
   select 'y' s,y n from dual 
   union all 
   select 'z' s,z n from dual) order by n desc) loop
      dbms_output.put_line(v.s||'='||v.n);
   end loop;
end;

select * from (
select 'x' s, 1 n from dual
union all
select 'y' s, 2 n from dual
union all
select 'z' s, 3 n from dual)
order by n desc;

create table tt(
  name varhcar2(2),
  n number(10)
);




4-�ж�һ������ǲ�������
���꣺�ܱ�4���������ܱ�100����   ���߱�400����
declare
   --����һ����������һ�����
   n number(4):=&��;
begin
   if (mod(n,4)=0 and mod(n,100)!=0) or mod(n,400)=0 then
       dbms_output.put_line(n||'������');
   else
       dbms_output.put_line(n||'��������');
   end if; 
end;


5-����ָ����BMI��=���أ�kg�������^2��m��

ƫ��  <= 18.4
����  18.5 ~ 23.9
����  24.0 ~ 27.9
����  >= 28.0
��Ҫ���������غ���ߣ��������ָ�����ڷ�Χ

declare
   --���������������ֱ𱣴����أ���ߣ�����ָ��
   w number(4,1):=&����;
   h number(3,2):=&���;
   
   s number(4,2);
begin
   --��������ָ��
   s:=w/(h*h); --w/h/h  w/power(h,2)
   --���������ж�����״��
   if s<=18.4 then
     dbms_output.put_line('ƫ��');
   elsif s<=23.9 then
     dbms_output.put_line('����');
   elsif s<=27.9 then
     dbms_output.put_line('����');
   else
     dbms_output.put_line('����');
   end if;
   
end;

6-����һ�������ж�����������ż��
declare
   --����һ���������������ֵ
   n number:=&��;
begin
   if mod(n,2)=0 then
      dbms_output.put_line(n||'��ż��');
   else
      dbms_output.put_line(n||'������');
   end if;
end;

1.��дһ������飬��emp������ʾ��Ϊ��SMITH���Ĺ�Ա��нˮ��ְλ
declare
   --�����������������ѯ���
   v_sal emp.sal%type;
   v_job emp.job%type;
begin
   select sal,job into v_sal,v_job from emp where ename='SMITH';
   --��ӡ���
   dbms_output.put_line(v_sal||','||v_job);
end;

begin
   for v in (select sal,job from emp where ename='SMITH' ) loop
     dbms_output.put_line(v.sal||','||v.job);
   end loop;
end;

2.��дһ������飬�����û�����һ�����źţ���dept������ʾ�ò��ŵ�����������λ��

declare
  --����һ���������沿�ű��
  dno number:=&���ű��;
  --����һ���������沿����Ϣ
  v dept%rowtype;
begin
  select * into v from dept where deptno=dno;
  --��ӡ���
  dbms_output.put_line(v.dname||','||v.loc);
end;


3.��дһ������飬����%type���ԣ�����һ����Ա�ţ���emp������ʾ�ù�Ա������нˮ(����нˮ��Ӷ��)
declare
   --����һ����������Ա�����
   eno number:=&Ա�����;
   --����һ����������Ա��������нˮ
   v_salary number;
begin
   select sal+nvl(comm,0) into v_salary from emp where empno=eno;
   --��ӡ���
   dbms_output.put_line(v_salary);
end;

declare
   --����һ����������Ա�����
   eno number:=&Ա�����;
   --����һ����������Ա��������нˮ
   v_salary number;
   v_comm number;
begin
   select sal,nvl(comm,0) into v_salary,v_comm from emp where empno=eno;
   --��ӡ���
   dbms_output.put_line(v_salary+v_comm);
end;


4.��дһ������飬����%rowtype���ԣ�����һ����Ա�ţ���emp������ʾ�ù�Ա������нˮ

declare
   --����һ��emp%rowtype���ͱ���
   v emp%rowtype;
begin
   --����һ��Ա�����
   v.empno:=&Ա�����;
   select sal+nvl(comm,0) into v.sal from emp where empno=v.empno;
   
   dbms_output.put_line(v.sal);
end;


5.ĳ��˾Ҫ���ݹ�Ա��ְλ����н����˾���������м�н�ṹ����
   Designation      Raise
   ------------     --------
   clerk            500
   salesman         1000
   analyst          1500
   otherwise        2000
��дһ������飬����һ����Ա������emp����ʵ��������н����
declare
   --����һ����������һ��Ա������
   v_ename emp.ename%type:='&Ա������';
begin
   update emp set sal=case 
         when job=upper('clerk') then sal+500 
         when job=upper('salesman') then sal+1000
         when job=upper('analyst') then sal+1500
         else
           sal+2000
         end  where ename=v_ename; 
          
end;

select * from emp;
select 'drop trigger '||object_name||';' from user_objects where object_type='TRIGGER';

declare

begin
   update emp set sal=sal+500 where ename='&Ա������' and job=upper('clerk');
   update emp set sal=sal+1000 where ename='&Ա������' and job=upper('salesman');
   update emp set sal=sal+1500 where ename='&Ա������' and job=upper('analyst');
   update emp set sal=sal+2000 where ename='&Ա������' and job not in (upper('analyst'),upper('salesman'),upper('clerk'));
end;


declare
   --����һ����������Ա����Ϣ
   v emp%rowtype;
begin
   --����Ա��������ѯԱ����Ϣ
   select * into v from emp where ename='&Ա������';
   --ʹ��if�����ж�
   if v.job=upper('clerk') then
      update emp set sal=sal+500 where empno=v.empno;  
   elsif v.job=upper('salesman') then
      update emp set sal=sal+1000 where empno=v.empno;
   elsif v.job=upper('analyst') then
      update emp set sal=sal+1500 where empno=v.empno;
   else
      update emp set sal=sal+2000 where empno=v.empno;
   end if;
   
end;

declare
   --����һ����������Ա����Ϣ
   v emp%rowtype;
begin
   --����Ա��������ѯԱ����Ϣ
   select * into v from emp where ename='&Ա������';
   --ʹ��if�����ж�
   if v.job=upper('clerk') then
      v.sal:=v.sal+500;
   elsif v.job=upper('salesman') then
      v.sal:=v.sal+1000;
   elsif v.job=upper('analyst') then
      v.sal:=v.sal+1500;
   else
      v.sal:=v.sal+2000;
   end if;
   update emp set sal=v.sal where empno=v.empno;
   
end;



drop trigger T8;
drop trigger T7;
drop trigger T6;
drop trigger T5;
drop trigger T4;
drop trigger T3;
drop trigger T2;
drop trigger T1;



13.����������㲻��ʽ 1+3^2+5^2+��+N^2>2000����СNֵ��
+
1   1^2   power(n,2)
3   3^2   power(n,2)
5   5^2   power(n,2)
s:=0;

s:=s+pwer(n,2)


declare
   --����һ������n ,ѭ������
   n number:=1;
   
   --����һ������s��������ʽ����ͽ�� 
   s number:=0;
begin
   /**
     n=1 s=0
     
     1   n=1    s=s+power(n,2)0+1=1    s>2000����������   n=n+2=3
     2   n=3    s=s+power(n,2)1+3^2    s>2000����������   n=n+2=5
     3   n=5    ...................    ...............    n=n+2=7
     ....
     
     ����n=x��ʱ���˳�ѭ��
         n=x-2  s=1+....(x-2)^2        ...............    n=n+2=x
         n=x    s=1+........x^2        s>2000�����˳�ѭ��
     
   */
   loop
      --ѭ�������
      s:=s+power(n,2);
      --�˳�ѭ�����
      exit when s>2000;
      --ѭ���������
      n:=n+2;
   
   end loop;
   
   dbms_output.put_line(n);
end;

declare
   --����һ������n ,ѭ������
   n number:=1;
   
   --����һ������s��������ʽ����ͽ�� 
   s number:=0;
begin
   /**
      n=1  s=0
      
      1  n=1   s<2000   s=s1         n=n+2=3
      2  n=3   s1<2000  s=s1+s3      n=n+2=5
      3  n=5   s1+s3<2000   s=s1+..s5  n=7
      ....
      ���õ�xʱֵ�պ�С��2000  x+2
      
         nx   s1+..+sx-2 <2000   s=s1+...sx  n=x+2
         x+2  s1+..+sx<2000     s=s1+sx+2    n=x+4
         x+4  s1+s2+..sx+2�˳�
   */
   while s<=2000 loop
      --ѭ�������
      s:=s+power(n,2);  --1.  power(1,2)
      --ѭ���������
      n:=n+2;
   
   end loop;
   dbms_output.put_line(n-2);
end;

declare
   s number:=0;
   --����һ����������n��ֵ
   i number;
begin
  /**
    1    n=1   s=s1     s>2000    i=n=1
    2    conitnue;
    3    n=3   s=s1+s3  s>2000    i=3
    .....
        ���� n=xʱ s1+s3....sx>2000
        n=x-2  s=s1+s3...+sx-2    s1+s3+...+sx-2<2000   i=x-2
        n=x    s=s1+...+sx        s1+s3....+sx>2000�˳�   
  */
  for n in 1..50 loop
     if mod(n,2)=0 then
        continue;
     end if; 
     --ѭ�������
      s:=s+power(n,2);
      --�˳�ѭ�����
      exit when s>2000;
      --��ֵ
      i:=n;
  end loop;
  dbms_output.put_line(i+2);
end;



14.����Ա���е����й���С��3000����400��ͳ�Ƴ����ӹ��ʵ����������ӵĹ���������
declare
  --����һ����������Ա������
  n number;
begin
   --��ѯ����С��3000������
   select count(1) into n from emp where sal<3000;
   --��С3000���˼�400
   update emp set sal=sal+400 where sal<3000;
   --��ӡ���
   dbms_output.put_line('������'||n||',����������'||(n*400));
end;

declare
   --����һ������������ͳ������
   n number:=0;
begin
   for v in (select * from emp where sal<3000) loop
      --����+1
      n:=n+1;
      update emp set sal=sal+400 where empno=v.empno;
   end loop;
   dbms_output.put_line('������'||n||',����������'||(n*400));
end;


begin
   update emp set sal=sal+400 where sal<3000;
   dbms_output.put_line('������'||sql%rowcount||',����������'||(sql%rowcount * 400));
end;

15.�ӹ�Ա������ʾ������ߵ�ǰ����˵����������ź͹��ʡ�

begin
   for v in (select * from (select * from emp order by sal desc) where rownum<=5) loop
     
     dbms_output.put_line(v.ename||','||v.deptno||','||v.sal);
   end loop;
end;

declare
   n number:=0;
begin
   /**
    n=0
    1   n=n+1=0+1=1    ��ӡ
    2   n=n+1=2        ...
    ....
    5   n=n+1=5        ��ӡ   
   */
   for v in (select empno,ename,job,mgr,sal,hiredate,comm,deptno from emp order by sal desc) loop
     n:=n+1;
     dbms_output.put_line(v.ename||','||v.deptno||','||v.sal);
     exit when n=5;
   end loop;
end;




6.��дһ������飬��emp���й�Ա��ȫ����ʾ����
begin
  for v in (select ename from emp) loop
    dbms_output.put_line(v.ename);
  end loop;
end;

7.��дһ������飬��emp����ǰ5�˵�������ʾ����
begin
   for v in (select ename from emp where rownum<=5) loop
     dbms_output.put_line(v.ename);
   end loop;
end;


8.�������������������ʾ���������ڶ�����Ϊ0������ʾ��Ϣ����������Ϊ0��
declare
   --���������������ֱ𱣴汻�����ͳ���
   m number:=&������;
   n number:=&����;
begin
   if n=0 then
     dbms_output.put_line('��������Ϊ��');
   else
     dbms_output.put_line(m/n);
   end if;
end;

9���������漶����ĩ��С��0.001ʱ�Ĳ��ֺ͡� 
1/(1*2)+1/(2*3)+1/(3*4)+��+1/(n*(n+1))+ ����
declare
   --����һ����������ÿһ���ֵ 1/(n*(n+1))
   s number;
   --����һ���������棬������ʽ�ĺ�  1/(1*2) +...1/(n*(n+1))
   t number:=0; 
   --����һ��ѭ������n
   n number:=1;
begin
   /**
     s=?    t=0   n=1
     
     1  n=1    s=s1     t=t+s=s1    s1<0.001����������    n=n+1
     2  n=2    s=s2     t=s1+s2     s2<...............    n=n+1=3
     3  n=3    s=s3     t=s1+s2+s3  s3<..............     ......
     .........
     ����n=x  sx<0.001
        n=x-1  s=sx-1   t=s1+..sx-1  sx-1 ������          n=n+1=x
        n=x    s=sx     t=s1+....sx  sx<0.001 �����˳�
   
   */
   loop
      --ѭ������� ������ÿ���ֵ s��ֵ
      s:=1/(n*(n+1));
      t:=t+s;
      --�˳�ѭ�����
      exit when s<0.001;
      --ѭ���������
      n:=n+1;
   end loop;
   
   dbms_output.put_line(t);
end;


10������s=1*2+2*3+��+N*(N+1),��N=50��ֵ��
declare
   --����һ�����������ʽ�Ľ��
   s number:=0;
begin
   for n in 1..50 loop
     --ѭ�������
     s:=s+n*(n+1);
   end loop;
   --��ӡ���
   dbms_output.put_line(s);
end;

11.��дһ��PL/SQL����飬��emp���ж������ԡ�A����"S"��ʼ�����й�Ա�����ǻ���нˮ��10%�����Ǽ�н
begin
  update emp set sal=sal*1.1 where ename like 'A%' or ename like 'S%';
end;

begin
   for v in (select * from emp where ename like 'A%' or ename like 'S%') loop 
     update emp set sal=sal*1.1 where empno=v.empno;
   end loop;
end;

begin
   for v in (select * from emp) loop
     if instr(v.ename,'A')=1 or instr(v.ename,'S')=1 loop
       update emp set sal=sal*1.1 where empno=v.empno;
     end if;
   end loop;
end;

12������ѭ��������S=1!+2!+��+10!��!��ʾ�׳�
5��=5*4*3*2*1
declare
  --����һ����������׳˽��
  m number:=1;
begin
  for n in 1..5 loop
     m:=m*n;
  end loop;
end; 
declare
  --����һ����������׳� ���
  m number:=1;
  --����һ������������ʽ�Ľ��
  s number:=0;
begin
  /**
    ��1 
       1      i =1   m=1
                        �� for j in 1..1 loop
                         1    m:=m*j 1*1=1!
                     
                        s=s+m=0+1=1!
       2      i=2    m=1
                        ��  for j  in 1..2 loop
                        1  j=1  m=m*j=1*1
                        2  j=2 m=m*j=1*2=2��
                        s=s+m=1!+2!
       3      i=3    m=1
                        ��  for j in 1..3 loop
                        
                        1  j=1  m=m*j=1*1
                        2  j=2  m=m*j=1*2
                        3  j=3  m=m*j=1*2*3=3��
                        s=s+m=1!+2!+3!
  
  
  */  


  for i in 1..10 loop
    ---��ʼ������m
    m:=1;
    for j in 1..i loop
      m:=m*j;
    end loop;
    --������ʽ�Ľ��
    s:=s+m;
  end loop;
  
  dbms_output.put_line(s);
end;

declare
   --����һ������������ʽ�Ľ��
   s number:=0;
   --����һ����������׳˵Ľ��
   m number:=1;
begin
   /**
     s=0  m=1
     
     1  n=1   m=m*n=1*1=1!   s=s+m=0+1!=1!
     2  n=2   m=m*n=1!*2=2!  s=s+m=1!+2!
     3  n=3   m=m*n=2!*3=3!  s=s+m=1!+2!+3!
     4  n=4   m=m*n=3!*4=4!  s=s+m=1!+2!+3!+4!
   */
   for n in 1..10 loop
     --����׳� 
     m:=m*n;
     --������ʽ�Ľ��
     s:=s+m;
   end loop;
   dbms_output.put_line(s);
end;



��ӡ9*9�˷���

1*1=1
1*2=2 2*2=4
������������������

                     1*1=1
               1*2=2 2*2=4
               
begin
   --���ѭ����ʾ��
   for i in 1..9 loop
     --�ڲ�ѭ����ʾ��
     for j in 1..i loop
        dbms_output.put(rpad(j||'*'||i||'='||(i*j)||' ',7,' '));
     end loop;
     --����
     dbms_output.put_line(''); --dbms_output.new_line();
   end loop;
end;

                                                        1*1=1   1  8*7
                                                 1*2=2  2*2=4   2  7*7
                                          1*3=3  2*3=6  3*3=9   3  6*7
                                   1*4=4  2*4=8  3*4=12 4*4=16  4  5*7
                            1*5=5  2*5=10 3*5=15 4*5=20 5*5=25  5  4*7
                     1*6=6  2*6=12 3*6=18 4*6=24 5*6=30 6*6=36  6  3*7
              1*7=7  2*7=14 3*7=21 4*7=28 5*7=35 6*7=42 7*7=49  7  2*7
       1*8=8  2*8=16 3*8=24 4*8=32 5*8=40 6*8=48 7*8=56 8*8=64  8  1*7
1*9=9  2*9=18 3*9=27 4*9=36 5*9=45 6*9=54 7*9=63 8*9=72 9*9=81  9  0*7

begin
   --���ѭ����ʾ��
   for i in reverse 1..9 loop
     --��ӡ�ո�
     /*
     for j in  1..(9-i)*7 loop
       dbms_output.put(' ');
     end loop;
     */
     dbms_output.put(rpad(' ',((9-i)*7),' '));
     --�ڲ�ѭ����ʾ��
     for j in 1..i loop
        dbms_output.put(rpad(j||'*'||i||'='||(i*j)||' ',7,' '));
     end loop;
     --����
     dbms_output.put_line(''); --dbms_output.new_line();
   end loop;
end;
                     *       �ո�
     *        1      1        5
    ***       2      3        4
   *****      3      5        3
  *******     4      7        2
 *********    5      9        1
***********   6      11       0
                    2n-1     6-n
                    
                    
begin
  --��������
  for i in 1..6 loop
    --��ӡ�ո�
    for j in 1..6-i loop
      dbms_output.put(' ');
    end loop;
    --��ӡ*
    for j in 1..(2*i-1) loop
      dbms_output.put('*');
    end loop;
    --����
    dbms_output.new_line();
  end loop;
end;

declare
  --����һ��������������
  n number:=&����;

begin
  --��������
  for i in 1..n loop
    --��ӡ�ո�
    for j in 1..n-i loop
      dbms_output.put(' ');
    end loop;
    --��ӡ*
    for j in 1..(2*i-1) loop
      dbms_output.put('*');
    end loop;
    --����
    dbms_output.new_line();
  end loop;
end;


                     *       �ո�
     *        1      1        5
    * *       2      3        4
   *   *      3      5        3
  *     *     4      7        2
 *       *    5      9        1
* * * * * *   6      11       0
                    2n-1     6-n


begin
  --��������
  for i in 1..6 loop
    --��ӡ�ո�
    for j in 1..6-i loop
      dbms_output.put(' ');
    end loop;
    --��ӡ*
    for j in 1..(2*i-1) loop
      --�����һ��
      if i=1 then
        dbms_output.put('*');
      elsif i=6 then
        --������ӡ*,ż����ӡ�ո�
        if mod(j,2)=1 then
          --�������һ��
          dbms_output.put('* ');
        end if;
      else
        --����������
        if j=1 or j=(2*i-1) then
          dbms_output.put('*');
        else
          dbms_output.put(' ');
        end if;
      end if;      
    end loop;
    --����
    dbms_output.new_line();
  end loop;
end;

declare
  n number:=&����;
begin
  --��������
  for i in 1..n loop
    --��ӡ�ո�
    for j in 1..n-i loop
      dbms_output.put(' ');
    end loop;
    --��ӡ*
    for j in 1..(2*i-1) loop
      --�����һ��
      if i=1 then
        dbms_output.put('*');
      elsif i=n then
        --������ӡ*,ż����ӡ�ո�
        if mod(j,2)=1 then
          --�������һ��
          dbms_output.put('* ');
        end if;
      else
        --����������
        if j=1 or j=(2*i-1) then
          dbms_output.put('*');
        else
          dbms_output.put(' ');
        end if;
      end if;      
    end loop;
    --����
    dbms_output.new_line();
  end loop;
end;

