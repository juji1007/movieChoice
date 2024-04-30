<%@page import="com.project.vo.AccountVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
       String id = request.getParameter("id");
	   System.out.println("crapply Id() : " + id);
	   
	   String location = request.getParameter("location");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전문가 신청서</title>
</head>
<body>
	<h1>전문가 신청서</h1>
	<form action="checkApply.jsp" method="post">
		<label for="company">소속</label><br>
        <input type="text" id="company" name="company">
        <br><br>
        <label for="career">경력</label><br>
        <textarea id="career" name="career" rows="4" cols="50"></textarea>
        <br><br>
        <label for="filename">파일</label><br>
        <input type="file" name="filename">
        <br><br>
		
		<input type="submit" value="신청완료">
		<input type="hidden" name="id" value=<%=id%>> 
		<input type="hidden" name="location" value=<%=location%>> 
	</form>

</body>
</html>








