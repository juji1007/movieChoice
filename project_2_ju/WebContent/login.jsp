<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	request.setCharacterEncoding("UTF-8");

	//아이디, 비번 받기
	//아이디, 비번 DB에서 조회
	
	AccountVO avo = (AccountVO) session.getAttribute("avo");
	if (avo == null) {
		
%>
	<script>
		alert("로그인에 실패하셨습니다.");
		history.back();
		
	</script>
		
<%
	} else {
	
		System.out.println("id : " + avo.getId());
		System.out.println("pwd : " + avo.getPwd());
%>
		<script>
			alert("로그인에 성공하셨습니다.");
			location.href="main.jsp";
		</script>
<%
	}
%>