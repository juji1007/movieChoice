<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 검색[ selectOne.jsp ]</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/free.css">
<!-- <link rel="stylesheet" href="css/rvMain.css"> -->

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
//로그인 후 작성가능
	function login_confirm(frm) {
		<%if (session.getAttribute("no") == null) {%>
			alert("로그인 후 작성 가능합니다.");
			frm.location.href = "reviewController?category=rvMain&location=reviewMainAdmin";
		<%} else%>
			frm.submit();
	}

</script>
</head>
<body>
	<!-- headerAdmin.jspf -->
	<%@ include file="include/headerAdmin.jspf" %>
	<div class="body">
	<h2>[${sort} - ${keyword }] 조회</h2>
	
	<form action="reviewController?category=rvWrite" method="post">
		<input class="write" type="button" value="등록하기" 
			onclick="login_confirm(this.form)">

	</form>
	<hr class="color">
	<div class="box">
		<div class="innerbox">
		<div class="content">
	<!-- 리뷰 목록 검색 -->	
	<form action="reviewController?category=selectOne&location=reviewMainAdmin" method="post">
		<select class="select" name="idx">
			<option selected disabled>::선택</option>
			<option value="0">영화명</option>
			<option value="1">작성자</option>
			<option value="2">작성일</option>
		</select>
		<input class="search" type="text" name="keyword" placeholder="검색어 입력 (작성일 검색 ex: 20240507)">
		<input class="searchbtn" type="submit" value="검색">
		<input class="listbtn" type="button" value="전체조회"
			onclick="javascript:location.href='reviewController?category=rvMain&location=reviewMainAdmin'">	
		<input type="hidden" name="category" value="selectOne">
	</form>
	</div>
		</div>
		</div>
		
<!-- 리뷰 (조건)목록 -->
<form action="reviewController?category=selectOne&location=reviewMainAdmin" method="post">
	<table border frame=void>
		<thead>
			<tr>
			<th width="5%">번호</th>
			<th width="20%">영화명</th>
			<th width="10%">작성자</th>
			<th width="10%">작성일</th>
			<th>제목</th>
			<th colspan="2" width="20%">추천/신고</th>
			</tr>
		</thead>
	<c:forEach var="vo" items="${listOne }">
		<tbody id="reviewOne">
			<tr>
	        	<td rowspan="2">${vo.rvNo }</td>
	            <td>${vo.mvTitle }</td>
	            <td>${vo.rvNick }</td>
	            <td>${vo.rvDate }</td>
	            <td id="rvTitle"><a href="rvDetailAdmin.jsp?rvNo=${vo.rvNo }&cPage=${selPvo.nowPage}">${vo.rvTitle }</a></td>
	            <td>
	            	<input class="up_button" type="button" value="추천"> ${vo.rvRec}  
	            </td>
	            <td>
	            	<input class="up_button" type="button" value="신고"> ${vo.rvWarn}
	            	
	            	<input type="hidden" name ="rvNo" value="${vo.rvNo }">
	            	<input type="hidden" name ="mvNo" value="${vo.mvNo }">
	            	<input type="hidden" name ="vo" value="${vo }">
	            	<input type="hidden" name ="recNo" value="${vo.no }">
	            </td>
	        </tr>
	    </tbody>
	</c:forEach>
		
		<tfoot id="page">
	        <tr>
	        	<td colspan="7">
					<ol class="paging">
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${selPvo.nowPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${selPvo.nowPage != 1 }">
						<li>
							<a href="reviewController?category=selectOne&cPage=${selPvo.endPage - 1 }&idx=${idx }&keyword=${keyword}">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${selPvo.beginPage }" end="${selPvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == selPvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="reviewController?category=selectOne&cPage=${pageNo }&idx=${idx }&keyword=${keyword}">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${selPvo.nowPage < selPvo.totalPage }">
						<li>
							<a href="reviewController?category=selectOne&cPage=${selPvo.nowPage + 1 }&idx=${idx }&keyword=${keyword}">다음</a>
						</li> 
					</c:if>
					<c:if test="${selPvo.nowPage >= selPvo.totalPage }">
						<li class="disable">다음</li> 
					</c:if>
					</ol>
				</td>
	    	</tr>
	    </tfoot>
	</table>
</form>	
	
</body>
</html>