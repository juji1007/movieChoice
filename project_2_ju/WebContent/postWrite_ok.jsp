<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

%>	
	<jsp:useBean id="po" class="com.mystudy.model.vo.postVO" />
	<jsp:setProperty property="*" name="po"/>

<%
// 	postVO vo = new postVO();
// 	//vo.setNo(Integer.parseInt(request.getParameter("no")));
// 	vo.setPsTitle(request.getParameter("psTitle"));
// 	vo.setPsContent(request.getParameter("psContent"));

	System.out.println("> write_ok.jsp po : " + po);
	int result = postDAO.insert(po);
	System.out.println(":: 입력완료 입력건수 : " + result);
	
	response.sendRedirect("free.jsp");
%>