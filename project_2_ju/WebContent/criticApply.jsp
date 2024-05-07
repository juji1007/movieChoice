<%@page import="com.project.vo.AccountVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	   AccountVO avo =  (AccountVO) request.getAttribute("avo");
       String id = request.getParameter("id");
	   System.out.println("crapply Id() : " + id);
// 	   System.out.println("crapply avo() : " + avo);
	   
	   String location = request.getParameter("location");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평론가 신청서</title>
<link rel="stylesheet" href="css/write.css">
</head>
<body>

<div class="body">
	<h1>평론가 신청서</h1>
	<form action="checkApply.jsp" method="post">
		<label for="company">소속</label><br>
        <input class="psTitle" type="text" id="company" name="company">
        <br><br>
        <label for="career">경력</label><br>
        <textarea id="career" name="career" rows="4" cols="50"></textarea>
        <br><br>
        <label for="filename">파일</label><br>
        <input id="file" type="file" name="filename">
        <br><br>
		
		<input class="commitbtn" type="submit" value="신청완료">
		<input type="hidden" name="id" value=<%=id%>> 
		<input type="hidden" name="location" value=<%=location%>> 
	</form>
	
</div>

</body>
</html>








