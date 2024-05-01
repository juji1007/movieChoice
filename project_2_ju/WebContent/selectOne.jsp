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
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>

	<h2>
		리뷰모음
		<input type="button" value="등록하기" 
			onclick="javascript:location.href='rvWrite.jsp'">
	</h2>
	
	<!-- 리뷰 목록 검색 -->	
	<form action="reviewController?category=selectOne" method="get">
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
	
	<h1>[${sort }-${keyword }] 리뷰목록</h1>
<form>
	<table>
	<c:forEach var="vo" items="${listOne }">
		<tbody id="reviewOne">
	        <tr>
	            <td>${vo.mvNo }-영화명으로 변경</td>
	            <td id="rvTitle"><a href="rvDetail.jsp?rvNo=${vo.rvNo }&cPage=${rvPvo.nowPage}">${vo.rvTitle }</a></td>
	        </tr>
	        <tr>
	            <td>${vo.rvNick }</td>
	            <td>${vo.rvDate }</td>
	        </tr>
	        <tr>
	            <td colspan="2">
	            	<input type="button" value="추천" onclick="javascript:location.href='rvRec.jsp?rvNo=${vo.rvNo}'">${vo.rvRec }
	            	<input type="button" value="신고" onclick="warn_push(this.form)">${vo.rvWarn }
	            	
	            	<input type="hidden" name ="rvNo" value="${vo.rvNo }">
	            </td>
	        </tr>
	    </tbody>
	</c:forEach>
		
		<tfoot id="page">
	        <tr>
	        	<td colspan="2">
					<ol class="paging">
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${rvPvo.nowPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${rvPvo.nowPage != 1 }">
						<li>
							<a href="reviewController?category=selectOne&cPage=${rvPvo.endPage - 1 }">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${rvPvo.beginPage }" end="${rvPvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == rvPvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="reviewController?category=selectOne&cPage=${pageNo }">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${rvPvo.nowPage < rvPvo.totalPage }">
						<li>
							<a href="reviewController?category=selectOne&cPage=${rvPvo.nowPage + 1 }">다음</a>
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