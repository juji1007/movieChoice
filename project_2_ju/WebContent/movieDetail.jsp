<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="org.apache.ibatis.javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//request.setCharacterEncoding("UTF-8");
	String mvTitle = request.getParameter("mvTitle");
	int mvNo = Integer.parseInt(request.getParameter("mvNo"));
	System.out.println("mvNo : " + mvNo);
	movieVO mvo = movieDAO.searchOne(mvNo);
	System.out.println("mvo : " + mvo);
	
	pageContext.setAttribute("vo", mvo); 
	
	//영화 검색-주은
// 		movieVO vo = movieDAO.getmvTitleList(mvTitle);
// 		System.out.println("vo : " + vo);
// 		session.setAttribute("mvDetail", vo); 
		
	//영화 번호로 리뷰 검색-건희
	List<listTotVO> mvoList = null; 
		try (SqlSession ss = DBService.getFactory().openSession()) {
			mvoList = ss.selectList("movie.rone", mvNo);
		} catch (Exception e) {
		    e.printStackTrace();
		}
		System.out.println("mvoList : " + mvoList);
		request.setAttribute("mvoList", mvoList);
	
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.mvTitle } 상세 정보</title>
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
    <style>
        img {
            max-width: 200px;
            height: auto;
        }
        a:hover {
			color:#56BEC0;
		} 
    </style>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">

</head>
<body>
<%@ include file="include/header.jspf" %>
<div class="body">
    <div class="container">
        <img src="img/${vo.mvPoster }"  width="400" height="400" style="width: 100%; height: auto;">
    </div>
    	<form  action="writeReview.jsp?movie=${vo.mvNo }" method="post">
	    	<input class="write" type="button" value="리뷰 작성" onclick="login_confirm(this.form)">
	    </form>
	<div>	
			<h2>${vo.mvTitle }</h2>
			 <p><strong>감독:</strong> ${vo.mvDirect }</p>
			 <p><strong>등급:</strong> ${vo.mvGrade }</p> 
			 <p><strong>장르:</strong> ${vo.mvGenre }</p>
			 <p><strong>평점:</strong> ${vo.mvRate }</p>
			 <p><strong>개봉년도:</strong> ${vo.mvDate }</p>
			 <p><strong>출연:</strong> ${vo.mvActor }</p>
			 <p><strong>누적관객:</strong> ${vo.mvAudience }</p> 
  </div>
  <h2>${vo.mvTitle } 리뷰</h2>
  <hr>
  <c:forEach var="mvo" items="${mvoList}">
		<p>${mvo.rvNick }</p>
		<p><a href="rvDetail.jsp?rvNo=${mvo.rvNo }&cPage=1">${mvo.rvTitle }</a></p>
<%-- 		<p>${mvo.rvTitle }</p> --%>
		<p>${mvo.rvContent }</p>
		<p>${mvo.rvDate }</p>
		<hr>
	</c:forEach>

</div>
</body>
</html>







