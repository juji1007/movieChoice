<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="com.mystudy.model.vo.postCommentVO"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 
 	int pcNo = Integer.parseInt(request.getParameter("pcNo"));
 	session.setAttribute("pcNo", pcNo);
 	int no = (Integer)session.getAttribute("no");
 	postCommentVO cvo = postDAO.getComment(pcNo);
 	System.out.println("cvo : " + cvo);
 	System.out.println("cvoNo : " + cvo.getNo());
	session.setAttribute("coo", cvo);
 	
	int result = postDAO.deleteComment(pcNo);
	pageContext.setAttribute("result", result);

	String location = request.getParameter("location");
	if ("myPage".equals(location)) {
		response.sendRedirect("myPage.jsp");
	} else {
		postVO pvo = (postVO)session.getAttribute("pvo");
	 	String cPage = (String)session.getAttribute("cPage");
		response.sendRedirect("freeView.jsp?psNo=" + pvo.getPsNo() + "&cPage=" + cPage);
	}
%>
