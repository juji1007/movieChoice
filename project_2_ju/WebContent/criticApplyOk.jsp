<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 	request.setCharacterEncoding("UTF-8");
 	
 	int no = Integer.parseInt(request.getParameter("critic"));
	
 	int applied = criticDAO.insert(no); 
 	System.out.println("criticDAO.insert : " + applied); 

 	if (applied > 0) {
 	    int deleted = criticDAO.deleteApply(no);
 	    if (deleted > 0) {
 	    	AccountDAO.updateCriticCheck(no);
 	%>
 	    <script> 
 	        alert("승인이 완료되었습니다!"); 
 	      
 	        location.href="criticAdmin.jsp";
 	    </script> 
 	<%
 	    } 
 	}
%>
      