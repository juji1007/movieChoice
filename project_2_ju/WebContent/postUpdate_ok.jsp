<%@page import="com.mystudy.model.dao.postDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="po" class="com.mystudy.model.vo.postVO" />
	<jsp:setProperty property="*" name="po"/>
<%
	System.out.println("> update_ok.jsp po : " + po);
	int result = postDAO.update(po);
	System.out.println(":: 입력완료 입력건수 : " + result);
	
	response.sendRedirect("free.jsp");
%>