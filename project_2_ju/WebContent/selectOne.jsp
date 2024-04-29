<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 검색[ selectOne.jsp ]</title>
<link rel="stylesheet" href="css/header.css">
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>

	<h2>
		리뷰모음
		<input type="button" value="등록하기" 
			onclick="javascript:location.href='rvWrite.jsp'">
	</h2>
	
	<!-- 리뷰 목록 검색 -->	
	<form action="reviewController?category=selectOne" method="get">
		<select name="idx">
			<option selected disabled>::선택</option>
			<option value="0">영화명</option>
			<option value="1">작성자</option>
			<option value="2">작성일</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
		
		<input type="hidden" name="category" value="selectOne">
	</form>
	
	<h1>[${sort }-${keyword }] 리뷰목록</h1>
	
	<c:forEach var="vo" items="${listOne }">
	<table>
		<tr>
			<td>${vo.mvNo }</td>
			<td>${vo.rvTitle }</td>
		</tr>
		<tr>
			<td>${vo.rvNick }</td>
			<td>${vo.rvDate }</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="추천 "> ${vo.rvRec }
			</td>
			<td></td>
		</tr>
	</table>
	</c:forEach>
	
</body>
</html>