<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
request.getAttribute("listOne");
%>

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
<%-- <% --%>
// List list = (List<postVO>)request.getAttribute("listOne");
// if (list.size() == 0) {
<%-- 	System.out.println("aa");}%> --%>

<!-- <script> -->
// alert("검색결과가 없습니다.")
// history.back();
<!-- </script> -->

	</c:forEach>


	</table>
	
	
</body>
</html>