<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.getAttribute("no");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정화면</title>
</head>
<body>
<div>
<p><a href="qna.jsp">목록으로 이동</a>
<form action="qnaUpdate_ok.jsp" method="post">
	<table>
	<tr>
		<td>
			<input type="hidden" name="no" value="${no }">
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea name="qaContent" rows="8" cols="50" >${qvo.qaContent }</textarea>
		</td>
	</tr>
	<tr>
				<td colspan="2">
					<input type="submit" value="수 정" >
					<input type="reset" value="취 소">
					<input type="hidden" name="qaNo" value="${qvo.qaNo }">
				</td>
			</tr>
	</table>
</form>	

</div>
</body>
</html>