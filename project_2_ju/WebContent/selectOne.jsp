<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	/* List<MovieVO> movieVo = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		movieVo = MovieDAO.movieList();
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("movieVo : " + movieVo);
	
	session.setAttribute("movieVO", movieVo); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 검색[ selectOne.jsp ]</title>
</head>
<body>
	<h1>[${sort }-${keyword }] 리뷰목록</h1>
	<hr>
	
	<c:forEach var="vo" items="${listOne }">
	<table>
		<tr>
			<td>${mvOne.mvTitle }</td>
			<td>${vo.rvTitle }</td>
		</tr>
		<tr>
			<td rowspan="2">${mvOne.mvPoster }</td>
			<td>${vo.rvNick }</td>
		</tr>
		<tr>
			<td>${vo.rvDate }</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="추천수 ">
				<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px"> 
				${vo.rvRec }
			</td>
		</tr>
	</table>
	<hr>
	</c:forEach>
	
</body>
</html>