<%@page import="com.mystudy.model.vo.qnaVO"%>
<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int qaNo = Integer.parseInt(request.getParameter("qaNo"));
	System.out.println("qaNo : " + qaNo);
 	
	int deleted = qnaDAO.delete(qaNo); 
	
	System.out.println("qnaDAO.delete : " + deleted);

	if (deleted > 0) {
%>
	<script> 
		alert("삭제가 완료되었습니다!"); 
		location.href="qnaAdmin.jsp";
	</script> 
<%
	} else {
%>
	<script> 
        alert("삭제에 실패했습니다!");
	 	location.href="qnaAdmin.jsp";
	 </script>
<%
	} 
%>
