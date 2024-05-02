<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int no = Integer.parseInt(request.getParameter("critic"));
 
	 
	int deleted = criticDAO.delete(no); 
	AccountDAO.updatedeleteCriticCheck(no);
	
	System.out.println("criticDAO.delete : " + deleted);

	if (deleted > 0) {
%>
	<script> 
		alert("삭제가 완료되었습니다!"); 
		location.href="criticAdmin.jsp";
	</script> 
<%
	} else {
%>
	<script> 
        alert("삭제에 실패했습니다!");
	 	location.href="criticAdmin.jsp";
	 </script>
<%
	} 
%>
