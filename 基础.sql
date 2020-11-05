--数据库操作
    -- 连接数据库
    mysql -uroot -p
    mysql -uroot -ppassword
    -- 退出数据库
    quit/exit/ctrl+d

    -- sql语句最后需要分号;结尾
    -- 显示数据库版本
    select version();

    -- 显示时间
    select now();

    -- 查看所有数据库
    show databases;
    
    -- 创建数据库
    -- create database 数据库名 charset=utf8;
    create database python04;
    create database python05 charset=utf8;
    
    -- 查看创建数据库的语句
    -- show create database ....
    show create database python04;
    
    -- 查看当前使用的数据
    select database();
    
    -- 使用数据库
    -- use 数据库的名字
    use python05;

    -- 删除数据库
    -- drop database 数据库名;
    drop database python04;

-- 数据表的操作
    -- 常看当前数据库中的所有表
    show tables;
    -- 创建表
    -- auto_increment 表示自动增长
    -- not null 表示不能为空
    -- primary key 表示主键
    -- default 默认值
    -- create table 数据表名字(字段 类型 约束[,字段 类型 约束]);
    create table xxxx(id int, name varchar(30));
    create table yyyy(id int primary key not null auto_increment, name varchar(30));
    create table zzzz(
        id int primary key not null auto_increment,
        name varchar(30)
    );
    -- 创建students表(id name age high gender cls_id)
    create table students(
        id int unsigned auto_increment not null primary key,
        name varchar(30),
        age tinyint unsigned,
        high decimal(5, 2),
        gender enum("男","女","中性","保密") default "保密",
        cls_id int unsigned
    );

    insert into students values(0,"老王",18,188.88,"男",0);
    select * from students;

    -- 创建classes表(id,name)
    create table classes(
        id int unsigned not null primary key auto_increment,
        name varchar(30)
    );

    -- 查看表的创建语句
    -- show create table 表名字;
    show create table students;

    -- 查看表结构
    -- desc 数据表的名字;
    desc xxxx;

    -- 修改表-添加字段
    -- alter table 表名 add 列名 类型;
    alter table students add birthday datetime;

    -- 修改表-修改字段：不重命名版
    -- alter table 表名 modify 列名 类型及约束
    alter table students modify birthday date;

    -- 修改表-修改字段:重命名版
    -- alter table 表名 change 原名 新名 类型及约束
    alter table students change birthday birth date;

    -- 修改表-删除字段
    -- alter table 表名 drop 列名;
    alter table students drop high;

    -- 删除表
    -- drop table 表名;
    drop table xxxx;

-- 增删改查(curd)

    -- 增加
    -- insert [into] 表名 values();
    -- 主键字段可以用0 null default 来占位
    -- 向classes表中插入一个班级
    insert into classes values(0,"python菜鸟班");

    +--------+-------------------------------+------+-----+------------+----------------+
    | Field  | Type                          | Null | Key | Default    | Extra          |
    +--------+-------------------------------+------+-----+------------+----------------+
    | id     | int unsigned                  | NO   | PRI | NULL       | auto_increment |
    | name   | varchar(30)                   | YES  |     | NULL       |                |
    | age    | tinyint unsigned              | YES  |     | NULL       |                |
    | gender | enum('男','女','中性','保密') | YES  |     | 保密       |                |
    | cls_id | int unsigned                  | YES  |     | NULL       |                |
    | birth  | date                          | YES  |     | 1990-01-01 |                |
    +--------+-------------------------------+------+-----+------------+----------------+

    -- 向students表插入一个学生信息
    insert into students values(0,"小李",20,"女",1,"1990-01-01");

    -- 枚举中1代表"男"，2代表"女"...

    -- 部分插入
    -- insert into 表名(列1,...) values(值1,...);
    insert into students (name, gender) values("小乔",2);

    -- 多行插入
    insert into students (name, gender) values("大乔",2),("貂蝉",2);
    insert into students values(0,"西施",20,"女",2,"1990-01-01"),(0,"王昭君",20,"女",2,"1990-01-01");

    -- 修改
    --update 表名 set 列1=值1, 列2=值2 ... where 条件;
    update students set age=18 where id=3;

    -- 删除
    -- 物理删除
    -- delete from 表名 where 条件
    delete from students; --删除全部
    delete from students where id=2;

    -- 逻辑删除
    -- 用一个字段来表示 这条信息是否已经不能再使用了
    -- 给students表添加一个is_delete字段bit类型
    -- alter table students add is_delete bit default 0;
    -- update students set is_delete=1 where id=6;

    -- 查询基本使用
    -- 查询所有列
    -- select * from 表名;
    select * from students;
    
    -- 指定条件查询
    select * from students where name="小李";
    select * from students where id>3;

    -- 查询指定列
    -- select 列1,列2... from 表名;
    select name,age,gender from students where id>3;

    -- 字段的顺序
    select age as 年龄,name as 姓名,gender as 性别 from students where id>3;

    -- 可以使用as为列或表指定别名
    -- select 字段[as 别名], 字段[as 别名] from 数据表 where...;
    select name as 姓名,age as 年龄,gender as 性别 from students where id>3;