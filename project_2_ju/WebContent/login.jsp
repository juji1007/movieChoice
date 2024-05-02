<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	request.setCharacterEncoding("UTF-8");

	//아이디, 비번 받기
	//아이디, 비번 DB에서 조회
// 	String role = (String) session.getAttribute("role");
// 	String name = (String) session.getAttribute("name");
	String id = (String) session.getAttribute("id");
	if (id == "null") {
		
%>
	<script>
		alert("로그인에 실패하셨습니다.");
		location.href="logout.jsp";
		
	</script>
		
<%
	} else {
		
	 	if ("ju123".equals(id)) {
	 	    // 관리자 권한이 있는 경우에만 특정 기능에 접근할 수 있도록 처리
	 	    // 예: 관리자 전용 기능을 보여주는 코드
%>
			<script>
			alert("관리자 로그인에 성공하셨습니다.");
			location.href="manage.jsp";
			</script>
<%
	 	} else {
	 	    // 일반 사용자 또는 다른 역할에 대한 처리
	 	    // 예: 일반 사용자에게 보여주는 코드
	 	
	
		System.out.println("id : " + id);
// 		System.out.println("pwd : " + avo.getPwd()); 
%>
		<script>
			alert("로그인에 성공하셨습니다.");
			location.href="main.jsp";
		</script>
<%
		}
	}
%>