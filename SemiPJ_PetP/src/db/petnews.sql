-- 펫뉴스
--	게시물번호, title, url, summary, content(태그채로 범위정해서 html에 표현?), 게시썸네일, 날짜시간
		
--		dto: no, title, url, summary content, img, date

drop table petnews;
drop sequence petnewsnosq;
create sequence petnewsnosq;
create table petnews(
			   newsNo number primary key,
			   nTitle varchar2(200) not null,
			   nUrl varchar2(500),
			   nSummary varchar2(500),
			   nContent clob,
			   nImg   varchar2(500),
			   nDate   date
);

drop table newscomment;
drop table member;
delete from petnews;

drop sequence newscommentnosq;
drop sequence newscommentgroupsq;
drop sequence newscommentgroupnosq;

create sequence newscommentnosq
NOCACHE;

create sequence newscommentgroupnosq
NOCACHE;

create sequence newscommentgroupsq
NOCACHE;


create table newscomment(
	commentno number primary key,
	news_no number not null,
	groupno number,
	groupsq number,
	writer varchar2(20) not null,
	ncomment varchar2(4000) not null,
	commentdate varchar2(40)  not null,
	constraint fk_newscomment_newsno foreign key(news_no) references petnews(newsno) on delete cascade,
	constraint fk_newscomment_writer foreign key(writer) references member(mem_id)
);



select * from newscomment;
select * from petnews order by newsno desc;
COMMIT;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--댓글 test용 insert 2개~
insert into newscomment values(1,78,1,1, 'ADMIN', 'first comment!!!!!~', (select TO_CHAR(TO_DATE(SYSDATE), 'YYYY-MM-DD HH:mm:ss') from dual) );
insert into newscomment values(2,78,2,1, 'ADMIN', '두번째 댓글 입니다~ 잘나와야할텐데', (select TO_CHAR(TO_DATE(SYSDATE), 'YYYY-MM-DD HH:mm:ss') from dual) );

delete from newscomment;