<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>	
	<jsp:useBean id="pvo" class="com.mystudy.model.vo.postVO" />
	<jsp:setProperty property="*" name="pvo"/>
	
<%
	
	System.out.println("> write_ok.jsp pvo : " + pvo);
	postDAO.insert(pvo);
	
	response.sendRedirect("free.jsp");
%>