<%@page import="com.project.dao.AccountDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
    request.setCharacterEncoding("UTF-8");

    String id = (String) request.getAttribute("id");
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
