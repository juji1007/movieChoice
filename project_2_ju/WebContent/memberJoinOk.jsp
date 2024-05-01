<%@page import="com.project.vo.AccountVO"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<%-- 	<jsp:useBean id="" --%>
<%
	
	// 회원가입 데이터 받기
// 	int no = 3;
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String nickName = request.getParameter("nickName");
	String email = request.getParameter("email");
	String crticCheck = request.getParameter("criticCheck"); // 관리자페이지랑연결
	System.out.println("crticCheck : " + crticCheck);

	int criticCheckInt = 0;
	if (crticCheck != null && !crticCheck.isEmpty()) {
		criticCheckInt = Integer.parseInt(crticCheck);
	} else {
		criticCheckInt = 0;
	}
	System.out.println("criticCheckInt : " + criticCheckInt);
	
	System.out.println("nickName : " + nickName);
	AccountVO avo = new AccountVO();
	avo.setName(name);
	avo.setId(id);
	avo.setPwd(pwd);
	avo.setNick(nickName);
	avo.setEmail(email);
// 	avo.setCriticCheck(criticCheckInt);
// 	request.setAttribute("avo", avo);

	
	// 회원가입 데이터 DB에 삽입
	int checkJoin = AccountDAO.insertMember(avo);
	
	System.out.println("checkJoin : " + checkJoin);
	if (checkJoin == -1) {
		String alertMessage = "회원가입이 실패하였습니다.";
%>
	<script>
		alert("<%= alertMessage %>");
		location.href="login_page.jsp";
	</script>
<%
// 	response.sendRedirect("login_page.jsp");
	} else {
		System.out.println("avo.getId() : " + avo.getId());
 			if (criticCheckInt == 1) {
%>
					<script>
					location.href="criticApply.jsp?id=<%=avo.getId() %>";
				</script>
<%
		} else {
%>

	<script>
		alert("회원가입에 성공하셨습니다.");
		location.href="login_page.jsp";
	</script>
<%
		}
	}
// 	response.sendRedirect("login_page.jsp");
%>