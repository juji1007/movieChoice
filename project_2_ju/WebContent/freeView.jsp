<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	int psNo = Integer.parseInt(request.getParameter("psNo"));
	String cPage = request.getParameter("cPage");
	
	postVO pvo = postDAO.selectOne(psNo);
	System.out.println("게시글 pvo : " + pvo);
	
	session.setAttribute("pvo", pvo);
	session.setAttribute("cPage", cPage);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
</head>
<body>
<table >
	<tr>
	<td colspan=3><h1>${pvo.psTitle }</h1></td>
	</tr>
	<tr>
	<td>작성자</td>
	<td>${pvo.psDate }</td>
	<td>추천수</td>
	</tr>
</table>
<hr>
<tr>
	<td colspan=3>${pvo.psContent }</td>
</tr>
	

<hr>
<!-- 댓글작성 -->
<!-- 댓글표시 -->
</body>
</html>