<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	System.out.println("rvNo : " + rvNo);
	
	int no = (Integer)session.getAttribute("no");
	System.out.println("no : " + no);
	
	int rvRec = reviewDAO.recCnt(rvNo, no);
	System.out.println("rvRec 수 : " + rvRec);
%>
	<jsp:useBean id="recVo" type="com.mystudy.model.vo.reviewVO"/>
	<jsp:setProperty property="*" name="recVo"/>
<%
	System.out.println("recVo : " + recVo);
	
	response.sendRedirect("mainReview.jsp");
	
// 	int rvRec = reviewDAO.getRec(rvNo);
// 	System.out.println("rvRec : " + rvRec);
// 	session.setAttribute("rvRec", rvRec);
// 	response.sendRedirect("reviewMain.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천수 count</title>
<script>
	//history.go(-1);
</script>
</head>
<body>
	
</body>
</html>