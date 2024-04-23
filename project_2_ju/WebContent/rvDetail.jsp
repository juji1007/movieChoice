<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지 [ rvDetail.jsp ]</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvDetail.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function prev_go() {
		
	}
	
	function list_go() {
		
	}
	
	function next_go() {
		
	}
	
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
	<h2>[${mvOne.mvTitle }] - 리뷰</h2>
	<table border>
		<tbody>
			<tr>
				<td rowspan="3"><img src="img/${mvOne.mvPoster }" alt="포스터" width="300px"></td>
				<td id="rvTitle" colspan="3">${rvOne.rvTitle }</td>
			</tr>
			<tr>
				<td id="rvNick">${rvOne.rvNick }</td>
				<td id="rvWrite">${rvOne.rvDate }</td>
				<td id="rvRec">
					<input type="button" value="추천수 " onclick="recommand_push()">
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px"> 
					${rvOne.rvRec }
				</td>
			</tr>
			<tr>
				<td id="rvContent" colspan="3">${rvOne.rvContent }</td>
			</tr>
		</tbody>
		<tfoot class="tfoot">
			<td colspan="4">
				<input type="button" value="이전" onclick="prev_go()">
				<input type="button" value="목록" onclick="reviewMain.jsp">
				<input type="button" value="다음" onclick="next_go()">
			</td>
		</tfoot>
	</table>
	
	
</body>
</html>