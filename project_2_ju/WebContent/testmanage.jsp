<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자페이지</title>
<style>
img.icon {
	position: absolute;
	left: 200px;
	top: 60px;
}

li {
	float: left;
	display: block;
	padding: 10px 26px;
	font-size: 18px;
}

a {
	text-decoration: none;
	color: black;
}

ul.menu {
	position: absolute;
	list-style-type: none;
	margin: 0;
	padding: 0;
	top: 60px;
	left: 530px;
}

li a:hover {
	color: #56BEC0;
	font-weight: bold;
}

hr.mint {
	background-color: #56BEC0;
	height: 3px;
	margin-top: 120px;
}

ul.login {
	position: absolute;
	list-style-type: none;
	margin: 0;
	padding: 0;
	top: 60px;
	right: 200px;
}

ul.login li {
	padding: 12px 5px;
	font-size: 14px;
}

hr.gray {
	background-color: D9D9D9;
	height: 1px;
}

#banner {
	width: 5000px;
}

#frame {
	width: 1130px;
	position: relative;
	overflow: hidden;
}

table {
/* 	position: absolute; */
	top: 50%;
	left: 50%;
  	transform: translate(250px, -10px);  
  	margin-top: -10%;
	width: 70%;
	max-height: 400px;
	overflow-y: auto;
	border-collapse: collapse;
	border: 1px solid black;
}

.body {
	position: relative;
	padding-top: 200px;
}

caption {
	margin-bottom: 50px;
}

th, td {
    border: 1px solid black; /* 테이블 경계선 설정 */
    padding: 8px; /* 셀 안의 여백 설정 */
    text-align: center; /* 가운데 정렬 */
}

thead {
/* 	position: absolute; */
/* 	top: 50%; */
/* 	left: 50%; */
/* 	transform: translate(-50%, -50%); */
/* 	width: 70%; */
 	border: 1px solid black;  
}

thead th tr td{
	display: flex;
	align-items: center;
	border: 1px solid black; 
}

thead select, thead input[type="text"], thead input[type="submit"] {
	margin-right: 10px;
}

tbody th tr td{
	border: 1px solid black; 
	
}
</style>
</script>
</head>
<body>
	<div class="header">
		<a href="main.jsp"> <img class="icon" src="img/moviechoice.png">
		</a>

		<ul class="menu">
			<li><a href="main.jsp">영화목록 관리</a></li>
			<li><a href="reviewMain.jsp">리뷰모음 관리</a></li>
			<li><a href="free.jsp">자유게시판 관리</a></li>
			<li><a href="about.asp">Q &amp; A 관리</a></li>
			<li><a href="about.asp">Review Of The Month 관리</a></li>
			<li><a href="about.asp">평론가 관리</a></li>
			<li><a href="about.asp">유저 관리</a></li>
		</ul>
		<hr class="mint">
	</div>
	<div class="body">
		<form method="post">
			<table>
				<caption>
					<h2>관리자 검색</h2>
				</caption>
				<thead>
					<tr>
						<td><select name="idx">
								<option selected="" disabled="">선택</option>
								<option value="0">전체</option>
								<option value="1">리뷰</option>
								<option value="2">영화</option>
								<option value="3">유저</option>
						</select></td>
						<td><input type="text" name="keyword"></td>
						<td><input type="button" value="검색"
							onclick="selectCategory(this.form)"></td>
					</tr>
				</thead>
				<tbody id="jsonData">
					<tr>
						<th>테이블</th>
						<th>영화 번호</th>
						<th>제목</th>
						<th>감독</th>
						<th>배우</th>
						<th>장르</th>
						<th>평점</th>
						<th>관람객 수</th>
						<th>등급</th>
						<th>개봉일</th>
						<th>포스터</th>
					</tr>
					<tr class="movie">
						<td>1</td>
						<td>쿵푸팬더4</td>
						<td>마이크 미첼, 스테파니 스티네</td>
						<td>잭블랙, 비올라 데이비스, 아콰피나, 더스틴 호프만 등</td>
						<td>애니메이션, 액션</td>
						<td>8</td>
						<td>925655명</td>
						<td>전체관람가</td>
						<td>2024-04-10</td>
						<td>kungfu.jpg</td>
					</tr>
					<tr class="movie">
						<td>2</td>
						<td>듄-파트2</td>
						<td>드니 빌뇌브</td>
						<td>티모시 샬라메, 젠데이아 콜먼, 레베카 퍼거슨, 조쉬 브롤린 등</td>
						<td>액션</td>
						<td>9</td>
						<td>1969174명</td>
						<td>12세이상관람가</td>
						<td>2024-02-28</td>
						<td>dune.jpg</td>
					</tr>
					<tr class="movie">
						<td>3</td>
						<td>고스트버스터즈</td>
						<td>길 키넌</td>
						<td>폴 러드, 캐리 쿤, 핀 울프하드, 맥케나 그레이스 등</td>
						<td>어드벤처, 액션</td>
						<td>8</td>
						<td>340000명</td>
						<td>12세이상관람가</td>
						<td>2024-04-17</td>
						<td>ghost.jpg</td>
					</tr>
					<tr class="movie">
						<td>4</td>
						<td>파묘</td>
						<td>장재현</td>
						<td>최민식, 김고은, 유해진, 이도현 등</td>
						<td>미스터리</td>
						<td>9</td>
						<td>11649808명</td>
						<td>15세이상관람가</td>
						<td>2024-02-22</td>
						<td>exhuma.jpg</td>
					</tr>
					<tr class="movie">
						<td>5</td>
						<td>스파이 패밀리 코드</td>
						<td>카타기리 타카시</td>
						<td>에구치 타쿠야, 타네자키 아츠미, 하야미 사오리 등</td>
						<td>애니메이션</td>
						<td>9</td>
						<td>803500명</td>
						<td>12세이상관람가</td>
						<td>2024-03-20</td>
						<td>spy.jpg</td>
					</tr>
					<tr class="movie">
						<td>6</td>
						<td>남은인생10년</td>
						<td>후지이 미치히토</td>
						<td>고마츠 나나, 사카구치 켄타로, 쿠로키 하루, 마츠시게 유타카 등</td>
						<td>로맨스, 멜로</td>
						<td>9</td>
						<td>332951명</td>
						<td>12세이상관람가</td>
						<td>2024-04-03</td>
						<td>last10.jpg</td>
					</tr>
					<tr class="movie">
						<td>7</td>
						<td>오멘 저주의 시작</td>
						<td>아르카샤 스티븐슨</td>
						<td>넬 타이거 프리, 타우픽 바롬, 소냐 브라가, 랄프 이네슨 등</td>
						<td>호러</td>
						<td>8</td>
						<td>152690명</td>
						<td>15세이상관람가</td>
						<td>2024-04-03</td>
						<td>omen.jpg</td>
					</tr>
					<tr class="movie">
						<td>8</td>
						<td>건담 시드 프리덤</td>
						<td>후쿠다 미츠오</td>
						<td>호시 소이치로, 이시다 아키라, 타나카 리에 등</td>
						<td>애니메이션</td>
						<td>8</td>
						<td>49486명</td>
						<td>12세이상관람가</td>
						<td>2024-04-03</td>
						<td>freedom.jpg</td>
					</tr>
					<tr class="movie">
						<td>9</td>
						<td>댓글부대</td>
						<td>안국진</td>
						<td>손석구, 김성철, 김동휘, 홍경 등</td>
						<td>범죄, 드라마</td>
						<td>8</td>
						<td>931439명</td>
						<td>15세이상관람가</td>
						<td>2024-03-27</td>
						<td>troll.jpg</td>
					</tr>
					<tr class="movie">
						<td>10</td>
						<td>캐롤</td>
						<td>토드 헤인즈</td>
						<td>케이트 블란쳇, 루니 마라, 카일 챈들러 등</td>
						<td>드라마</td>
						<td>7</td>
						<td>355371명</td>
						<td>청소년관람불가</td>
						<td>2024-04-17</td>
						<td>carol.jpg</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>


</body>
</html>