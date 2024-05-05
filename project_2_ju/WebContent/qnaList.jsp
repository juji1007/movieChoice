<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 검색</title>
<script>
//목록보기
function list_go() {
	location.href = "qna.jsp";
}
</script>
</head>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/free.css">
<body>
<%@ include file="include/header.jspf"%>
	<div class="body">
	<h2>QnA ${sort } 검색</h2>
	    <form  action="qnaWrite.jsp" method="get">
	    	<input class="write" type="button" value="작성하기" onclick="login_confirm(this.form)">
	    </form>
		<hr class="color">
		<div class="box">
			<div class="innerbox">
		<div class="content">
	    <form action="qnaController?search=qnaList" method="get" onsubmit="return checkSearchCondition(this);">
	        <select class="select" name="idx">
				<option value="0">내용</option>
				<option value="1">작성일</option>
			</select> 
			<input class="search" type="text" name="keyword" placeholder="검색어 입력 (작성일 검색 ex: 20240507)"> 
			<input class="searchbtn" type="submit" value="검색"> 
	        <input type="hidden" name="search" value="qnaList">
	        <input class="listbtn"  type="button" value="전체목록" onclick="list_go()">
	    </form>
	    </div>
	    </div>
	    </div>
	    
	<c:choose>
		<c:when test="${not empty listOne}">
			<table>
				<c:forEach var="vo" items="${listOne}">
					<tr>
						<td width="5%">${vo.qaNo }</td>
						<td width="15%">${vo.qaDate }</td>
						<td></td>
						<td>
							<a href="qnaView.jsp?qaNo=${vo.qaNo }">${vo.qaContent }</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:when>
		<c:otherwise>
			<p>검색 결과가 없습니다.</p>
		</c:otherwise>
	</c:choose>
	</div>
</body>
</html>