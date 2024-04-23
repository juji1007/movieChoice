<%@page import="java.util.List"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
// 	int psNo = Integer.parseInt(request.getParameter("psNo"));
	session.getAttribute("pvo");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<script>
function sendData() {
	alert("sendData() 실행~~");
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
	alert(":: 데이터 확인 완료, 입력요청 처리~~~");
	firstForm.submit();
}

function list_go() {
		location.href = "free.jsp";
	}
</script>
</head>
<body>
<div>
<form action="postWrite_ok.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		
		<td>
<!-- 		<input type="text" name="psNo" title="번호" > -->
<!-- 		수정하기 ㅜㅜ -->
		<input type="hidden" name="no" title="작성자">
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="psTitle" title="제목">
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea name="psContent" rows="8" cols="50" title="내용"></textarea>
		</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<th>첨부파일</th> -->
<!-- 		<td> -->
<!-- 			<input type="file" name="filename"> -->
<!-- 		</td> -->
<!-- 	</tr> -->
	<tr>
		<td colspan="2">
			<input type="submit" value="저장" >
			<input type="reset" value="초기화">
			
			<input type="button" value="목록보기" onclick="list_go()">
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>