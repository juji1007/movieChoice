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
</head>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/write.css">
<body>
<%@ include file="include/headerAdmin.jspf" %>
<div class="body">
<div>
<form action="criticUpdateOk.jsp" method="post">
	<table>
		<tr> 
			<td>
				<input  class="psTitle" type="text" name="company" title="소속" value="<%=vo.getCompany()%>">
			</td>
		</tr>
		<tr>
			<td>
				<textarea name="career" rows="8" cols="50" title="경력" ><%=vo.getCareer()%></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="file" name="filename"> 
			</td>
		</tr>
		<tr>
			<td class="button" colspan="2">
				<input class="commitbtn" type="submit" value="수 정" >
				<input type="hidden" name="no" value=<%=no%>>
				<input class="reset" type="button" value="목록" onclick="location.href='criticAdmin.jsp'">
			</td>
		</tr>
	</table>
</form> 
</div>
</div>
</body>
</html>



