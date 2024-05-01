<%@page import="com.mystudy.model.dao.postDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	request.setCharacterEncoding("UTF-8");
 
	String cPage = request.getParameter("cPage");
%>
 	<jsp:useBean id="cvo" class="com.mystudy.model.vo.postCommentVO"/>
 	<jsp:setProperty property="*" name="cvo"/>
<%
	cvo.setNo((Integer) session.getAttribute("no"));
	cvo.setPcNick((String) session.getAttribute("nick"));
	System.out.println("cvo : " + cvo);
	postDAO.insertComment(cvo);
	
	response.sendRedirect("freeView.jsp?psNo=" + cvo.getPsNo() + "&cPage=" + cPage);
%>
