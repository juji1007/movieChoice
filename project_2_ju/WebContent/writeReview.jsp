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
	
	//System.out.println("list : " + list);
	request.setAttribute("list", list);
	
	//request.getRequestDispatcher("rvWrite_ok.jsp").forward(request, response);
	
	String mvTitle = request.getParameter("movie");
	System.out.println("mvTitle : " + mvTitle);
	
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
		alert("sendData() 실행~~");
		console.log(document.forms[0]);
		let firstForm = document.forms[0];
		console.log(firstForm.elements);
		
		for (let htmlObj of firstForm.elements) {
			console.log(htmlObj);
			
			if (htmlObj.value.trim() == "") {
				console.log(htmlObj);
				if (htmlObj.getAttribute("type") == "file") continue;
				alert(htmlObj.title + " 입력하세요");
				htmlObj.focus();
				return;
			}
			console.log(":: 데이터 확인 완료, 입력요청 처리~~~");
			firstForm.submit();
		}
	}
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
<div>
    <form action="rvWrite_ok.jsp" method="get" enctype="multipart/form-data">
	<table>
		<caption><%= mvTitle %> 리뷰 작성하기</caption>
		<tbody>
			<tr>
				<th>영화</th>
				<td>
					<input type="text" name="mvTitle" title="영화" value="<%= mvTitle %>" readonly="readonly">
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
					<input type="button" value="등록" onclick="sendRv()">
			        <input type="reset" value="초기화">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
</div>
    
</body>
</html>



