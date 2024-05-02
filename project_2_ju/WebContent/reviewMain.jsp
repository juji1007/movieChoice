<%@page import="com.mystudy.model.dao.recDAO"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.project.review.paging.Paging"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 메인</title>
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
	
	//추천수,신고수 버튼 적용
	//toggle 기능 - 한번 클릭 추천, 한번 더 클릭 해제
// 	function rec_toggle(frm) {
// 		//본인 리뷰가 아닌지 확인
// 		if (${no} != ${recNo}) {
// 			alert("${recNo} : " + ${recNo});
// 			//처음 추천 클릭시, 추천(+1) 처리
// 			location.href= "reviewController?category=rvMain&category=clickOn";
// 			location.href= "rvRec.jsp?rvNo=${listOne.rvNo}";
			
// 			//두번 클릭시, 추천 해제(-1) 처리
			
// 		} else {
// 			alert("본인 리뷰는 추천할 수 없습니다.");
// 		}
// 	}
	
	function warn_push() {
		location.href = "rvWarn.jsp";
		frm.submit();
	}
	
</script>

</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	<form action="reviewController?category=rvWrite" method="post">
	<h2>
		리뷰모음
		<input type="button" value="등록하기" 
			onclick="login_confirm(this.form)">
	</h2>
	</form>
	
	<h3>전체조회</h3>
	<!-- 리뷰 목록 검색 -->	
	<form action="reviewController?category=selectOne" method="post">
		<select name="idx">
			<option selected disabled>::선택</option>
			<option value="0">영화명</option>
			<option value="1">작성자</option>
			<option value="2">작성일</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
		
		<input type="hidden" name="category" value="selectOne">
	</form>
	 
<!-- 리뷰 (전체)목록 -->
<form>
	<table>
	<c:forEach var="vo" items="${listAll}">
		<tbody id="reviewOne">
	        <tr>
	        	<td rowspan="2">${vo.rvNo }</td>
	            <td>${vo.mvTitle }</td>
	            <td id="rvTitle"><a href="rvDetail.jsp?rvNo=${vo.rvNo }&cPage=${rvPvo.nowPage}">${vo.rvTitle }</a></td>
	        </tr>
	        <tr>
	            <td>${vo.rvNick }</td>
	            <td>${vo.rvDate }</td>
	        </tr>
	        <tr>
	            <td rowspan="2" colspan="3">
	            	<input type="button" value="추천" onclick="rec_toggle(this.form)">${vo.rvRec}
<!-- 	            	<input type="button" value="추천" -->
<%-- 	            		data-rvVO-no="${vo.no}" onclick="rec_toggle(this.form, this.dataset.rvVONo)">${vo.rvRec} --%>
	            	<input type="button" value="신고" onclick="warn_push(this.form)">${vo.rvWarn}
	            	
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
	        	<td colspan="3">
					<ol class="paging">
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${rvPvo.nowPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${rvPvo.nowPage != 1 }">
						<li>
							<a href="reviewController?category=rvMain&cPage=${rvPvo.endPage - 1 }">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${rvPvo.beginPage }" end="${rvPvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == rvPvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="reviewController?category=rvMain&cPage=${pageNo }">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${rvPvo.nowPage < rvPvo.totalPage }">
						<li>
							<a href="reviewController?category=rvMain&cPage=${rvPvo.nowPage + 1 }">다음</a>
						</li> 
					</c:if>
					<c:if test="${rvPvo.nowPage >= rvPvo.totalPage }">
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

