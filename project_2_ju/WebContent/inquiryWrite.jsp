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
<div>
<form action="inquiryWrite_ok.jsp" method="post">
    <table>
        <tr>
            <th>답변</th>
            <td>
                <textarea name="iqContent" rows="8" cols="50" title="내용"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="button" value="저장" onclick="sendData()">
                <input type="reset" value="초기화">
                <input type="button" value="목록보기" onclick="location.href = 'qnaAdmin.jsp'">
                <input type="hidden" name="qaNo" value="<%=qaNo %>">
            </td>
        </tr>
    </table>
</form>
</div>
</body>
</html>