<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int no = Integer.parseInt(request.getParameter("critic"));
 
	criticVO cvo = new criticVO();
	cvo.setNo(no);
	 
	int deleted = criticDAO.delete(cvo); 
	System.out.println("criticDAO.delete : " + criticDAO.delete(cvo));

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
