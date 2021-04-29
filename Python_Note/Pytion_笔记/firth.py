"""
Python中包的导入
import 包名|函数名|类名 as 别名
frome 包名|类名 import 类名|方法名|函数 as 别名

包名：就是python文件（py文件）项目路径（相对路径）
"""
#直接使用import导入three.py文件里的所有内容
#import three as t
#print(t.fn3(5))

#使用from import方式导入一个函数
#from three import fn2
#print(fn2(5))

"""
日期类型，常用的有time,datatime,calendar
"""
#time包的基本使用
import time
#获取当前的时间戳
t1=time.time() #获取当前的时间戳
print(t1)
#time.localtime() 获取当前系统的本地时间戳,生成了一个时间元组
'''
tm_year:年
tm_mon:月
tm_mday:表示天
tm_hour:表示小时
tm_min:表示分钟
tm_sec:表示秒
tm_wday:表示星期
tm_yday:表示这一年的第几天
'''
t2=time.localtime()
print(t2)
print(t2.tm_year)

t3=time.localtime(0)
print(t3)
#字符串转换日期，日期转换成字符串
#time.strftime(格式字符串,时间元组) #将日期转换成字符串
#time.strptime(日期字符串，格式字符串) #将字符串转换成日期
"""
%Y:表示年
%m:表示月
%d:表示日
%H:表示小时
%M:表示分钟
%S:表示秒
"""
t4=time.strftime("%Y-%m-%d %H:%M:%S",time.localtime())
print(t4)

t5=time.strptime("2021/01/30 8:15:15",'%Y/%m/%d %H:%M:%S')
print(t5)

"""
import datetime
d1=datetime.datetime.now() #获取当前的日期
print(d1)
"""
'''
from datetime import datetime
d1=datetime.now() #获取当前日期
print(d1)
print("年：{}".format(d1.year))
print("月：{}".format(d1.month))
'''
import datetime
d1=datetime.datetime.now()
print(d1)
#d1.strptime()#将字符串转换成日期
#d1.strftime()#将日期转换成字符串
ds=d1.strftime("%Y-%m-%d %H:%M:%S")
print(ds)
print(type(ds))
d2=d1.strptime("1999-09-09","%Y-%m-%d")
print(d2)
print(type(d2))

#d1表示当前日期  d2表示1999-09-09
print("="*50)
print(type(d1))
print(d1)
print(type(d2))
print(d2)
d3=d1-d2
print(type(d3))
print(d3)

#定义一个变量保存日期的间隔  5天
det1=datetime.timedelta(days=5)
print(det1)

d4=datetime.datetime.now() - det1
print(d4)

d5=datetime.date.today() #获取当前的日期，不带时间的
print(d5)
print(type(d5))

