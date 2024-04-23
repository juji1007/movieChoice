<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글처리
	request.setCharacterEncoding("UTF-8");
%>	
	<jsp:useBean id="pvo" class="com.mystudy.model.vo.postVO" />
	<jsp:setProperty property="*" name="pvo"/>
	
<%
	
	System.out.println("> write_ok.jsp pvo : " + pvo);
	
	int result = postDAO.insert(pvo);
	System.out.println(":: 입력완료 입력건수 : " + result);
	
	//화면전환(목록페이지로 이동 - 첫페이지로 가기)
	response.sendRedirect("free.jsp");
%>