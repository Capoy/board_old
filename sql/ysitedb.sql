create table member (
user_no number(10) PRIMARY KEY , 
id varchar2(20) ,
password varchar2(20) ,
email varchar2(200)
);

create table board (
board_no number(10) PRIMARY KEY ,
title varchar2(200) ,
content varchar2(4000) ,
reg_date date ,
hit number(6) ,
group_no number(6) ,
order_no number(6) ,
depth number(6) ,
user_no number(10) ,
foreign key(user_no) REFERENCES member(user_no)
);

create table comments (
comments_no number(10) PRIMARY KEY ,
content varchar2(2000) ,
reg_date date ,
user_no number(10) ,
board_no number(10) ,
foreign key(user_no) REFERENCES member(user_no),
foreign key(board_no) REFERENCES board(board_no)
);

create table gallery (
gallery_no number(10) PRIMARY KEY ,
content varchar2(2000) ,
reg_date date ,
user_no number(10) ,
orgfilename varchar2(100),
savefilename varchar2(100),
fileextname varchar2(100),
filesize number(20) ,
foreign key(user_no) REFERENCES member(user_no)
);

create table gal_comments (
comments_no number(10) PRIMARY KEY ,
content varchar2(2000) ,
reg_date date ,
user_no number(10) ,
gallery_no number(10) ,
foreign key(user_no) REFERENCES member(user_no),
foreign key(gallery_no) REFERENCES gallery(gallery_no)
);

create sequence board_seq;
create sequence member_seq;
create sequence comments_seq;
create sequence gallery_seq;
create sequence gal_comments_seq;

