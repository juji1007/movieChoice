<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	List<postVO> listp = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		listp = ss.selectList("post.all");
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("plist???? : " + listp);
	request.setAttribute("listp", listp);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
</head>
<body>
	<img class= "icon" src="img/moviechoice.png">
	<hr>
	<h2>자유게시판</h2>
	<button onclick="location.href='writePost.jsp'">작성하기</button>
	<hr>
	<form action="PostServlet" method="get">
        <select name="idx">
			<option selected disabled>::선택</option>
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
		</select>
        <select name="idx">
			<option selected disabled>::선택</option>
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
        <br><br>
	 </form>
	 <c:forEach var="vo" items="${listp }">
			<table>
				<tr>
					<td>${vo.psNo }</td>
<!-- 					<td> -->
<%-- 						<a>${vo.psTitle }</a> --%>
<!-- 					</td> -->
				</tr>
<!-- 				<tr> -->
<%-- 					<td>${vo.psDate }</td> --%>
<!-- 				</tr> -->
			</table>
	</c:forEach>
</body>
</html>