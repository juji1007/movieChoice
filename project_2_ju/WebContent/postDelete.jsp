<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int psNo = Integer.parseInt(request.getParameter("psNo"));
	pageContext.setAttribute("psNo", psNo);
	
	postVO pvo = postDAO.selectOne(psNo);
	System.out.println("pvo : " + pvo);
	
	int result = postDAO.delete(psNo);
	pageContext.setAttribute("result", result);
	
	String location = request.getParameter("location");
	if ("myPage".equals(location)) {
		System.out.println("location은 myPage");
		
		response.sendRedirect("myPage.jsp");
	} else {
		response.sendRedirect("free.jsp");
	}
%>


