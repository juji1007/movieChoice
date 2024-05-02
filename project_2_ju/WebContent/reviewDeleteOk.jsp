<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
 
	reviewVO rvo = new reviewVO();
	rvo.setRvNo(rvNo);
	 
	int deleted = reviewDAO.delete(rvo); 
	System.out.println("reviewDAO.delete : " + reviewDAO.delete(rvo));

	if (deleted > 0) {
%>
	<script> 
		alert("삭제가 완료되었습니다!"); 
		location.href="reviewMainAdmin.jsp";
	</script> 
<%
	} else {
%>
	<script> 
        alert("삭제에 실패했습니다!");
	 	location.href="reviewMainAdmin.jsp";
	 </script>
<%
	} 
%>
