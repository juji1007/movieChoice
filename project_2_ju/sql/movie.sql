INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '쿵푸팬더4', '마이크 미첼, 스테파니 스티네', '잭블랙, 비올라 데이비스, 아콰피나, 더스틴 호프만 등', '애니메이션, 액션', 8.6, '925655명', '전체관람가',
'2024-04-10', 'kungfu.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '듄-파트2', '드니 빌뇌브', '티모시 샬라메, 젠데이아 콜먼, 레베카 퍼거슨, 조쉬 브롤린 등', '액션', 9.2, '1969174명', '12세이상관람가',
'2024-02-28', 'dune.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '고스트버스터즈', '길 키넌', '폴 러드, 캐리 쿤, 핀 울프하드, 맥케나 그레이스 등', '어드벤처, 액션', 8.8, '340000명', '12세이상관람가',
'2024-04-17', 'ghost.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '파묘', '장재현', '최민식, 김고은, 유해진, 이도현 등', '미스터리', 9.5, '11649808명', '15세이상관람가',
'2024-02-22', 'exhuma.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '스파이 패밀리 코드', '카타기리 타카시', '에구치 타쿠야, 타네자키 아츠미, 하야미 사오리 등', '애니메이션', 9.4, '803500명', '12세이상관람가',
'2024-03-20', 'spy.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '남은인생10년', '후지이 미치히토', '고마츠 나나, 사카구치 켄타로, 쿠로키 하루, 마츠시게 유타카 등', '로맨스, 멜로', 9.1, '332951명', '12세이상관람가',
'2024-04-03', 'last10.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '오멘 저주의 시작', '아르카샤 스티븐슨', '넬 타이거 프리, 타우픽 바롬, 소냐 브라가, 랄프 이네슨 등', '호러', 8.7, '152690명', '15세이상관람가',
'2024-04-03', 'omen.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '건담 시드 프리덤 ', '후쿠다 미츠오', '호시 소이치로, 이시다 아키라, 타나카 리에 등', '애니메이션', 8.8, '49486명', '12세이상관람가',
'2024-04-03', 'freedom.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '댓글부대', '안국진', '손석구, 김성철, 김동휘, 홍경 등', '범죄, 드라마', 8.3, '931439명', '15세이상관람가',
'2024-03-27', 'troll.jpg'
);
INSERT INTO MOVIE
VALUES (
MOVIE_SEQ.NEXTVAL, '캐롤', '토드 헤인즈', '케이트 블란쳇, 루니 마라, 카일 챈들러 등', '드라마', 7.2, '355371명', '청소년관람불가',
'2024-04-17', 'carol.jpg'
);

SELECT *
FROM MOVIE;

SELECT *
FROM MOVIE
ORDER BY M_RATE DESC;