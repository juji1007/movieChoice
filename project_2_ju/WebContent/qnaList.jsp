<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 검색</title>
</head>
<body>
	<h1>${sort } 검색결과</h1>
	<c:forEach var="vo" items="${listOne }">
	<table> 
		<tr>
			<td>${vo.qaNo }</td>
			<td>${vo.qaDate }</td>
			<td>
				<a href="qnaView.jsp?qaNo=${vo.qaNo }">${vo.qaContent }</a>
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