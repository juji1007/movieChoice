<%@page import="com.mystudy.model.dao.reviewDAO"%> 
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 메인 페이지</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function recommand_push() {
		location.href = "rvRecommand.jsp";
		submit();
	}
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
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
	
	<h2>리뷰모음</h2>
	<hr>
	
	<c:forEach var="vo" items="${listMv }">
		<!-- <a href="reviewController?type=rvDetail"> -->
		<table id="reviewOne">
			<tbody>
				<tr>
					<td colspan=>영화명${mvVo.mvTitle }</td>
					<td id="rvDetail" colspan="2">
						<a href="reviewController?type=rvDetail&mvNo=${vo.mvNo }&rvNo=${vo.rvNo}">${vo.rvTitle }</a>
					</td>
				</tr>
				<tr>
					<td rowspan="2"><img src="img/kungfu.jpg" alt="포스터" width="150px"></td>
					<td>${vo.rvNick }</td>
					<td>${vo.rvDate }</td>
				</tr>
			</tbody>
			
			<tfoot>
				<td class="recNo" colspan="3">
					<input type="button" value="추천수 " onclick="reviewController?type=rvRecommand&rvNo=${vo.rvNo}&rvRec=${vo.rvRec}">
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px">
					${vo.rvRec }
				</td>
			</tfoot>
		</table>
	</c:forEach>
	
</body>
</html>