<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.listMvRv"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	List<reviewVO> list = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		list = ss.selectList("review.all");
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("list : " + list);
	
	session.setAttribute("list", list);
	
	List<movieVO> movieVo = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		movieVo =movieDAO.movieList();
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("movieVo : " + movieVo);
	
	session.setAttribute("movieVO", movieVo);
	
	
	/* List<listMvRv> listView = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		listView = reviewDAO.selectList(mvNo);
	} catch (Exception e) {
		e.printStackTrace();
	} */
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 메인 페이지</title>
<script>
	function recommand_push() {
		location.href = "recommand.jsp";
		submit();
	}
</script>
</head>
<body>
	<form action="controller?category=selectOne" method="get">
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
	
	<c:forEach var="vo" items="${list }">
	<a href="rvDetail.jsp?rvNo=${vo.rvNo }">
	<table>
		<tr>
			<td rowspan="3"><img src="image/poster1.jpg" alt="포스터" width="150px"></td>
			<td>${vo.mvNo }</td>
			<td>
				<a>${vo.rvTitle }</a>
			</td>
		</tr>
		<tr>
			<td>${vo.rvNick }</td>
			<td>${vo.rvDate }</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="추천 " onclick="recommand_push()">
				${vo.rvRec }
			</td>
			<td></td>
		</tr>
	</table>
	</a>
	</c:forEach>
	
</body>
</html>