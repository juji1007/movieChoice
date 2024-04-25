<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int no = Integer.parseInt(request.getParameter("no"));
	
	String company = request.getParameter("company");
	String career = request.getParameter("career");
	String filename = request.getParameter("filename");
	
	System.out.println("no : " + no);
	System.out.println("company : " + company);
	System.out.println("career : " + career);
	System.out.println("filename : " + filename);
	
	criticVO cvo = new criticVO();
	cvo.setNo(no);
	cvo.setFilename(filename);
	cvo.setCareer(career);
	cvo.setCompany(company);
	
	int updated = criticDAO.update(cvo);
	System.out.println("criticDAO.update : " + criticDAO.update(cvo));
	
	if (updated > 0) {
%>
	<script> 
		alert("수정이 완료되었습니다!");
		location.href="criticAdmin.jsp";
	</script> 
<%
	}
%>
