<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
    request.setCharacterEncoding("UTF-8");

    // 이메일 주소 받기
    String email = request.getParameter("email");
    System.out.println("emailjsp : " + email);
    // 아이디 DB에서 조회
    String id = AccountDAO.getAccountSearchId(email);
    System.out.println("id : " + id);
    if (id == null) {
%>
    <script>
        alert("회원가입된 이메일이 없습니다.");
        history.back();
    </script>
<%
    } else {
%>
    <script>
        alert("아이디는 <%= id %> 입니다.");
        location.href="login_page.jsp"; //추후에 첫페이지컨트롤러 
    </script>
<%
    }
%>
