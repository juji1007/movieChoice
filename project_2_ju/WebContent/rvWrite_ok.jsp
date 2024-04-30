<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//리뷰 작성
	request.setCharacterEncoding("UTF-8");
%>
	<%-- enctype="multipart/form-data" 사용시 setProperty 값 설정안됨 --%>
	<jsp:useBean id="voList" class="com.mystudy.model.vo.reviewVO" />
	<jsp:setProperty property="*" name="voList"/>
	<jsp:setProperty property="no" name="voList" value="${no }"/>
	<jsp:setProperty property="rvNick" name="voList" value="${nick }"/>
	<jsp:setProperty property="rvNo" name="voList" value="${rvNo }"/>
	
<%
 	int result = reviewDAO.insert(voList);
 	System.out.println(":: 입력 건수 " + result);
	
	response.sendRedirect("reviewController?category=rvMain");
%>