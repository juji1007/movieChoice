<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@page import="com.mystudy.model.vo.qnaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int qaNo = Integer.parseInt(request.getParameter("qaNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 답변 작성</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/write.css">
<style>
	#btn {
		align-content: ceter;
	}
</style>
<script>
function sendData() {
    let firstForm = document.forms[0];
    firstForm.submit();
    alert("답변이 저장되었습니다!");
}

function list_go() {
        location.href = "qnaAdmin.jsp";
    }
</script>
</head>
<body>
<%@ include file="include/header.jspf" %>
<div class="body">
	<form action="inquiryWrite_ok.jsp" method="post">
	    <table>
	    	<caption>답변 작성하기</caption>
	    	<tbody>
		        <tr>
		            <td>
		                <textarea name="iqContent" rows="8" cols="50" title="답변" placeholder="답변을 입력하세요."></textarea>
		            </td>
		        </tr>
	        </tbody>
	        <tr>
	            <td class="button" colspan="2">
	                <input class="commitbtn" type="button" value="저장" onclick="sendData()">
	                <input class="reset" type="reset" value="초기화">
	                <input class="reset" type="button" value="목록보기" onclick="location.href = 'qnaAdmin.jsp'">
	                <input type="hidden" name="qaNo" value="<%=qaNo %>">
	            </td>
	        </tr>
	    </table>
	</form>
</div>
</body>
</html>