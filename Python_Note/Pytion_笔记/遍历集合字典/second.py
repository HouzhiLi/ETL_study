"""
  python中的语句 
  输入输出语句
    1.输入语句(在学习期间使用到)
    2.格式化输出(print语句)

  python中语句的表示：
     python中没有语句结束符，和代码块符号，都是以空格或才换行来表代码块结构的
  流程控制语句
   1.if语句
   2.else语句
   3.if else if语句
   4.while 循环
   5.for 循环
"""
#输入语句input(提示信息)函数:接收一个从键盘输入的值，并将基保存到变量中
#input函数默认的返回值是一个字符串，如果需要其他类型的数据时，需要手动转换
#a=input("请输入一个值")
#print(a)
#x=int(input("请输入一个整数："))
#print(type(x))
#print(x*4)

#格式化输出语句
'''
   格式字符串
   1.格式字符%
    占位符
    %s：表示一个字符串  %3s 表示显示3个字符的长度
    %d:表示数字        %5d表示显示5个字母的长度
    %f:表示小数        %5.2f表示显示长度为5，包含两位小数
    '格式字符串'%(值,值,值)
    '%s*%s=%s'%(2,3,6)='2*3=6'
    '%d*%d=%d'%(4,5,20)='4*5=20'

    2.format
     占位符
     {:n} :n是一个长度
     '{}*{}={}'.format(3,6,18)='3*6=18'
'''
s1="%s*%s=%s"%(2,3,6)
print(s1)
s2="%3.2f*%3.2f=%5.3f"%(3,4,12)
print(s2)

s3="%s,你好"%'Smith'
print(s3)

#format是python3新出的格式化字符串方式
s4="{}*{}={:2}".format(2,3,6)
print(s4)

print('Hello World') #打印内容并换行
print('Hello','world','smith','tom') #使用print打印多个值
print("hello "+"world"+" alent"+' ss') #打印一个字符串
print("Hello",end="")  #表示打印不换行
print("World",end='') 
print("hello",end="@")
print("hello",end="#")
print("world")

print("姓名：%s,年龄:%s"%('张三',18))

#if语句
'''
 if 条件表达式:
    python语句

条件表达式：
   >,<,>=,<=,==,!=
   
   in条件 not int
   变量 in 列表|元组|集合等  用来判断列表，元组集合中是否包含某一个值
'''
courses=['oracle','sql','plsql','linux']
#输入一个课程判断是否包含在courses列表中
'''
c=input("请输入一个课程：")
if c in courses:
    print(c+"在课程列表",end=' ')
    print(courses,end='')
    print("中")
'''
#else语句
'''
if 条件表达式:
    语句
else:
    语句

'''
#输入两个数据，输出两个数据相除的结果，如果除数为0，输出，除数不能为零
'''
m=int(input("请输入被除数："))
n=int(input("请输入除数："))
if n == 0:
    print("除数不能为零")
else:
    print("{}/{}={}".format(m,n,m/n))
    print("%d/%d=%3.2f"%(m,n,m/n))
    print(str(m)+"/"+str(n)+"="+str(m/n))
'''
#3.if else if语句
"""
if 条件表达式:
    语句
elif 条件表达式:
    说句
elif 条件表达式:
    语句
...
else:
    语句
"""
#输入一个成绩，如果60分以下，输出不及格，60~70，输出及格，70~80，输出良好，80以上输出优秀
'''
score=float(input("请输入成绩："))
if score < 60:
    print("不及格")
elif score < 70:
    print("及格")
elif score < 80:
    print("良好")
else:
    print("优秀")
'''
#4.while循环
'''
while 循环条件:
    循环体语句
    循环控制语句

'''
#打印1~9
n=1
while n<=9:
    #循环体语句
    print(n)
    #循环控制语句
    n+=1  #n=n+1

#5.for循环语句
print("="*50)
"""
for 循环变量 in 集合|列表|元组|字典等:
    循环体语句
"""
for n in range(1,10):
    print(n)

for n in range(9,0,-1):
    print(n)

c=["python","java","html","css","oracle"]
print("*"*50)
print(c)
print("="*50)
#使用for循环遍历列表
for v in c:
    print(v)
print("-"*50)
#使用下标来遍历列表
for n in range(0,len(c)):
    print(str(n)+"-->"+c[n])
#按下标反序遍历列表
print("*"*50)
for n in range(len(c)-1,-1,-1):
    print(str(n)+"-->"+c[n])

s=set(c) #将列表c转换成集合set
print(type(s))
print(s)
#使用for循环遍历集合
for v in s:
    print(v)

#使用for循环遍历字典
d={"name":"张三","age":"18","sex":"男"}
print(d)
#遍历字典的键
print("%s\n%s"%("="*50,"遍历字典的键：")) #print("="*50) print("遍历字典的键：")
for key in d.keys():
    print("key="+key)
    #print("根据key取值："+d.get(key)) #print("根据key取值："+d[key])
    print("根据key取值：" + d[key])

#遍历字典的值
print("="*50)
print("遍历字典的值：")
for value in d.values():
    print(value)

#遍历字典的键值对
for key,value in d.items():
    print(key+"-->"+value)

"""
 利用循环来读写文件
 1.打开文件
 文件变量=open("文件路径",读写方式) 
 读写方式：r表示读
           w表示写
           a表示追加
 2.读或者写文件
 文件变量.readline()#读取文件的一行内容注意包括换行符
 文件变量.readlines()#读取文件的所有行，也包括换行符
 文件变量.write(要写入的内容) #写入文件内容 
 3.关闭文件
 文件变量.close()
 
 #新的语法：（不需要手动关闭文件，自动关闭文件）
 with open(文件路径，读写方式) as 文件变量:
      读或者
"""
#文件的写入
'''
#打开文件
f=open("1.txt",'w')
#写入内容
f.write("python\n")
f.write("java")
#关闭文件
f.close()
'''

c=["python","java","html","css","oracle"]
#追加文件
'''
f=open("1.txt",'a')
#写入内容
for v in c:
    f.write(v+"\n")

#关闭文件
f.close()
'''
print("="*50)
#读取文件
#打开文件
f=open("1.txt",'r')
#读文件
data=f.readline()#将文件的一行计入data
print(data) #打印data中的数据
#关闭文件
f.close()

#使用with语法来读取文件的所有内容
with open("1.txt","r") as f:
    #读取文件的所有行
    datas=f.readlines();
    #打印datas中的数据
    #print(datas)
    for data in datas:
        #print(data)
        #去掉多余的换行
        #print(data,end="")
        #print(data.replace("\n",''))
        print(data.strip("\n"))