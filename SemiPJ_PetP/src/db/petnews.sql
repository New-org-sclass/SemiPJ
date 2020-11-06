-- 펫뉴스
--	게시물번호, title, url, summary, content(태그채로 범위정해서 html에 표현?), 게시썸네일, 날짜시간
		
--		dto: no, title, url, summary content, img, date

drop table petnews;
drop table newscomment;
drop table member;

drop sequence petnewsnosq;
drop sequence newscommentnosq;
drop sequence newscommentgroupsq;
drop sequence newscommentgroupnosq;

delete from petnews;

create sequence petnewsnosq;

create sequence newscommentnosq
NOCACHE;

create sequence newscommentgroupnosq
NOCACHE;

create sequence newscommentgroupsq
NOCACHE;

create table petnews(
			   newsNo number primary key,
			   nTitle varchar2(200) not null,
			   nUrl varchar2(500),
			   nSummary varchar2(500),
			   nContent clob,
			   nImg   varchar2(500),
			   nDate   date
);

create table newscomment(
	commentno number primary key,
	news_no number unique not null,
	groupno number,
	groupsq number,
	writer varchar2(20) not null,
	comment varchar2(4000) not null,
	commentdate date  not null,
	constraint fk_newscomment_newsno foreign key(news_no) references petnews(newsNo) on delete cascade,
	constraint fk_newscomment_writer foreign key(writer) references member(mem_id)
);

select * from newscomment;
select * from petnews order by newsno desc;
COMMIT;