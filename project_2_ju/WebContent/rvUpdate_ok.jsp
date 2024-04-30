<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="update" class="com.mystudy.model.vo.reviewVO"/>
	<jsp:setProperty property="*" name="update"/>
	<jsp:setProperty property="no" name="update" value="${upVo.no }"/>
	<jsp:setProperty property="rvNick" name="update" value="${upVo.rvNick }"/>
	<jsp:setProperty property="rvNo" name="update" value="${upVo.rvNo }"/>
<%
	System.out.println(">>rvUpdate.jsp totVo : " + update);
	//DB연동 - 리뷰 update
	int result = reviewDAO.update(update);
	System.out.println(">> 수정 건수 : " + result);
	
	response.sendRedirect("reviewController?category=rvMain&rvNo=" + update.getRvNo());
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