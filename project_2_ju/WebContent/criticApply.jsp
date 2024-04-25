<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
       String id = request.getParameter("id");
	   System.out.println("crapply Id() : " + id);
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
        <input type="text" id="company" name="company" required>
        <br><br>
        <label for="career">경력</label><br>
        <textarea id="career" name="career" rows="4" cols="50" required></textarea>
        <br><br>
        <label for="filename">파일</label><br>
        <input type="text" name="filename" required>
        <br><br>
		
		<input type="submit" value="신청완료">
		<input type="hidden" name="id" value=<%=id%>> 
	</form>

</body>
</html>








