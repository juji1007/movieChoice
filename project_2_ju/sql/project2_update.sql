--24.05.04
--SQL 스크립트(오라클 SQL DEVELOPER)
--PROJECT2 / project22

CREATE TABLE ACCOUNT (
	NO	NUMBER(5)	NOT NULL,
	NAME	VARCHAR2(30)	NULL,
	ID	VARCHAR2(30)	NULL,
	PWD	VARCHAR2(30)	NULL,
	NICK	VARCHAR2(30)	NULL,
	CRITIC_CHECK	NUMBER(1)	NULL,
	EMAIL	VARCHAR2(50)	NULL,
	WARN	NUMBER(5)	DEFAULT 0
);

CREATE TABLE MOVIE (
	MV_NO	NUMBER(5)	NOT NULL,
	MV_TITLE	VARCHAR2(100)	NULL,
	MV_DIRECT	VARCHAR2(100)	NULL,
	MV_ACTOR	VARCHAR2(100)	NULL,
	MV_GENRE	VARCHAR2(50)	NULL,
	MV_RATE	NUMBER(3,1)	NULL,
	MV_AUDIENCE	VARCHAR2(30)	NULL,
	MV_GRADE	VARCHAR2(30)	NULL,
	MV_DATE	DATE	NULL,
	MV_POSTER	VARCHAR2(300)	NULL
);

CREATE TABLE REVIEW (
	RV_NO	NUMBER(5)	NOT NULL,
	MV_NO	NUMBER(5)	NOT NULL,
	NO	NUMBER(5)	NOT NULL,
	RV_NICK	VARCHAR2(30)	NULL,
	RV_TITLE	VARCHAR2(100)	NULL,
	RV_CONTENT	VARCHAR2(300)	NULL,
	RV_DATE	DATE	NULL,
	RV_RATE	NUMBER(2)	NULL
);

CREATE TABLE CRITIC (
	NO	NUMBER(5)	NOT NULL,
	COMPANY	VARCHAR2(30)	NULL,
	CAREER	VARCHAR2(300)	NULL,
	FILENAME	VARCHAR2(300)	NULL
);

CREATE TABLE REWARD (
	RW_NO	NUMBER(5)	NOT NULL,
	RV_NO	NUMBER(5)	NOT NULL,
	MV_NO	NUMBER(5)	NOT NULL,
	NO	NUMBER(5)	NOT NULL
);

CREATE TABLE POST (
	PS_NO	NUMBER(5)	NOT NULL,
	NO	NUMBER(5)	NOT NULL,
	PS_TITLE	VARCHAR2(100)	NULL,
	PS_CONTENT	VARCHAR2(300)	NULL,
	PS_DATE	DATE	NULL,
	PS_NICK	VARCHAR2(30)	NULL,
	PS_FILE	VARCHAR2(300)	NULL,
	PS_ORIFILE	VARCHAR2(300)	NULL
);

CREATE TABLE PS_COMMENT (
	PC_NO	NUMBER(5)	NOT NULL,
	PS_NO	NUMBER(5)	NOT NULL,
	NO	NUMBER(5)	NOT NULL,
	PC_DATE	DATE	NULL,
	PC_CONTENT	VARCHAR2(300)	NULL,
	PC_NICK	VARCHAR2(30)	NULL
);

CREATE TABLE QA (
	QA_NO	NUMBER(5)	NOT NULL,
	NO	NUMBER(5)	NOT NULL,
	QA_CONTENT	VARCHAR2(300)	NULL,
	QA_DATE	DATE	NULL
);

CREATE TABLE INQUIRY (
	IQ_NO	NUMBER(5)	NOT NULL,
	QA_NO	NUMBER(5)	NOT NULL,
	IQ_CONTENT	VARCHAR2(300)	NULL,
	IQ_DATE	DATE	NULL
);

CREATE TABLE REC (
	IDX	NUMBER(5)	NOT NULL,
	REC_NUM	NUMBER(1)	NULL,
	RV_NO	NUMBER(5)	NOT NULL,
	NO	NUMBER(5)	NOT NULL
);

CREATE TABLE WARN (
	IDX	NUMBER(5)	NOT NULL,
	WARN_NUM	NUMBER(1)	NULL,
	NO	NUMBER(5)	NOT NULL,
	RV_NO	NUMBER(5)	NULL,
	PS_NO	NUMBER(5)	NULL
);

CREATE TABLE CRITICAPPLY (
	NO	NUMBER(5)	NOT NULL,
	COMPANY	VARCHAR2(30)	NULL,
	CAREER	VARCHAR2(300)	NULL,
	FILENAME VARCHAR2(300)	NULL
);

ALTER TABLE ACCOUNT ADD CONSTRAINT PK_ACCOUNT PRIMARY KEY (
	NO
);

ALTER TABLE REVIEW ADD CONSTRAINT PK_REVIEW PRIMARY KEY (
	RV_NO
);

ALTER TABLE MOVIE ADD CONSTRAINT PK_MOVIE PRIMARY KEY (
	MV_NO
);

ALTER TABLE REWARD ADD CONSTRAINT PK_REWARD PRIMARY KEY (
	RW_NO
);

ALTER TABLE CRITIC ADD CONSTRAINT PK_CRITIC PRIMARY KEY (
	NO
);

ALTER TABLE CRITICAPPLY ADD CONSTRAINT PK_CRITICAPPLY PRIMARY KEY (
	NO
);

ALTER TABLE POST ADD CONSTRAINT PK_POST PRIMARY KEY (
	PS_NO
);

ALTER TABLE PS_COMMENT ADD CONSTRAINT PK_PS_COMMENT PRIMARY KEY (
	PC_NO
);

ALTER TABLE QA ADD CONSTRAINT PK_QA PRIMARY KEY (
	QA_NO
);

ALTER TABLE INQUIRY ADD CONSTRAINT PK_INQUIRY PRIMARY KEY (
	IQ_NO
);

ALTER TABLE REC ADD CONSTRAINT PK_REC PRIMARY KEY (
	IDX
);

ALTER TABLE WARN ADD CONSTRAINT PK_WARN PRIMARY KEY (
	IDX
);

ALTER TABLE REVIEW ADD CONSTRAINT FK_MOVIE_TO_REVIEW_1 FOREIGN KEY (
	MV_NO
)
REFERENCES MOVIE (
	MV_NO
);

ALTER TABLE REVIEW ADD CONSTRAINT FK_ACCOUNT_TO_REVIEW_1 FOREIGN KEY (
	NO
)
REFERENCES ACCOUNT (
	NO
);

ALTER TABLE CRITIC ADD CONSTRAINT FK_ACCOUNT_TO_CRITIC_1 FOREIGN KEY (
	NO
)
REFERENCES ACCOUNT (
	NO
);

ALTER TABLE POST ADD CONSTRAINT FK_ACCOUNT_TO_POST_1 FOREIGN KEY (
	NO
)
REFERENCES ACCOUNT (
	NO
);

ALTER TABLE PS_COMMENT ADD CONSTRAINT FK_POST_TO_PS_COMMENT_1 FOREIGN KEY (
	PS_NO
)
REFERENCES POST (
	PS_NO
);

ALTER TABLE PS_COMMENT ADD CONSTRAINT FK_ACCOUNT_TO_PS_COMMENT_1 FOREIGN KEY (
	NO
)
REFERENCES ACCOUNT (
	NO
);

ALTER TABLE QA ADD CONSTRAINT FK_ACCOUNT_TO_QA_1 FOREIGN KEY (
	NO
)
REFERENCES ACCOUNT (
	NO
);

ALTER TABLE INQUIRY ADD CONSTRAINT FK_QA_TO_INQUIRY_1 FOREIGN KEY (
	QA_NO
)
REFERENCES QA (
	QA_NO
)
ON DELETE CASCADE
;

ALTER TABLE CRITICAPPLY ADD CONSTRAINT FK_CRITIC_TO_CRITICAPPLY_1 FOREIGN KEY (
	NO
)
REFERENCES CRITIC (
	NO
);
CREATE SEQUENCE REVIEW_SEQ NOCACHE;
CREATE SEQUENCE ACCOUNT_SEQ NOCACHE;
CREATE SEQUENCE MOVIE_SEQ NOCACHE;
CREATE SEQUENCE PS_SEQ NOCACHE;
CREATE SEQUENCE PS_COMMENT_SEQ NOCACHE;
CREATE SEQUENCE QA_SEQ NOCACHE;
CREATE SEQUENCE INQUIRY_SEQ NOCACHE;
CREATE SEQUENCE REC_SEQ NOCACHE;
CREATE SEQUENCE WARN_SEQ NOCACHE;
CREATE SEQUENCE REWARD_SEQ NOCACHE;

-- 기존의 외래 키 제약 조건 삭제
ALTER TABLE REVIEW
DROP CONSTRAINT FK_ACCOUNT_TO_REVIEW_1;

-- 새로운 외래 키 제약 조건 추가 (ON DELETE CASCADE 적용)
ALTER TABLE REVIEW
ADD CONSTRAINT FK_ACCOUNT_TO_REVIEW_1
FOREIGN KEY (NO)
REFERENCES ACCOUNT (NO)
ON DELETE CASCADE;

-- 기존의 외래 키 제약 조건 삭제
ALTER TABLE POST
DROP CONSTRAINT FK_ACCOUNT_TO_POST_1;

-- 새로운 외래 키 제약 조건 추가 (ON DELETE CASCADE 적용)
ALTER TABLE POST
ADD CONSTRAINT FK_ACCOUNT_TO_POST_1
FOREIGN KEY (NO)
REFERENCES ACCOUNT (NO)
ON DELETE CASCADE;

--QA 테이블 카테고리 컬럼 추가
ALTER TABLE QA ADD QA_CATEGORY VARCHAR2(50);

--
ALTER TABLE QA
ADD QA_TITLE VARCHAR2(100);