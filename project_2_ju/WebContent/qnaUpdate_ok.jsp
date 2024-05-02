<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="qo" class="com.mystudy.model.vo.qnaVO" />
	<jsp:setProperty property="*" name="qo"/>
<%
	System.out.println("> update_ok.jsp qo : " + qo);
	int result = qnaDAO.update(qo); 
	System.out.println(":: 입력완료 입력건수 : " + result);
%>
	<script>
		alert("수정이 완료되었습니다!");
		location.href = "qna.jsp";
	</script>