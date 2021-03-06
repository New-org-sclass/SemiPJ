-- 펫지도 (산책로)

create sequence WALK_NO_SEQ ;

DROP SEQUENCE WALK_NO_SEQ;
DROP TABLE WALKTABLE;

CREATE TABLE WALKTABLE(

   WALK_NO NUMBER PRIMARY KEY,
   WALK_NAME VARCHAR2(1000) NOT NULL,
   WALK_WRITER VARCHAR2(100) NOT NULL,
   WALK_DONG VARCHAR2(500) NOT NULL,
   WALK_REGDATE DATE NOT NULL,
   WALK_LOC VARCHAR2(4000) NOT NULL
);

CONSTRAINT FK_WALK_WRITER FOREIGN KEY(WALK_WRITER) REFERENCES MEMBER(MEM_ID)


SELECT * FROM WALKTABLE ORDER BY WALK_NO;

SELECT * FROM WALKTABLE ;

SELECT * FROM WALKTABLE WHERE ROWNUM;



INSERT INTO WALKTABLE 
VALUES(WALK_NO_SEQ.NEXTVAL,'편한 길 산책로 30분걸림!!', '박정우', '목동', SYSDATE, 
'(37.53497441131593, 126.87657296591514),(37.5356661662874, 126.87465970254277),(37.536272920919565, 126.87760043898415)');



