<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="upVo" class="com.mystudy.model.vo.reviewVO"/>
	<jsp:setProperty property="*" name="upVo"/>
	<jsp:setProperty property="no" name="upVo" value="${rvVo.no }"/>
	<jsp:setProperty property="rvNick" name="upVo" value="${rvVo.rvNick }"/>
	<jsp:setProperty property="rvNo" name="upVo" value="${rvVo.rvNo }"/>
<%
	System.out.println(">>rvUpdate.jsp totVo : " + upVo);
	//DB연동 - 리뷰 update
	int result = reviewDAO.update(upVo);
	System.out.println(">> 수정 건수 : " + result);
	
	response.sendRedirect("rvDetail.jsp?rvNo=" + upVo.getRvNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 중[ rvUpdate_ok.jsp ]</title>
</head>
<body>

</body>
</html>