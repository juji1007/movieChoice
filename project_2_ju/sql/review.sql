SELECT * FROM REVIEW
ORDER BY RV_NO DESC;
--    R_NO, M_NO, A_NO, R_NICK, R_TITLE
--  , R_CONTENT, R_DATE, R_REC

SELECT * FROM REVIEW;

INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 1, 'ace119', 8, '재밌음ㅋㅋ'
      , '원래 이런 장르 즐겨보지 않는데 연기력이 받쳐주니 빠져들어서 시간 순삭!!', SYSDATE, 0, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 2, 'kys106', 7, '강추bb'
      , '너무 재밌어요ㅠㅠ', SYSDATE, 0, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 3, 'lss330', 10, '인생영화'
      , '간만에 볼 영화 생겼음ㅎㅎ', SYSDATE, 0, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 3, 'lss330', 6, '애니메이션 오랜만에 봄'
      , '중간에 시간이 비어서 오랜만에 애니메이션 영화 봤어욬ㅋㅋ 재밌음', SYSDATE, 0, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 9, 4, 'kim1990', 1, '시간 아까워요'
      , '배우들에 비해 스토리가 빈약해서 시간아까웠어요', SYSDATE, 0, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 4, 'kim1990', 5, '아이들이랑 함께 봤어요'
      , '아이들이 좋아하긴 하는데 저는 시시했어요', SYSDATE, 0, 0);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 6, 'lim704', 7, '여름에 볼 영화로 추천'
      , '시원하게 여름에 보기 좋아요', SYSDATE, 0, 0);