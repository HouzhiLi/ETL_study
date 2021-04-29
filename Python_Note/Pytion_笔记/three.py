"""
  python中的自定义函数
  语法
  def 函数名(参数[:类型]，参数,...):
       函数体内容
       [return 返回值]
  函数可以有返回值，也可以没有返回值，有返回值时，在调用时，也可以不使用返回值
  函数的调用：
  函数名(参数,...);
"""
#定义一个简单的函数
def fn1():
    print("Hello Python!")
#调用函数
#fn1()

#写一个函数计算一个数的阶乘
def fn2(n):
    res=1
    for i in range(1,n+1):
        res=res*i # res*=i
    return res

#调用函数，计算5的阶乘
#print(fn2(5))
#a=fn2(4)
#print(a)

#函数的递归调用
def fn3(n):
    if n<=2:
        return n
    else:
        return n*fn3(n-1)
#print(fn3(5))

"""
Python中函数的参数
1.普通参数
2.*args 元组参数 ,参数长度不限制，一般情况下在函数中是根据元组下标来获取参数
3.**args 字典参数
"""
def fn4(*args):
    print(args)
#fn4(3,1234,"haha","hehe",["s","c"])

#自定义一个字符串截取函数
#当传入两个参数时，将字符串从开始位置截取到最后，当传入3个参数时，将字符串从start的位置截取到第3个参数的位置
def substr(s:str,start:int,*args):
    if len(args) < 1:
        return s[start:]  #将字符串进行切片
    else:
        print(args)
        print(args[0])
        return s[start:args[0]]

s1="abcdefghi"
#r=substr(s1,2)  #从第3个字符截取到最后
#print(r)

#r1=substr(s1,2,6) #从第3个字符截取到第6个字符 s[2:6]
#print(r1)

#r2=substr(s1,2,5,12,"1234")
#print(r2)

#cut -f 1 -d '.'
"""
def cut(*args):
   for i in range(0,len(args),2):
       print(args[i])
       print(args[i+1])
       if args[i] == "-f":
           print("取第"+str(args[i+1])+"列")
       elif args[i] == "-d":
           print("列分隔符是："+str(args[i+1]))
cut("-f",1,"-d",".")
"""
#写一个函数来完成一个类似 linux上的cut命令的功能
"""
   传入一个字符串s
   传入不定参数 *args
      -f 表示配置参数，指取第几列
      -f后面的数字，表示n列
      -d 配置参数，指定列分隔符
      -d后面的是列分隔符
   (1)找列分隔符，如果参数中包含 -d，那么将字符串按照分隔符进行分割
                  如果不包含 -d ,那么将字符串按照","进行分割
   (2)根据-f配置，取出第n列内容
"""
s="abc,edf,ghi"
def cut(s:str,*args):
    #声名一个变量保存分隔符
    separator=","
    #声名一个变量保存列号
    n=1
    #在参数中查找-d配置将字符串进行分割
    if "-d" in args:
        #如果传入的参数中带有-d配置，找到分隔符
        for i in range(0,len(args),2):
            if args[i] == "-d":
                #如果第i个参数是-d，那么i+1的位置就是分隔符
                separator=args[i+1]
                break  #break退出循环
    #按照分隔符将字符串进行分隔
    datas=s.split(separator)  #将分割后的数据保存到变量datas中
    print(datas)

    #在不定参数中找到-f配置，获取列号n
    if "-f" in args:
        #遍历args查找列号
        for i in range(0,len(args),2):
            if args[i] == "-f":
                #如果第i个参数值是-f，那么第i+1个参数为列号
                n=int(args[i+1])
                break
    # 由于列表的下标是以0开始的，那么第n列的下标为n-1
    data=datas[n-1]
    print(data)
#print(s)
#cut(s)

#break语句退出循环
#continue退出本次循环
#return结束程序

"""
字典类型参数
  **kwargs
  key word arguemnts
"""
#定义一个函数
def fn5(**kwargs):
    print(kwargs)
    for key,value in kwargs.items():
        print("{}-->{}".format(key,value))


#fn5(abc="efg",name="张三",age=18,sex="男")
#print("aa",end="s")

'''
 cut2(字符串,-d=",",-f=1)
'''
def cut2(s,**kwargs):
    #声名变量保存分隔
    separator=","
    #声名一个变量保存列号
    col=1
    #判断是否传入了-d配置
    if "d" in kwargs.keys():
        separator=kwargs.get("d")
    #判断是否传入-f配置
    if "f" in kwargs.keys():
        col=int(kwargs.get("f"))
    #将字符串按照分隔符分割成列表
    datas=s.split(separator);
    print(datas)
    print(kwargs)
    print(datas[col-1])
#s="abc,edf,ghi"
#cut2(s,d=",",f=3)
#cut2(s)
#cut2(s,f=3)