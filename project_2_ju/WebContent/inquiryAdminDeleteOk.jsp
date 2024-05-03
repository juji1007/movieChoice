<%@page import="com.mystudy.model.vo.inquiryVO"%>
<%@page import="com.mystudy.model.dao.inquiryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int iqNo = Integer.parseInt(request.getParameter("iqNo"));
	System.out.println("iqNo : " + iqNo);
 	
	int deleted = inquiryDAO.delete(iqNo); 
	
	System.out.println("inquiryDAO.delete : " + deleted);

	if (deleted > 0) {
%>
	<script> 
		alert("답변 삭제가 완료되었습니다!"); 
		location.href="qnaAdmin.jsp";
	</script> 
<%
	} else {
%>
	<script> 
        alert("답변 삭제에 실패했습니다!");
	 	location.href="qnaAdmin.jsp";
	 </script>
<%
	} 
%>
