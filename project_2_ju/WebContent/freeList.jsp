<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 검색[freeList.jsp]</title>
</head>
<link rel="stylesheet" href="css/header.css">
<body>
	<%@ include file="include/header.jspf"%>
	<h1>[${sort }]게시물</h1>
	<table border>
	<c:forEach var="vo" items="${listOne }">
	<tr>
		<td>${vo.psNo }</td>
		<td>${vo.psNick }</td>
		<td>${vo.psDate }</td>
		<td>
		<a href="freeView.jsp?psNo=${vo.psNo }">
		${vo.psTitle }
		</a>
		</td>
	</tr>
	</c:forEach>
	</table>
	<c:if test="${empty listOne }">
			<tr>
				<td colspan="3">검색 결과가 없습니다.</td>
			</tr>
		</c:if>
	
</body>
</html>