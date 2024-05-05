

<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.getAttribute("no");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<script>
function sendData() {


	console.log(document.forms[0]);
	let firstForm = document.forms[0];
	console.log(firstForm.elements);
	
	for (let htmlObj of firstForm.elements) {
		if (htmlObj.value.trim() == "") {
			console.log(htmlObj);
			if (htmlObj.getAttribute("type") == "file") continue;
			alert(htmlObj.title + " 입력하세요");
			htmlObj.focus();
			return;
		}
	}

	firstForm.submit();
}

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
<form action="postWrite_ok.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<td>
		<input type="hidden" name="no"  value="${no }">
		</td>
	</tr>
	<tr>
<!-- 		<th>제목</th> -->
		<td>
			<input  class="psTitle" type="text" name="psTitle" title="제목" placeholder="제목을 입력하세요.">
		</td>
	</tr>
	<tr>
<!-- 		<th>내용</th> -->
		<td>
			<textarea name="psContent" rows="8" cols="50" title="내용" placeholder="내용을 입력하세요."></textarea>
		</td>
	</tr>
	<tr>
<!-- 		<th>첨부파일</th> -->
		<td>
			<input  type="file" name="psFile">
		</td>
	</tr>
	<tr>
		<td class="button" colspan="2">
			<input class="commitbtn" type="button" value="작성완료" onclick="sendData()">
			<input class="reset" type="reset" value="초기화">
			<input class="reset" type="button" value="전체목록" onclick="list_go()">
		</td>
	</tr>
</table>
</form>
</div>
</div>
</body>
</html>