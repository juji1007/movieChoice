<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	request.setCharacterEncoding("UTF-8");

	//id, 바꿀비번 가져오기
	String id = request.getParameter("id");
	String pwd = request.getParameter("password");
	System.out.println("passwordjsp : " + pwd);
	
	//아이디로 db조회 후 비번 바꾸기
	String checkId = AccountDAO.getAccountSearchPwd(id);
	System.out.println("id : " + checkId);
	if (checkId == null) {
%>
	<script>
		alert("회원가입된 아이디가 없습니다.");
		history.back();
	</script>
<%
	} else {
		
		//아이디인증 후 비밀번호 재설정
		int checkOk = AccountDAO.setAccountPwd(checkId, pwd);
		if (checkOk == -1) {
%>
	<script>
		alert("오류!!!");
		history.back();
	</script>
<%
		} else {
%>
	<script>
		alert("비밀번호가 수정되었습니다. 다시 로그인해주세요.");
		location.href="login_page.jsp"
	</script>
<%
		}
	}
	
	
%>