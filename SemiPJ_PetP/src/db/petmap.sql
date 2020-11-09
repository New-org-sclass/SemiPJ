-- 펫지도 (산책로)

create sequence WALK_NO_SEQ;
NOCACHE;

DROP TABLE WALKTABLE;

CREATE TABLE WALKTABLE(

   WALK_NO number primary key,
   WALK_NAME varchar2(2000) NOT NULL,
   WALK_WRITER varchar2(100) NOT NULL,
   WALK_DONG varchar2(500) NOT NULL,
   WALK_REGDATE DATE NOT NULL,
   WALK_LOC VARCHAR2(8000) NOT NULL,
   constraint FK_WALK_WRITER foreign key(WALK_WRITER) references member(mem_id)
);

SELECT * FROM WALKTABLE ;



