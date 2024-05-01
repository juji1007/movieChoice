<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int no = Integer.parseInt(request.getParameter("critic"));
 
	criticVO cvo = new criticVO();
	cvo.setNo(no);
	 
	int deleted = criticDAO.deleteApply(no);  
	System.out.println("criticDAO.deleteApply : " + criticDAO.deleteApply(no));

	if (deleted > 0) {
%>
	<script> 
		alert("거절되었습니다!"); 
		location.href="criticAdmin.jsp";
	</script> 
<%
	} 
%>

