<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
request.setCharacterEncoding("UTF-8");
request.getAttribute("list");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화제목으로 검색</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/main.css">
</head>



<body>
<%@ include file="include/header.jspf" %>
 <div class="body">
	
	<form action="controller" method="get">
		<nav>
			<input class="search" type="text" name="mvTitle" placeholder="영화제목을 입력하세요">
			<input class="searchbtn" type="submit" value="영화검색">
			<input type="hidden" name="type" value="mvTitleList">
		</nav>
	</form>
	
	<a href="movieDetail.jsp?mvNo=${list.mvNo }">
	<h2>영화검색 결과</h2>
	<table>
			<tr>
			<td>
			<img src="img/${list.mvPoster }" alt="제품이미지" width="300">
			</td>
			</tr>
			<tr>
			<td ><h3>${list.mvTitle }</h3></td>
			</tr>
<%
	if(request.getAttribute("list") == null) {
%>
<script>
alert("검색결과가 없습니다.")
history.back();
</script>
<%
	};
%>
	</table>
	</a>
</div>
</body>
</html>