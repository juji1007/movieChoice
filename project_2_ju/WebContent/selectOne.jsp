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
<link rel="stylesheet" href="css/rvMain.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
//로그인 후 작성가능
	function login_confirm(frm) {
		<%if (session.getAttribute("no") == null) {%>
			alert("로그인 후 작성 가능합니다.");
			frm.location.href = "reviewController?category=rvMain";
		<%} else%>
			frm.submit();
	}
	
// 	function checkSearchCondition(frm) {
// 		var selValue = form.elements["idx"].value;
// 		var keyword = form.elements["keyword"].value.trim();
// 		if (selValue === "" || keyword === "") {
// 			alert("검색 조건과 키워드를 모두 선택해주세요.");
// 			return false;
// 		}
// 		return true;
// 	}

</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	<h2>
		리뷰모음
		<input type="button" value="등록하기" 
			onclick="login_confirm(this.form)">
		<input type="button" value="전체조회" 
			onclick="javascript:location.href='reviewController?category=rvMain'">
	</h2>
	
	<h3>[${sort} - ${keyword }] 조회</h3>
	<!-- 리뷰 목록 검색 -->	
	<form action="reviewController?category=selectOne" method="post">
		<select name="idx">
			<option selected disabled>::선택</option>
			<option value="0">영화명</option>
			<option value="1">작성자</option>
			<option value="2">작성일</option>
		</select>
		<input type="text" name="keyword" placeholder="작성일 ex: 20240507">
		<input type="submit" value="검색">
		
		<input type="hidden" name="category" value="selectOne">
	</form>
	
<!-- 리뷰 (조건)목록 -->
<form action="reviewController?category=selectOne" method="post">
	<table>
	<c:forEach var="vo" items="${listOne }">
		<tbody id="reviewOne">
	        <tr>
	            <td rowspan="2">${vo.rvNo }</td>
	            <td>${vo.mvTitle }</td>
	            <td id="rvTitle"><a href="rvDetail.jsp?rvNo=${vo.rvNo }&cPage=${selPvo.nowPage}">${vo.rvTitle }</a></td>
	        </tr>
	        <tr>
	            <td>${vo.rvNick }</td>
	            <td>${vo.rvDate }</td>
	        </tr>
	        <tr>
	            <td rowspan="2" colspan="2">
	            	<input type="button" value="추천">${vo.rvRec }
	            	<input type="button" value="신고">${vo.rvWarn }
	            	
	            	<input type="hidden" name ="rvNo" value="${vo.rvNo }">
	            	<input type="hidden" name ="mvNo" value="${vo.mvNo }">
	            </td>
	        </tr>
	    </tbody>
	</c:forEach>
		
		<tfoot id="page">
	        <tr>
	        	<td colspan="3">
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