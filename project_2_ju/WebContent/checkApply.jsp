<%@page import="com.project.vo.AccountVO"%>
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
	
	criticDAO.insertApply(cvo);

			String location = request.getParameter("location");
			if ("myPage".equals(location)) {
				
				
				System.out.println("myPage 회원정보수정");
%>	
		<script>
			alert("평론가 신청과 수정이 완료되었습니다!");
// 			location.href="loginController?type=updateAccount&location=checkApply&criticCheck=1";
// 			location.href="loginController?type=updateAccountOk&criticCheck=2";
			location.href="myPage.jsp";
		</script>		
<%
			} else {
%>			
		<script>
			alert("평론가 신청과 회원가입이 완료되었습니다!");
			location.href="login_page.jsp";
		</script> 
<%
			}
%>
