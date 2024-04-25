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
<%
	List<listTotVO> listAll = listTotDAO.getList();
	try (SqlSession ss = DBService.getFactory().openSession()) {
		listAll = ss.selectList("listTotal.listAll");
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println("listAll : " + listAll);
	
	pageContext.setAttribute("list", listAll);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 메인 페이지</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
	function recommand_push() {
		location.href = "rvRecommand.jsp";
		submit();
	}
	
	function warn_push() {
		location.href = "rvWarn.jsp";
		submit();
	}
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>

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
	
	<hr>
	<h2>
		리뷰모음
		<input type="button" value="등록하기" 
			onclick="javascript:location.href='rvWrite.jsp'">
	</h2>
	<!-- 리뷰 전체보기 -->
	<table border>
	<c:forEach var="vo" items="${list}">
		<tbody id="reviewOne">
	        <tr>
	            <td>${vo.mvTitle }</td>
	            <td><a href="rvDetail.jsp?rvNo=${vo.rvNo }">${vo.rvTitle }</a></td>
	        </tr>
	        <tr>
	            <td>${vo.rvNick }</td>
	            <td>${vo.rvDate }</td>
	        </tr>
	        <tr>
	            <td><input type="button" value="추천수" onclick="recommand_push()">${vo.rvRec }</td>
	            <td><input type="button" value="신고" onclick="warn_push()"></td>
	        </tr>
	    </tbody>
	</c:forEach>  
	    <tfoot id="page">
	        <tr>
	        	<td colspan="2">
					<ol class="paging">
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${pvo.beginPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${pvo.beginPage != 1 }">
						<li>
							<a href="reviewMain.jsp?cPage=${pvo.endPage - 1 }">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == pvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="reveiwMain.jsp?cPage=${pageNo }">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${pvo.endPage < pvo.totalPage }">
						<li>
							<a href="reveiwMain.jsp?cPage=${pvo.endPage + 1 }">다음</a>
						</li> 
					</c:if>
					<c:if test="${pvo.endPage >= pvo.totalPage }">
						<li class="disable">다음</li> 
					</c:if>
					</ol>
				</td>
	    	</tr>
	    </tfoot>
	</table>
	
</body>
</html>

