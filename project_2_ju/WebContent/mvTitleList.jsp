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
</head>
<body>
<%@ include file="include/header.jspf" %>

	
	<a href="movieDetail.jsp?mvNo=${list.mvNo }">
	<table>
			<tr>
			<td>
			<img src="img/${list.mvPoster }" alt="제품이미지" width="200">
			</td>
			</tr>
			<tr>
			<td >${list.mvTitle }</td>
			</tr>
			
			
	</table>
	</a>

</body>
</html>