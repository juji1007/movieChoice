<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 검색[freeList.jsp]</title>
</head>
<body>
	<h1>[${sort }]게시물</h1>
	<c:forEach var="vo" items="${listOne }">
	<table>
	<tr>
		<td>${vo.psNo }</td>
		<td>${vo.psDate }</td>
		<td>
		<a href="freeView.jsp?psNo=${vo.psNo }&cPage=${pvo.nowPage}">
		${vo.psTitle }
		</a>
		</td>
	</tr>
	</table>
	</c:forEach>
	<c:if test="${empty listOne }">
			<tr>
				<td colspan="3">검색 결과가 없습니다.</td>
			</tr>
		</c:if>
	
</body>
</html>