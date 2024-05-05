<%@page import="com.mystudy.model.vo.qnaVO"%>
<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    
    int qaNo = Integer.parseInt(request.getParameter("qaNo"));
    String location = request.getParameter("location"); 
    int deleted = qnaDAO.delete(qaNo); 
    
    System.out.println("location : " + location);
    System.out.println("qnaDAO.delete : " + deleted);

    if (deleted > 0) {
%>
    <script> 
        alert("삭제가 완료되었습니다!"); 
    </script>

<%
        if ("myPage".equals(location)) {
%>
            <script>
                location.href="myPage.jsp";
            </script> 
<%
        } else {
%>
            <script>
                location.href="qna.jsp";
            </script>
<%
        }
    } else {
%>
    <script> 
        alert("삭제에 실패했습니다!");
<%
        if ("myPage".equals(location)) {
%>
        location.href="myPage.jsp";
<%
        } else {
%>
        location.href="qna.jsp";
<%
        }
%>
    </script>
<%
    } 
%>
