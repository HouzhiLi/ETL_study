"""
  注释：
   单行注释：以#开头
   多行注释:以3个双引号或者3个单引号包起来的是多行注释
  python：是一个语法不是特别严格的编程语言,高级编程语句
       面向过程编程（python脚本,）
       面向对象编程

   python的功能比较强大，主要依赖外部导入包
     脚本
     网站（中小型）
     人工智能
     数据挖掘
"""
'''
   多行注释
'''
"""
python中变量的定义
变量名=值
=：赋值符号
变量的类型会根据赋值的数据来自己判断类型

数据类型：
  1.Number数字类型
  2.str字符串类型
  3.bool布尔类型
  4.list列表类型
  5.tuple元组类型
  6.set集合类型
  7.dict字典类型     
"""
#1.数字类型
'''
  数字类型
    int:表示整数类型
    float:表示浮点型（小数）
    double:表示双精度浮点型
    complex:复数类型  1+2i
'''
n1=5  #表示声名一个整数类型的变量
#type(对象名)函数：查看一个对象的类型
#print()：输出函数，打印
print(n1)
print(type(n1)) #打开n1变量的类型
n2=1.1  #表示声名一个浮点型变量
print(n2)
print(type(n2))
'''
  数学运算符
  +:加
  -：减
  *:乘
  /：除
  %：取余数
  +=：a+=b ==>   a=a+b
  -=：a-=b ==>   a=a-b
  /=：a/=b ==>   a=a/b
  *=：a*=b ==>   a=a*b
  **：幂运算符  例如：2**3 表示2的3次方
  //：取整
'''
n3=5/2  #除法运算
print(n3)
n4=5%3  #取余运算
print(n4)
n5=11//2  #表示取整
print(n5)
n6=3**3  #表示幂运算
print(n6)
a=10
b=3
a-=b  #a=a-b a=7
print(a)
#函数round()：四舍五入函数
n7=round(5.34)
print(n7)

#2.字符串类型str
'''
   在python中字符串可以使用'',也可以使用""
   it's a dog -->"it's a dog"
   it is a "book"-->'it is a "book"'
'''
s1="it's a dog"
s2='it is a "book"'
s3='it\'s a dog'
print(type(s1))
print(s1)
print(type(s2))
print(s2)
print(s3)
s4='HeLLo PyThOn'
print(s4)

#方法的调用:对象名.方法名(参数)
#在小写转换 使用lower()方法，可以将所有字符转换成小写
s5=s4.lower() #将s4的字符串转换成小写并赋值给变量s5
print(s5)
#大写转换 使用upper()方法
s6=s4.upper()
print(s6)
#把字符串转换为标题（单词首字母大写其他字母小写）
s7=s4.title()
print(s7)
#strip()方法去除字符串两边的空格
s8="    abcd    "
print(s8)
print(s8.strip())  #去掉字符串两边的空格
print(s8.rstrip()) #去掉字符串右边的空格
print(s8.lstrip()) #去年字符串左边的空格
s9="abaaab1234baababab"
#去年字符串中的字符，只剩数字
s10=s9.strip('ab') #表示去除字符串两边的a或者b
print(s10)
#len(对象)函数
s11="abcdefg"
print(len(s11))
#字符串的index(要查找的字符,开始位置，结束位置)方法：在字符串中查找字符所有的位置
n1=s11.index('c')  #表示查找c在字符串abcdefg中的下标
print(n1)
s1="hehhlkhhsd"
print(s1.index('h')) #取字符串第1个h的下标
print(s1.index('h',1)) #从下标是1的位置开始查找字符h第1次出现在字符串的下标
print(s1.index('h',5,9))
#字符串替换，replace(要替换的字符,新的字符,替换几个（默认是替换所有内容）)方法
print(s1.replace('h','x',2)) #将字符串所有的h替换为x
#字符串的切片
#字符串变量[开始位置:结束位置] ：位置指的是下标，包含开始位置，但不包含结束位置
s2="abcdefgh"
print(s2)
print(s2[0:3]) #表示截取字符串的前3个字符
print(s2[2:6]) #表示截取字符串的第3个字符到第6个字符
print(s2[:]) #相当于复制字符串
print(s2[-3:]) #表示截取字符串的后3个字符
print(s2[-3:-2]) #表示截取字符串的倒数第3个字符
#“abc,def,ghi”
ss="abc,def,ghi"
i1=ss.index(',') #取第1个逗号的位置
i2=ss.index(',',i1+1) #取第2个逗号的位置
print(ss[:i1])  #截取出abc
print(ss[i1+1:i2])  #截取中间的值
print(ss[i2+1:])  #截取最后一个值
#split('间隔符')方法，按照间隔符，把字符串进行分割
print(ss.split(','))
#字符串的拼接使用+号拼接
s1="Hello "
s2="World"
s3=s1+s2+"!"
print(s3)
#字符串可以使用*操作符
print("a"*10)  #表示打印10个a
print("a="*20) #表示打印20个"a="

#3.布尔类型bool，布尔类型的值有两个True和False
b1=True
print(type(b1))

#4.列表类型
'''
  列表类型 list
  它是一个有序的数据集合，由下标和值组成，数据可以重复
  [元素值,元素值,.....]
  列表的下标也是从0开始的
'''
c1=["Python",'Oracle',"linux","sql"]  #定义一个有4个元素的列表
print(type(c1))
#查看列表的长度使用len函数
print(len(c1))
#取列表中的元素 列表变量[下标]
print(c1[2]) #表示取列表中第3个元素
#pop([下标])方法来取列表中的元素：pop方法取列表元素时，
#取出后会删除列表中的该元素，默认是从列表的最后一个元素开始取值
#pop有返回值，返回值为取出的元素
print(c1) #打印原列表的所有元素
s=c1.pop() #将列表中最后一个元素取出放入变量s中，并删除最后一个元素
print(s)  #打印取出的值
print(c1) #打印取值后的列表 
s1=c1.pop(0) #取出列表的第1个元素放入变量s1中
print(s1) #打印列表的第一个元素
print(c1) #打印取值后的列表
#给列表中添加元素append(元素值)方法：给列表的最后面添加一个元素
c2=["Python",'Oracle',"linux","sql"]
print(c2)
c2.append("Python") #给列表的最后添加一个Pythonf元素
print(c2)
c2.append("Java")
print(c2)
#insert(下标,元素值)方法：表示在列表的指定位置插入一个元素
c2.insert(1,"Html")  #在列表的第2个位置添加一个Html元素
print(c2)
#extend()方法:扩展列表 ，可以使用一个迭代器来扩展列表元素
c3=['css','php']
print(c3)
print(c2)
c2.extend(c3) #表示将c3中的元素复制一份，添加到c2列表中
print(c2)
print(c3)
#修改列表元素 列表变量[下标]=值
c2[4]="PLsql"
print(c2)
#删除列表中的元素 del 列表变量[下标]
del c2[1]  #删除列表中第2个元素
print(c2)
#remove(元素值)方法：根据元素值删除列表中的元素，一次只删除一个
c2.remove("Python") #删除列表中的第1个Python
print(c2)

#range(开始值,结束值[,步长])函数：生成一个数字迭代器，包含开始值，但不包含结束值
c4=list(range(1,10)) #表示生成一个1~9的数字列表
print(c4)
c5=list(range(2,10,2)) #表示生成一个2，4，6，8的列表
print(c5)
c6=list(range(9,0,-1)) #表示生成9~1的数字列表
print(c6)
#列表的排序sorted()函数：临时排序
          #sort方法：永久排序
#定义一个列表 
c7=[3,12,6,234,4,1,22]  
print(c7) #打印数字列表
#使用sorted()方法对列表c7进行临时排序 返回一个新的列表
print(sorted(c7,reverse=True)) #打印排序后的列表
print(c7)
#使用sort()方法进行永久排序 没有返回值
c7.sort() #对c7进行永久排序
print(c7)
#返序传入reverse参数
c7.sort(reverse=True)
print(c7)
#列表的切片 列表的切片类似于字符串的切片
#列表变量[n1:n2]
c1=["python","java","oracle",'linux','html',"c++"]
print(c1)
print(c1[3:]) #表示截取列表中从第4个元素开始的所有元素
print(c1[-3:])#截取列表的后3个元素
print(c1[0:3])#表示截取列表的前3个元素
print(c1[:]) #复制列表相当于列表的copy()方法

#将列表c1赋值给列表c2
c2=c1  #列表的直接赋值，是将列表存储数据的地址进行赋值
print("c2=c1,c1列表的内容")
print(c1)
print("c2列表的内容：")
print(c2)
#给列表c2添加一个元素
c2.append('c#')
print("给c2列表添加一个元素后,打印c2列表 ")
print(c2)
print("打印c1列表")
print(c1)

print("="*100)
#使用copy()方法将c1进行复制
c3=c1.copy() #c3=c1[:]
print("c3=c1.copy()后，打印c3")
print(c3)
print("打印c1")
print(c1)
print('--'*50)
#比例c3列表添加一个元素
c3.append('css')
print("给c3添加一个元素后，打印c3")
print(c3)
print("打印c1")
print(c1)


#5.元组
'''
   元组tuple
   元组是一个不可修改的列表（有序的，值可以重复的，但是不能增删改元组中的元素）
   (元素值,元素值,....)
'''
t1=('hello','good','nice','aas')
print(t1)
print(type(t1))
#将元组转换成列表
c1=list(t1)  #将元组转换成列表
print(c1)
#将一个列表转换成元组
c2=["python",'java','php']
print(c2)
t2=tuple(c2) #将列表转换成元组
print(t2)
#取值根据下标取值
print(t2[1])#取元组中的第2个元素
#切片
print(t2[-2:]) #截取元组的后两个元素
#生成一个数字元组
t3=tuple(range(1,10))
print(t3)

print('*'*100)
print('*'*100)
print('*'*100)
#6集合类型set
'''
  集合类型set
  集合：没有下标，元素不可重复，没有顺序
  {元素值,元素值,....}
'''
s1={"python",'java','html','php','python'}  #集合中的元素不可重复
print(s1)
print(type(s1))
#添加元素add(元素值)方法
s1.add('c++')  #给s1中添加一个c++
print(s1)
#删除集合中的元素remove("元素值")方法
s1.remove('java')
print(s1)
#将一个列表中的元素去重
c1=["python",'java','php','java','javascript','php','python']
print(c1)
s2=set(c1)  #将列表转换成集合，会自动去重
print(s2)
#将集合转换成列表 
c2=list(s2) #将集合转换为列表 
print(c2)



print('*'*100)
print('*'*100)
print('*'*100)
s1={"python",'oracle','plsql','java'}
s2={"python",'oracle','php','html'}
print("打印集合s1")
print(s1)
print("打印集合s2")
print(s2)
#集合的并集union()
print("s1和s2的并集")
ss=s1.union(s2) #取两个集合的并集
print(ss)
#交集intersection()
print("s1和s2的交集")
ss=s1.intersection(s2)
print(ss)
#差集difference()
print("s1-s2差集")
ss=s1.difference(s2)
print(ss)
print("s2-s1差集")
ss=s2.difference(s1);
print(ss)
#集合的pop()方法,集合的pop方法是没有参数的，取出集合中的一个元素值，并将其从集合中删除
s=ss.pop() #取出集合ss中的一个元素
print(s)
print(ss)


#7.字典类型
'''
  字典类型dict
  字典类型：是以键值对的方式存储数据，一个键对应一个值，其中键不可以重复，值是可以重复
  {"键":值,"键":值,....}
'''
d1={"name":'张三','age':18,'sex':'男'}
print(d1)
print(type(d1))
#字典的取值 变量[键]
print (d1['name']) #表示取字典中name的值
print(d1['sex'])
print(d1['age'])
#使用get(键)方法获取字符中的值
print("="*100)
print(d1.get('name')) #取字典中name的值
print(d1.get('age'))
print("*"*100)
#修改或者给字典中添加数据
d1['age']=20  #修改字典中age的值
print(d1)
d1['addr']="shandong" #给字典中添加一个addr
print(d1)
#字典的keys()方法:获取到字典中所有键 用来遍历字典用的
keys=d1.keys() #获取字典中所有键
print("-"*100)
print(keys)
#字典的values()方法：获取字典中所有的值 
values=d1.values() #获取所有的值
print(values)
#字典的items()方法：获取字典中的所有个元素（键值对）
items=d1.items() #获取字典中所有的元素
print(items)

#字典的popitem()方法：表示从字典中取出一个元素，并将其从字典中删除
print('-'*100)
item=d1.popitem()
print(item)
print(d1)
#字典的pop(键)方法：表示根据根据键从字典中取一个元素，并将其从字典中删除
item=d1.pop('age')
print(item)
print(d1)

"""
  复杂的数据类型
  列表list
  元组tuple
  集合set
  字典dict
  以上几种数据类型，是可以互相嵌套的
  [{"name":"tom","age":18},{"name":"alen","age":29},...]
  {
     "id":1234,
     "name":"张三",
     "age":18,
     "corse":["数学","语文","英语","计算机"]
  }

  json数据
"""