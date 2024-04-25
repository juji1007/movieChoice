<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="com.mystudy.model.vo.postCommentVO"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 
 	int pcNo = Integer.parseInt(request.getParameter("pcNo"));
 	pageContext.setAttribute("pcNo", pcNo);
 	
 	postCommentVO cvo = postDAO.getComment(pcNo);
 	System.out.println("cvo : " + cvo);
 	
 	postVO pvo = (postVO)session.getAttribute("pvo");
 	String cPage = (String)session.getAttribute("cPage");

	int result = postDAO.deleteComment(pcNo);
	pageContext.setAttribute("result", result);
	
	response.sendRedirect("freeView.jsp?psNo=" + pvo.getPsNo() + "&cPage=" + cPage);
// 	response.sendRedirect("free.jsp");
%>