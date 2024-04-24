<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//영화 제목, 번호 불러오기
	List<movieVO> list = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		list =  ss.selectList("movie.all");
	} catch (Exception e) {
		e.printStackTrace();
	} 
	
	System.out.println("list : " + list);
	pageContext.setAttribute("list", list);
	
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">
<style>
	#btn {
		align-content: ceter;
	}
</style>
<script>
	function sendRv(frm) {
		frm.submit();
	}
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	  
    <form action="rvWrite_ok.jsp" method="get" enctype="application/x-wwaw-form-urlencoded">
	<table>
		<caption>리뷰 작성하기</caption>
		<tbody>
			<tr>
				<th>영화</th>
				<td>
					<select id="movie" name="movie">
			        	<c:forEach var="mvVo" items="${list}">
				            <option value=${mvVo['mvNo'] }>${mvVo['mvTitle'] }</option>
			        	</c:forEach>
        			</select>
				</td>
			</tr>
			<tr>
				<th>평점</th>
				<td>
					<input type="number" name="rate" min="0" max="10" title="평점">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" title="제목">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" rows="8" cols="50" title="내용"></textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr id="btn">
				<td colspan="2">
					<input type="button" value="등록" onclick="sendRv(this.form)">
			        <input type="reset" value="초기화">
			        <input type="button" value="목록보기" 
			        	onclick="javascript:location.href='reviewMain.jsp'">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
    
</body>
</html>