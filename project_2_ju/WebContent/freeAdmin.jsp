<%@page import="com.project.vo.AccountVO"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	//페이징 처리를 위한 객체(Paging) 생성
	Paging p = new Paging();

	//1. 전체 게시물 수량 구하기
	p.setTotalRecord(postDAO.getTotalCount());
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
		System.out.println(">>정정후 endPage : " + p.getEndPage());
	}
%>
<%
	
	List<postVO> list = postDAO.getList(p.getBegin(), p.getEnd());
	System.out.println(">> 현재페이지 글목록 : " + list);
%>
<%
	//EL, JSTL 사용을 위해 scope에 데이터 등록(page영역)
	// 페이징처리객체 page 영역에 저장
	
	session.setAttribute("pvo", p);
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

img.icon {
	position: absolute;
	left: 200px;
	top: 60px;
	}
	li {
 	 float: left;
   	 display: block;
	  padding: 10px 26px;
	 font-size: 18px;
	}

	a {
		text-decoration: none;
		color: black;
	}
	ul.menu {
		position: absolute;
		list-style-type: none;
		margin: 0;
		padding: 0;
		top: 60px;
		left: 530px;
	}
	li a:hover {
	 	color: #56BEC0;
	 	font-weight: bold;
	}
	hr.mint {
		background-color: #56BEC0;
		height: 3px;
		margin-top: 120px;
	}
	ul.login {
		position: absolute;
		list-style-type: none;
		margin: 0;
		padding: 0;
		top: 60px;
		right: 200px;
	}
	ul.login li {
		 padding: 12px 5px;
		 font-size: 14px;
	}
	hr.gray {
		background-color: D9D9D9;
		height: 1px;
	}
	#banner {width: 5000px;}
	 #frame {
        width: 1130px;
        position: relative;
        overflow: hidden;
    }
    table {
    	float: left;
    	margin: 10px;
    }
</style>
<body>
<div class="header">
<img class= "icon" src="img/moviechoice.png">

<ul class="menu">
  <li><a href="main.jsp">영화목록</a></li>
  <li><a href="reviewMain.jsp">리뷰모음</a></li>
  <li><a href="free.jsp">자유게시판</a></li>
  <li><a href="about.asp">Q & A</a></li>
  <li><a href="about.asp">Review Of The Month</a></li>
  <li><a href="about.asp">평론가</a></li>
  <li><a href="about.asp">마이페이지</a></li>
</ul>
<ul class="login">
 <li><a href="login_page.jsp">로그인</a></li>
 <li>/</li>
  <li><a href="memberJoin.jsp">회원가입</a></li>
  </ul>
<hr class="mint">
</div>
<h2>자유게시판</h2>
<a href="postWrite.jsp"><input type="button" value="작성하기"></a>


<form action="postController?search=freeList" method="get">
	<select name="idx">
		<option selected disabled>::선택</option>
		<option value="0">제목</option>
		<option value="1">작성일</option>
	</select>
<input type="text" name="keyword">
<input type="submit" value="검색">
<input type="hidden" name="search" value="freeList">
</form>


<div id="post">
<table border>
<c:forEach var="vo" items="${vo }">
<tr>
<td>${vo.nick }</td>
</tr>
</c:forEach>
<c:forEach var="vo" items="${list }">
<tr>
<td>${vo.psNo }</td>
<td>${vo.psDate }</td>
<td>
<a href="freeView.jsp?psNo=${vo.psNo }&cPage=${pvo.nowPage}">
${vo.psTitle }
</a>
</td>
</tr>
</c:forEach>

<tfoot>
			<tr>
				<td colspan="4">
					<ol class="paging">
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${pvo.beginPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${pvo.beginPage != 1 }">
						<li>
							<a href="free.jsp?cPage=${pvo.endPage - 1 }">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == pvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="free.jsp?cPage=${pageNo }">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${pvo.endPage < pvo.totalPage }">
						<li>
							<a href="free.jsp?cPage=${pvo.endPage + 1 }">다음</a>
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
</body>
</html>