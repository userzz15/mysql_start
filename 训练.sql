create database jing_dong charset=utf8;

use jing_dong;

create table goods(
    id int unsigned primary key not null auto_increment,
    name varchar(150) not null,
    cate_name varchar(40) not null, -- 分类名
    brand_name varchar(40) not null,    -- 品牌名
    price decimal(10,3) not null default 0,
    is_show bit not null default 1,
    is_saleoff bit not null default 0   -- 是否卖光
);

select name, price from goods where cate_name="超级本";

select cate_name from goods group by cate_name;

select round(avg(price),2) from goods;

select cate_name,avg(price) from goods group by cate_name;

select * from goods where price>(select round(avg(price),2) from goods) order by price desc;

select * from goods inner join (select cate_name, max(price) as price_t from goods group by cate_name) as t on goods.price=t.price_t and goods.cate_name=t.cate_name;
select max(price) from goods group by cate_name;

insert into goods values(0,'r510vc 15.6英寸笔记本','笔记本','华硕','3399',default,default); 
insert into goods values(0,'y400n 14.0英寸笔记本电脑','笔记本','联想','4999',default,default);
insert into goods values(0,'g150th 15.6英寸游戏本','游戏本','雷神','8499',default,default); 
insert into goods values(0,'x550cc 15.6英寸笔记本','笔记本','华硕','2799',default,default); 
insert into goods values(0,'x240 超极本','超级本','联想','4880',default,default); 
insert into goods values(0,'u330p 13.3英寸超极本','超级本','联想','4299',default,default); 
insert into goods values(0,'svp13226scb 触控超极本','超级本','索尼','7999',default,default); 
insert into goods values(0,'ipad mini 7.9英寸平板电脑','平板电脑','苹果','1998',default,default);
insert into goods values(0,'ipad air 9.7英寸平板电脑','平板电脑','苹果','3388',default,default); 
insert into goods values(0,'ipad mini 配备 retina 显示屏','平板电脑','苹果','2788',default,default); 
insert into goods values(0,'ideacentre c340 20英寸一体电脑 ','台式机','联想','3499',default,default); 
insert into goods values(0,'vostro 3800-r1206 台式电脑','台式机','戴尔','2899',default,default); 
insert into goods values(0,'imac me086ch/a 21.5英寸一体电脑','台式机','苹果','9188',default,default); 
insert into goods values(0,'at7-7414lp 台式电脑 linux ）','台式机','宏碁','3699',default,default); 
insert into goods values(0,'z220sff f4f06pa工作站','服务器/工作站','惠普','4288',default,default); 
insert into goods values(0,'poweredge ii服务器','服务器/工作站','戴尔','5388',default,default); 
insert into goods values(0,'mac pro专业级台式电脑','服务器/工作站','苹果','28888',default,default); 
insert into goods values(0,'hmz-t3w 头戴显示设备','笔记本配件','索尼','6999',default,default); 
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default); 
insert into goods values(0,'x3250 m4机架式服务器','服务器/工作站','ibm','6888',default,default); 
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default);

create table if not exists goods_cates(
    id int unsigned primary key auto_increment,
    name varchar(40) not null
);

insert into goods_cates (name) (select cate_name from goods group by cate_name);

update goods inner join goods_cates on goods.cate_name=goods_cates.name set cate_name=goods_cates.id;

create table if not exists goods_brands(
    id int unsigned primary key not null auto_increment,
    name varchar(40) not null
);

insert into goods_brands(name) (select brand_name from goods group by brand_name);

update goods inner join goods_brands on goods.brand_name=goods_brands.name set goods.brand_name=goods_brands.id;

insert into goods_cates(name) values ('路由器'),('交换机'),('网卡');
insert into goods (name,cate_name,brand_name,price) values('LaserJet Pro P1606dn 黑白激光打印机', 12, 4,'1849');

alter table goods change cate_name cate_id int unsigned not null,change brand_name brand_id int unsigned not null;

alter table goods add foreign key (cate_id) references goods_cates(id); -- 添加外键约束
alter table goods add foreign key (brand_id) references goods_brands(id);

alter table goods drop foreign key goods_ibfk_1;    --删除外键约束

-- 订单表
create table orders(
    id int unsigned primary key not null auto_increment,
    order_date_time datetime not null default current_timestamp,
    customer_id int unsigned not null
);

-- 顾客表
create table customers(
    id int unsigned primary key not null auto_increment,
    name varchar(40) not null,
    address varchar(100) not null,
    tel tinyint unsigned not null,
    passwd varchar(40) not null
);

-- 订单详情表
create table order_detail(
    id int unsigned primary key not null auto_increment,
    order_id int unsigned not null,
    good_id int unsigned not null,
    quantity int unsigned not null
);

create table test(
    id int unsigned primary key not null auto_increment,
    test int unsigned not null
);

set profiling=1;    --开启计时
select * from test_index where title='ha-99999';

create index title_index on test_index(title(10));

select * from test_index where title='ha-99999';
show profiles;