INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 1, 'ace119', 8, '재밌음ㅋㅋ'
      , '원래 이런 장르 즐겨보지 않는데 연기력이 받쳐주니 빠져들어서 시간 순삭!!', '20240330');
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 2, 'kys106', 7, '강추bb'
      , '너무 재밌어요ㅠㅠ', '20240330');
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 3, 'lss330', 10, '인생영화'
      , '간만에 볼 영화 생겼음ㅎㅎ', '20240330');
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 3, 'lss330', 6, '애니메이션 오랜만에 봄'
      , '중간에 시간이 비어서 오랜만에 애니메이션 영화 봤어욬ㅋㅋ 재밌음', '20240330');
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 9, 4, 'kim1990', 1, '시간 아까워요'
      , '배우들에 비해 스토리가 빈약해서 시간아까웠어요', '20240330');
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 4, 'kim1990', 5, '아이들이랑 함께 봤어요'
      , '아이들이 좋아하긴 하는데 저는 시시했어요', '20240330');
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 6, 'lim704', 7, '여름에 볼 영화로 추천'
      , '시원하게 여름에 보기 좋아요', '20240330');  

INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 1, 'ace119', '재밌음ㅋㅋ'
      , '원래 이런 장르 즐겨보지 않는데 연기력이 받쳐주니 빠져들어서 시간 순삭!!', '20240416', 8);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 2, 'kys106', '강추bb'
      , '너무 재밌어요ㅠㅠ', '20240416', 7);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 3, 'lss330', '인생영화'
      , '간만에 볼 영화 생겼음ㅎㅎ', '20240416', 10);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 3, 'lss330', '애니메이션 오랜만에 봄'
      , '중간에 시간이 비어서 오랜만에 애니메이션 영화 봤어욬ㅋㅋ 재밌음', '20240416', 6);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 9, 4, 'kim1990', '시간 아까워요'
      , '배우들에 비해 스토리가 빈약해서 시간아까웠어요', '20240416', 1);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 4, 'kim1990', '아이들이랑 함께 봤어요'
      , '아이들이 좋아하긴 하는데 저는 시시했어요', '20240416', 5);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 6, 'lim704', '여름에 볼 영화로 추천'
      , '시원하게 여름에 보기 좋아요', '20240416', 7);
      
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 1, 'ace119', 8, '재밌음ㅋㅋ'
      , '원래 이런 장르 즐겨보지 않는데 연기력이 받쳐주니 빠져들어서 시간 순삭!!', SYSDATE);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 2, 'kys106', 7, '강추bb'
      , '너무 재밌어요ㅠㅠ', SYSDATE);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 3, 'lss330', 10, '인생영화'
      , '간만에 볼 영화 생겼음ㅎㅎ', SYSDATE);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 3, 'lss330', 6, '애니메이션 오랜만에 봄'
      , '중간에 시간이 비어서 오랜만에 애니메이션 영화 봤어욬ㅋㅋ 재밌음', SYSDATE);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 9, 4, 'kim1990', 1, '시간 아까워요'
      , '배우들에 비해 스토리가 빈약해서 시간아까웠어요', SYSDATE);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 1, 4, 'kim1990', 5, '아이들이랑 함께 봤어요'
      , '아이들이 좋아하긴 하는데 저는 시시했어요', SYSDATE);
INSERT INTO REVIEW
VALUES (REVIEW_SEQ.NEXTVAL, 4, 6, 'lim704', 7, '여름에 볼 영화로 추천'
      , '시원하게 여름에 보기 좋아요', SYSDATE);

      
---
--reviewMapper.xml
<!-- (동적 검색)조건 선택하여 리뷰 목록 조회 -->
	<select id="one" parameterType="map" resultType="com.mystudy.model.vo.listTotVO">
		SELECT RV_NO, NO, MV_TITLE, MV_POSTER
		     , RV_NICK, RV_RATE, RV_TITLE, RV_CONTENT
		     , RV_CONTENT, RV_DATE, RV_REC, RV_WARN
		FROM (SELECT ROWNUM R_NUM, R.*, M.*
		      FROM (SELECT *
		            FROM REVIEW
		            ORDER BY RV_NO DESC
		            ) R, MOVIE M
		      WHERE R.MV_NO = M.MV_NO
		<choose>
     		<when test = "idx == 0">
		      AND MV_TITLE = #{keyword}
     		</when>
     		<when test = "idx == 1">
		      AND RV_NICK = #{keyword}
     		</when>
     		<when test = "idx == 2">
		      AND TO_CHAR(RV_DATE, 'YYYYMMDD') = #{keyword}
     		</when>
     		<otherwise>
			  AND 1 = 2
			</otherwise>
     	</choose>
	<![CDATA[
		      AND ROWNUM <= #{end}
		      )
    WHERE R_NUM >= #{begin}
	]]>
    </select>