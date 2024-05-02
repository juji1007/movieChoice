<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 	rvDate(월별) 추천 수가 많은 rvNo를 select
// 	화면에 보이는 페이지/관리자가 업로드 할 수 있는 페이지 따로 구현
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이달의 리뷰</title>
<link rel="stylesheet" href="css/header.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
	<h1>Review Of The Month</h1>
	
	<h3>월별 조회</h3>
	<form action="rewardSearch.jsp" method="post">
		<select id="date" name="date">
			<c:forEach var="yymm" items="${vo }"><!--높은 추천수,월별로 조회한 배열vo-->
				<option value="YYMM">24년 1월-YY년 MM월</option>
			</c:forEach>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
		
		<input type="hidden" name="category" value="selectOne">
	</form>
</body>
</html>