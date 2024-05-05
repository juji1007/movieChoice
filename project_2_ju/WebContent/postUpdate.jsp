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
<script>
function list_go() {
	location.href = "free.jsp";
}
</script>
</head>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/write.css">
<body>
<!-- header.jspf -->
	<%@ include file="include/header.jspf"%>
	<div class="body">
<div>
<form action="postUpdate_ok.jsp" method="post">
	<table>
	<tr>
		<td>
			<input type="hidden" name="no" value="${no }">
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<input class="psTitle" type="text" name="psTitle" value="${pvo.psTitle }">
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea name="psContent" rows="8" cols="50" >${pvo.psContent }</textarea>
		</td>
	</tr>
	<tr>
				<td class="button" colspan="2">
					<input class="commitbtn" type="submit" value="수 정" >
					<input class="reset" type="reset" value="초기화">
					<input type="hidden" name="psNo" value="${pvo.psNo }">
					<input class="reset" type="button" value="전체목록" onclick="list_go()">
				</td>
			</tr>
	</table>
</form>	

</div>
</div>
</body>
</html>