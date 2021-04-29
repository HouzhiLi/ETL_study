""""
python的数据库连接
   cx_Oracle:oracle驱动包
   (1)通过IDE工具安装，在项目的配置中
  （2）使用pip命令去安装
      在线安装：
             pip install cx_Oracle  #安装python中的oracle驱动包

             py -m pip install cx_Oracle 或者python -m pip install cx_Oracle
             py -3 -m pip install cx_Oracle

             安装时会提示pip命令版本过低，让你升级pip命令： pip install pip --upgrade

             镜像地址访问不到问题：
               （1）在当前系统用户的目录（C:\\Users\\Administrator\\）下创建一个名字叫pip的文件夹
               （2）在pip文件夹下创建一个pip.ini的配置文件（.ini格式的文件不能直接创建，需要先创建一个txt文件，通过修改后缀的方式转换成.ini文件）
               （3）在pip.ini 文件中添加如下配置
                 [global]
                 index-url=https://pypi.tuna.tsinghua.edu.cn/simple
           在pycharm这个IDE工具上通过命令给虚拟环境安装外部包：
            (1)打开terminal窗口
           （2）cd到虚拟环境的Scripts目录
               cd venv/Scripts
           （3）通过pip命令安装cx_Oracle包
                pip install cx_Oracle

      离线安装：需要在网上下标安装文件.whl文件
cx_Oracle包的使用
（1）获取数据库连接
 conn=cx_Oracle.connect("数据库用户名/密码@ip地址:端口号/数据库实例名")
 conn=cx_Oracle.connect("用户名","密码","ip地址:端口号/数据库实例名")
（2）根据数据库连接，获取游标
 cur=conn.cursor()   
（3）使用游标执行sql语句
 cur.execute(sql语句)
 (4) 获取执行结果
 cur.fetchone() #取一条结果
 cur.fetchall() #取所有的结果
 cur.fetchmany(n) #取n条结果
 (5)关闭游标和连接
"""
import cx_Oracle
#定义一个函数，查询员工表的人数 （select count(1) from emp）
def db1():
    #获取连接
    conn=cx_Oracle.connect("scott/scott@127.0.0.1:1521/orcl")
    #获取游标
    cur=conn.cursor()
    #用游标执行sql语句
    cur.execute("select count(1) from emp")
    #取出sql语句的执行结果
    count=cur.fetchone()
    print(count[0])
    #关闭游标
    cur.close()
    #关闭连接
    conn.close()
#db1()

#写一个函数，传入部门编号，根据部门编号查询部门下的员工信息
def db2(dno):
    #获取数据库连接
    conn=cx_Oracle.connect("scott","scott","127.0.0.1:1521/orcl")
    #获取游标
    cur=conn.cursor()
    #执行sql语句
    cur.execute("select * from emp where deptno={}".format(dno))
    #获取执行结果
    #datas=cur.fetchall()
    datas=cur.fetchmany(2)  #获取两条执行结果
    #关闭游标
    cur.close()
    #关闭连接
    conn.close()

    #打印查询结果
    print(datas)
    for data in datas:
        print(data)
        print("员工编号：{}，员工姓名：{}，员工职位：{}，员工工资：{}".format(data[0],data[1],data[2],data[5]))

db2(10)