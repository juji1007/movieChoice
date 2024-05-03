<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mystudy.model.dao.recDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	<h3>월별 조회
		<input type="button" value="이달의 리뷰" onclick="javascript:location.href='rewardController?category=rwMain'">
	</h3>
	<form action="rewardController?category=search" method="post">
		<select id="search" name="search">
				<option value="${thisMonth}">${thisMonth}</option>
			<c:forEach var="date" items="${set}"><!--높은 추천수,월별로 조회한 배열vo-->
				<option value="${date}">${date}</option>
			</c:forEach>
		</select>
		<input type="submit" value="검색">
		
		<input type="hidden" name="category" value="search">
	</form>
	
	<table border>
		<tbody>
			<tr>
				<td id="mvTitle">${rwVo.mvTitle}</td>
				<td id="rvTitle" colspan="3">${rwVo.rvTitle }</td>
			</tr>
			<tr>
				<td rowspan="2"><img src="img/${rwVo.mvPoster }" alt="포스터" width="300px"></td>
				<td id="rvNick">${rwVo.rvNick }</td>
				<td id="rvDate">${rwVo.rvDate }</td>
				<td id="btn">
					<input type="button" value="추천">
					${rwVo.rvRec}
					<input type="button" value="신고">
					${rwVo.rvWarn}
				</td>
			</tr>
			<tr>
				<td id="rvContent" colspan="3">${rwVo.rvContent }</td>
			</tr>
		</tbody>
	</table>
	
</body>
</html>