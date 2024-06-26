<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mystudy.model.vo.qnaVO"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
//페이징 처리를 위한 객체(Paging) 생성
Paging p = new Paging();

//1. 전체 게시물 수량 구하기
p.setTotalRecord(qnaDAO.getTotalCount());
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

//끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
//끝페이지를 전체페이지 수로 변경 처리
if (p.getEndPage() > p.getTotalPage()) {
	p.setEndPage(p.getTotalPage());
	System.out.println(">>정정후 endPage : " + p.getEndPage());
}
%>
<%

List<qnaVO> list = qnaDAO.getList(p.getBegin(), p.getEnd());
System.out.println(">> 현재페이지 글목록 : " + list);
%>
<%
//EL, JSTL 사용을 위해 scope에 데이터 등록(page영역)
//페이징처리객체 page 영역에 저장

session.setAttribute("pvo", p);
session.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의사항</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        //로그인 후 작성가능
        function login_confirm(frm) {
            <% if (session.getAttribute("no") == null) { %>
            alert("로그인 후 작성 가능합니다.");
            location.href = "login_page.jsp";
            <% } else { %>
            frm.submit();
            <% } %>
        }
    </script>

    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/free.css">

</head>
<body>
	<%@ include file="include/header.jspf" %>
	<div class="body">
	    <h2>QnA</h2>
	<div class="innerbox">
	<div class="content">
	    <form  action="qnaWrite.jsp" method="get">
	    	<input class="write" type="button" value="작성하기" onclick="login_confirm(this.form)">
	    </form>

		<hr class="color">
      	<div class="box">
     	<div class="innerbox">
    	<div class="content">

	    <form action="qnaController?search=qnaList" method="get">
	        <select class="select" name="idx">
				<option value="0">제목</option>
				<option value="1">작성일</option>
				<option value="2">영화추가</option>
				<option value="3">평론가탈퇴</option>
			</select> 
			<input class="search" type="text" name="keyword" placeholder="검색어 입력 (작성일 검색 ex: 20240507)"> 
			<input class="searchbtn" type="submit" value="검색"> 
	        <input type="hidden" name="search" value="qnaList">
	    </form>
	    </div>
      	</div>
     	</div>
	<div id="qna">
	<table border frame=void>
		<tr>
			<th>번호</th>
			<th>분류</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>제목</th>
		</tr>
		<c:forEach var="vo" items="${list }">
		<tr>
		<td width="5%">${vo.qaNo }</td>
		<td width="15%">${vo.qaCategory }</td> 
		<td width="15%">${vo.nick }</td>
		<td width="15%">${vo.qaDate }</td>
		<td>
		<a href="qnaView.jsp?qaNo=${vo.qaNo }&cPage=${pvo.nowPage}">
		${vo.qaTitle }
		</a>
		</td>
		</tr>
		</c:forEach>
	
		<tfoot>
				<tr>
					<td colspan="5">
						<ol class="paging">
						<%--[이전]에 대한 사용여부 처리 --%>
						<c:if test="${pvo.beginPage == 1 }">
							<li class="disable">이전</li> 
						</c:if>
						<c:if test="${pvo.beginPage != 1 }">
							<li>
								<a href="qna.jsp?cPage=${pvo.endPage - 1 }">이전</a>
							</li> 
						</c:if>
						
						<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
						<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
						<c:choose>
							<c:when test="${pageNo == pvo.nowPage }">
								<li class="now">${pageNo }</li>
							</c:when>
							<c:otherwise>
								<li><a href="qna.jsp?cPage=${pageNo }">${pageNo }</a></li>
							</c:otherwise>
						</c:choose>
						</c:forEach>
							
						<%--[다음]에 대한 사용여부 처리 --%>	
						<c:if test="${pvo.endPage < pvo.totalPage }">
							<li>
								<a href="qna.jsp?cPage=${pvo.endPage + 1 }">다음</a>
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
</div>
</div>
</body>
</html>