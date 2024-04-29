<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	
	int result = reviewDAO.delete(rvNo);
	System.out.println(">> delete 건수 : " + result);
	
	response.sendRedirect("reviewMain.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 삭제</title>
</head>
<body>
	<h2>리뷰 삭제 페이지</h2>
</body>
</html>