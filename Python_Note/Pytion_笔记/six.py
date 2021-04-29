"""
    python中的异常处理：
    try:
       可能会出现异常的代码
    except 异常名称 as 异常变量:
         异常处理代码
    else:
       没有发生异常时执行的代码
    finally:
       永远会被执行的代码
"""
import cx_Oracle
#异常
def fn1(a):
    print(a/2)

#fn1("a")
def fe1():
    try:
        fn1("a") #可能出现异常的代码
    except TypeError as e:
        print(e)

def fe2():
    try:
        fn1("x")
    except TypeError as e:
        print("fn1调用发生了异常")
    else:
        print("未发生异常时执行的代码")
    finally:
        print("不管发不发生异常都会执行的代码")
#fe2()

#给连接数据库的代码添加异常处理
def db1():
    conn=None    #None是空的意思
    cur=None
    try:
        #打开连接
        conn=cx_Oracle.connect("scott/scott@127.0.0.1:1521/orcl")
        #打开游标
        cur=conn.cursor()
        #执行sql语句
        cur.execute('select ename from emp')
        #处理查询结果
        datas=cur.fetchall() #取所有的查询结果
        for data in datas:
            print(data)
    except Exception as e:
        print(e)
    finally:
        #将资源的关闭放在finally中
        #关闭游标
        cur.close()
        #关闭连接
        conn.close()
        print("资源已关闭")

#db1()

#给连接数据库的代码添加异常处理
def db2():
    conn=None    #None是空的意思
    cur=None
    try:
        #打开连接
        conn=cx_Oracle.connect("scott/scott@127.0.1.1:1521/orcl")
        #打开游标
        cur=conn.cursor()
        #执行sql语句
        cur.execute('select ename from emp')
        #处理查询结果
        datas=cur.fetchall() #取所有的查询结果
        for data in datas:
            print(data)
    except Exception as e:  #Exception可以捕获到所有的异常
        print(e)
    finally:
        #将资源的关闭放在finally中
        try:
            if cur != None:
                #关闭游标
                cur.close()
            if conn !=None:
                #关闭连接
                conn.close()
        except Exception as e:
            print("关闭资源时发生了异常")
            print(e)
        print("资源已关闭")
db2()

