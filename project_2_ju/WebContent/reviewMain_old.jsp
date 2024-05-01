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
	//페이징 처리를 위한 객체(Paging) 생성
	Paging p = new Paging();

	//1. 전체 게시물 수량 구하기
	p.setTotalRecord(reviewDAO.getTotalCount());
	p.setTotalPage();
	
	System.out.println(">전체 게시글 수 : " + p.getTotalRecord());
	System.out.println(">전체 페이지 수 : " + p.getTotalPage());
	
	//2. 현재 페이지 번호 구하기
	String cPage = request.getParameter("cPage");
	if (cPage != null) {
		p.setNowPage(Integer.parseInt(cPage));
	}
	System.out.println("> cPage : " + cPage);
	System.out.println("> Paging nowPage : " + p.getNowPage());
	
	//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
	p.setEnd(p.getNowPage() * p.getNumPerPage());
	p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
	
	System.out.println(">> 시작번호(begin) : " + p.getBegin());
	System.out.println(">> 끝번호(end) : " + p.getEnd());
	
	//4. --- 블록(block) 계산하기 -----
	//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
	int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
	p.setNowBlock(nowBlock);
	p.setEndPage(nowBlock * p.getPagePerBlock());
	p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
	System.out.println(">> nowBlock : " + p.getNowBlock());
	System.out.println(">> beginPage : " + p.getBeginPage());
	System.out.println(">> endPage : " + p.getEndPage());
	
	// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
	// 끝페이지를 전체페이지 수로 변경 처리
	if (p.getEndPage() > p.getTotalPage()) {
		p.setEndPage(p.getTotalPage());
		System.out.println(">>정정 후 endPage : " + p.getEndPage());
	}
%>
<%
	//리뷰 전체(영화,회원) 목록
	List<listTotVO> listAll = listTotDAO.getList();
	try (SqlSession ss = DBService.getFactory().openSession()) {
		listAll = ss.selectList("listTotal.listAll");
	} catch (Exception e) {
		e.printStackTrace();
	}
	System.out.println(">> 리뷰 메인 listAll : " + listAll);
	
	pageContext.setAttribute("list", listAll);
	
	//페이징 처리 위한 리뷰 전체 목록
// 	List<reviewVO> list = reviewDAO.pList(p.getBegin(), p.getEnd());
// 	System.out.println(">> 현재페이지 글목록 : " + list);
	
// 	session.setAttribute("rvPvo", p);
// 	session.setAttribute("rvList", list);
	
	//추천수 +1
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
// 	function rec_push(frm) {
// 		location.href = "rvRec.jsp?rvNo=";
// 	}
	function warn_push() {
		location.href = "rvWarn.jsp";
		submit();
	}

</script>
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
	
	<!-- 리뷰 전체보기 -->
<form>
	<table>
	<c:forEach var="vo" items="${rvList}">
		<tbody id="reviewOne">
	        <tr>
	            <td>${vo.mvNo }-영화명으로 변경</td>
	            <td><a href="rvDetail.jsp?rvNo=${vo.rvNo }&cPage=${rvPvo.nowPage}">${vo.rvTitle }</a></td>
	        </tr>
	        <tr>
	            <td>${vo.rvNick }</td>
	            <td>${vo.rvDate }</td>
	        </tr>
	        <tr>
	            <td colspan="2">
<%-- 	            	<input type="button" value="추천" onclick="rec_push(this.form)">${vo.rvRec } --%>
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
					<c:if test="${rvPvo.beginPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${rvPvo.beginPage != 1 }">
						<li>
							<a href="reviewMain.jsp?cPage=${rvPvo.endPage - 1 }">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${rvPvo.beginPage }" end="${rvPvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == rvPvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="reveiwMain.jsp?cPage=${pageNo }">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${rvPvo.endPage < rvPvo.totalPage }">
						<li>
							<a href="reveiwMain.jsp?cPage=${rvPvo.endPage + 1 }">다음</a>
						</li> 
					</c:if>
					<c:if test="${rvPvo.endPage >= rvPvo.totalPage }">
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

