<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

// 	int no = Integer.parseInt(request.getParameter("no"));
	
	String id = request.getParameter("id");
// 	String id = (String) session.getAttribute("id");
	int no = AccountDAO.getAccountSearchNo(id);
	String company = request.getParameter("company");
	String career = request.getParameter("career");
	String filename = request.getParameter("filename");
	
	System.out.println("no : " + no);
	System.out.println("check apply id : " + id);
	System.out.println("company : " + company);
	System.out.println("career : " + career);
	System.out.println("filename : " + filename);
	
	criticVO cvo = new criticVO();
	cvo.setNo(no);
	cvo.setFilename(filename);
	cvo.setCareer(career);
	cvo.setCompany(company);
	
	criticDAO.insert(cvo);
%>	
<script> 
		alert("신청이 완료되었습니다!");
		location.href="memberJoinOk.jsp";
</script> 