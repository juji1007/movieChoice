<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	//세션 제거
	session.invalidate();

	//정확한 경로
	String cPath = request.getContextPath();
	response.sendRedirect(cPath + "/main.jsp");
%>