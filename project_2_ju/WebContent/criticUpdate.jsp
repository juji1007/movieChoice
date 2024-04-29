<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
       int no = Integer.parseInt(request.getParameter("critic"));
	   System.out.println("crapply no() : " + no);
	   
	   criticVO vo = criticDAO.criticCone(no);
	   
	   System.out.println("update.jsp vo : " + vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전문가 정보 수정</title>
<link rel="stylesheet" href="css/header.css">
</head>
<body>
<%@ include file="include/header.jspf" %>
	<h1>전문가 정보 수정</h1>
	<form action="criticUpdateOk.jsp" method="post">
		<label for="company">소속</label><br>
        <input type="text" id="company" name="company" value="<%=vo.getCompany()%>">
        <br><br> 
        <label for="career">경력</label><br>
        <textarea id="career" name="career" rows="4" cols="50"><%=vo.getCareer()%></textarea> 
        <br><br>
        <label for="filename">파일</label><br>
        <input type="file" name="filename">  
        <br><br>
		
        <input type="submit" value="수정 완료">
        <input type="hidden" name="no" value=<%=no%>> 
    </form>
    
</body>
</html>



