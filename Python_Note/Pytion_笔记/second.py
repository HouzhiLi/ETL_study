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
c=input("请输入一个课程：")
if c in courses:
    print(c+"在课程列表",end=' ')
    print(courses,end='')
    print("中")

#else语句
'''
if 条件表达式:
    语句
else:
    语句

'''