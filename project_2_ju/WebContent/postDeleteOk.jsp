<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int psNo = Integer.parseInt(request.getParameter("psNo"));
	postVO pvo = new postVO();
	pvo.setPsNo(psNo);
	 
	int deleted = postDAO.pDelete(pvo); 
	System.out.println("postDAO.delete : " + postDAO.pDelete(pvo));

	if (deleted > 0) {
%>
	<script> 
		alert("삭제가 완료되었습니다!"); 
		location.href="freeAdmin.jsp";
	</script> 
<%
	} else {
%>
	<script> 
        alert("삭제에 실패했습니다!");
	 	location.href="freeAdmin.jsp";
	 </script>
<%
	} 
%>
