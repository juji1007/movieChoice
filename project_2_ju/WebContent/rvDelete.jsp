<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	
	int result = reviewDAO.delete(rvNo);
	System.out.println(">> delete 건수 : " + result);
	
	String location = request.getParameter("location");
	
	if ("admin".equals(location)) {
		System.out.println(">> location : " + location);
		response.sendRedirect("manage.jsp");
	} else if ("reviewAdmin".equals(location)) {
		System.out.println(">> location : " + location);
		response.sendRedirect("reviewController?category=rvMain&location=reviewMainAdmin");
	} else if ("myPage".equals(location)) {
		System.out.println(">> location : " + location);
		response.sendRedirect("myPage.jsp");
	} else {
		response.sendRedirect("reviewController?category=rvMain");
	}
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