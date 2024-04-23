SELECT *
FROM ACCOUNT
ORDER BY NO DESC;
--NO, NAME, ID, PWD, NICK, CRITIC_CHECK, EMAIL
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '홍길동', 'hong1', '1111', 'ace119', 0, 'hong@naver.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '김유신', 'kim3', '3333', 'kys106', 0, 'you@naver.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '이순신', 'lee4', '4444', 'lss330', 0, 'shin@gmail.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '김옥순', 'kimkim', '1111', 'kim1990', 0, 'dlkjd@naver.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '박철수', 'park', '1111', 'park5', 0, 'parks5@nate.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '임지혜', 'limjh', '1111', 'lim704', 0, 'jihye@naver.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '고영희', 'gogo', '1111', 'going606', 0, 'dlkjd@nate.com');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '이성계', 'LSG', '4444', 'sunny', 0, 'lee@daum.net');
INSERT INTO ACCOUNT
VALUES (ACCOUNT_SEQ.NEXTVAL, '강감찬', 'RIVER', '4444', 'river89', 0, 'kangkc@gmail.com');

SELECT * FROM MOVIE
ORDER BY MV_NO DESC;
--M_NO,M_TITLE,M_DIRECT,M_ACTOR,M_GENRE,M_RATE,M_AUDIENCE,M_GRADE,M_DATE,M_POSTER
INSERT INTO MOVIE
VALUES (MOVIE_SEQ.NEXTVAL, '파묘', '장재현', '최민식,김고은,유해진,이도현', '미스터리'
      , 8.21, '1,164만명', '전체관람가', '20240222', 'poster1.jpg');
INSERT INTO MOVIE
VALUES (MOVIE_SEQ.NEXTVAL, '쿵푸팬더4', '마이크 미첼'
      , '잭 블랙,아콰피나,비올라 데이비스', '애니메이션', 7.22
      , '94만명', '전체관람가', '20240410'
      , 'poster2.jpg');
INSERT INTO MOVIE
VALUES (3, '댓글부대', '안국진'
      , '손석구, 김성철, 김동휘, 홍경', '범죄물', 7.62
      , '93만명', '전체관람가', '20240327'
      , 'poster3.jpg');

SELECT * FROM REVIEW
ORDER BY RV_NO DESC;
--    R_NO, M_NO, A_NO, R_NICK, R_TITLE
--  , R_CONTENT, R_DATE, R_REC
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 1, 'ace119', '재밌음ㅋㅋ'
      , '원래 이런 장르 즐겨보지 않는데 연기력이 받쳐주니 빠져들어서 시간 순삭!!', SYSDATE, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 2, 'kys106', '강추bb'
      , '너무 재밌어요ㅠㅠ', SYSDATE, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 3, 'lss330', '인생영화'
      , '간만에 볼 영화 생겼음ㅎㅎ', SYSDATE, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 2, 3, 'lss330', '애니메이션 오랜만에 봄'
      , '중간에 시간이 비어서 오랜만에 애니메이션 영화 봤어욬ㅋㅋ 재밌음', SYSDATE, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 3, 4, 'kim1990', '시간 아까워요'
      , '배우들에 비해 스토리가 빈약해서 시간아까웠어요', SYSDATE, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 2, 4, 'kim1990', '아이들이랑 함께 봤어요'
      , '아이들이 좋아하긴 하는데 저는 시시했어요', SYSDATE, 0);
      
      