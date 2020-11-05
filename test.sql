-- 有3个表S(学生表)，C（课程表），SC（学生选课表）
-- S（SNO，SNAME）代表（学号，姓名）
-- C（CNO，CNAME，CTEACHER）代表（课号，课名，教师）
-- SC（SNO，CNO，SCGRADE）代表（学号，课号，成绩）
-- 问题：
-- 1，找出没选过“黎明”老师的所有学生姓名。
-- 2，列出2门以上（含2门）不及格学生姓名及平均成绩。
-- 3，即学过1号课程又学过2号课所有学生的姓名。
-- 请用标准SQL语言写出答案，方言也行（请说明是使用什么方言）。

-- 1.
select sname from s where sno not in (select s.sno from sc inner join c on sc.cno=c.cno left join s on sc.sno=s.sno where c.cteacher="黎明");

-- 2.
select sno, group_concat(scgrade) from sc group by sno;


CREATE TABLE SC
(
  SNO      VARCHAR(200),    -- 学号
  CNO      VARCHAR(200),
  SCGRADE  VARCHAR(200)
);

CREATE TABLE S
(
  SNO    VARCHAR(200 ),
  SNAME  VARCHAR(200)
);

CREATE TABLE C
(
  CNO       VARCHAR(200),   --课号
  CNAME     VARCHAR(200),
  CTEACHER  VARCHAR(200)
);

INSERT INTO C ( CNO, CNAME, CTEACHER ) VALUES ( '1', '语文', '张'); 
INSERT INTO C ( CNO, CNAME, CTEACHER ) VALUES ( '2', '政治', '王'); 
INSERT INTO C ( CNO, CNAME, CTEACHER ) VALUES ( '3', '英语', '李'); 
INSERT INTO C ( CNO, CNAME, CTEACHER ) VALUES ( '4', '数学', '赵'); 
INSERT INTO C ( CNO, CNAME, CTEACHER ) VALUES ( '5', '物理', '黎明'); 
commit;

INSERT INTO S ( SNO, SNAME ) VALUES ( '1', '学生1'); 
INSERT INTO S ( SNO, SNAME ) VALUES ( '2', '学生2'); 
INSERT INTO S ( SNO, SNAME ) VALUES ( '3', '学生3'); 
INSERT INTO S ( SNO, SNAME ) VALUES ( '4', '学生4'); 
commit;

INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '1', '1', '40');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '1', '2', '30');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '1', '3', '20');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '1', '4', '80');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '1', '5', '60');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '2', '1', '60');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '2', '2', '60');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '2', '3', '60');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '2', '4', '60');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '2', '5', '40');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '3', '1', '60');
INSERT INTO SC ( SNO, CNO, SCGRADE ) VALUES ( '3', '3', '80');