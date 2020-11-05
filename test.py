import pymysql
"""
commit 提交
rollback 回滚（取消增删改查）
"""

class DJ():
    def __init__(self):
        self.con = pymysql.connect(host="localhost", port=3306, user="root", password="k",database="jing_dong", charset="utf8")
        self.cursor = self.con.cursor()
        self.login_id=0

    def __del__(self):
        self.cursor.close()
        self.con.close()

    def showstart(self):
        print("*"*10)
        print("1.全部商品")
        print("2.商品分类")
        print("3.品牌分类")
        print("4.添加一个商品分类")
        print("5.根据名字查询商品")
        print("6.注册")
        print("7.登陆")
        print("8.下单")
        print("*"*10)
        return input("请输入您要查找序号:")

    def find_all(self):
        sql = "select * from goods;"
        self.print_find(sql)

    def find_cates(self):
        sql = "select name from goods_cates;"
        self.print_find(sql)

    def find_brands(self):
        sql = "select name from goods_brands;"
        self.print_find(sql)

    def insert_cate(self):
        name = input("请输入要添加的商品分类名字")
        sql = f"insert into goods_cates (name) values('{name}');"
        self.cursor.execute(sql)
        self.con.commit()

    def find_name(self):
        name = input("请输入要查找商品的名字")
        sql = f"select * from goods where name = '{name}';"
        self.print_find(sql)

    def print_find(self, sql):
        # len = self.cursor.execute(sql)
        # for i in self.cursor.fetchmany(len):
        #     print(i)
        self.cursor.execute(sql)
        for i in self.cursor.fetchall():
            print(i)

    def registered(self):
        name = input("请输入名称")
        address = input("请输入地址")
        tel = input("请输入电话号码")
        passwd = input("请输入密码")
        input_list = [name,address,tel,passwd]

        sql = """select * from customers where name=%s"""
        if self.cursor.execute(sql,input_list[0]):
            print("该名字已被注册")
        else:
            sql = """insert into customers values(0,%s,%s,%s,%s)"""
            self.cursor.execute(sql,input_list)
            self.con.commit()

    def login(self):
        name = input("请输入名称")
        passwd = input("请输入密码")
        input_list = [name,passwd]

        sql = """select * from customers where name=%s and passwd=%s;"""
        if self.cursor.execute(sql,input_list):
            print("登陆成功")
            for i in self.cursor.fetchall():
                print(i)
                self.login_id = i[0]
        else:
            print("登陆失败，请检查名称或密码输入是否正确")

    def place_order(self):
        if self.login_id:
            name = input("请输入名称")
            quantity = input("请输入购买数量")
            input_list = [name,quantity]
            sql ="""select * from goods where name=%s"""
            if self.cursor.execute(sql,input_list[0]):
                goods_id = self.cursor.fetchone()[0]
                sql = """insert into orders (customer_id) values(%s)"""
                self.cursor.execute(sql, self.login_id)
                order_id = self.con.insert_id()
                sql = """insert into order_detail (order_id, good_id, quantity) values(%s,%s,%s)"""
                insert_list = [order_id,goods_id,quantity]
                self.cursor.execute(sql, insert_list)
                self.con.commit()
                print("您已购买完成")
            else:
                print("请输入正确的名称")
        else:
            print("请先登录账号")
            self.login()

    def test(self):
        sql ="""insert into test (test) values(1)"""
        self.cursor.execute(sql)
        print("***")
        print(self.con.insert_id())
        self.con.commit()

    def run(self):
        while True:
            select = self.showstart()
            if select=="1":
                self.find_all()
            elif select=="2":
                self.find_cates()
            elif select=="3":
                self.find_brands()
            elif select=="4":
                self.insert_cate()
            elif select=="5":
                self.find_name()
            elif select=="6":
                self.registered()
            elif select=="7":
                self.login()
            elif select=="8":
                self.place_order()
            elif select=="9":
                self.test()
            else:
                print("输入有误，请重新输入")



def main():
    dj = DJ()
    dj.run()
 
if __name__ == "__main__":
    main()