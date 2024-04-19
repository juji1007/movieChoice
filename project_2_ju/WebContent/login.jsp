<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	request.setCharacterEncoding("UTF-8");

	//아이디, 비번 받기
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
// 	System.out.println("id : " + id);
	
	//아이디, 비번 DB에서 조회
	AccountVO avo = AccountDAO.getAccountLogin(id, pwd);
	System.out.println("avo : " + avo);
	
	if (avo == null) {
// 	String id1 = AccountDAO.getAccountSearchLoginCheckId(id);
// 	if (id1 == null) {
%>
	<script>
		alert("로그인에 실패하셨습니다.");
		history.back();
	</script>
		
<%
	} else {
	
%>
		<script>
			alert("로그인에 성공하셨습니다.");
			history.back();
		</script>
<%
	}
%>