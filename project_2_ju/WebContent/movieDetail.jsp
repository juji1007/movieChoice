<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="org.apache.ibatis.javassist.bytecode.stackmap.BasicBlock.Catch"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.model.dao.recDAO"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.project.review.paging.Paging"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
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

	.genre-orange, .genre-blue, .genre-green, .genre-red {
        display: inline-block;
        padding: 5px 5px; 
        margin-right: 1px; 
        width: fit-content;
        height: 50px;
        line-height: 20px; 
        border-radius: 10px; 
        color: white;
    }
	
    .genre-orange {
	    background-color: orange;
	}
	
	.genre-blue {
	    background-color: blue;
	}
	
	.genre-green {
	    background-color: green;
	}
	
	.genre-red {
	    background-color: red;
	}
</style>

    <style>
        a:hover {
			color:#56BEC0;
		} 
    </style>
<link rel="stylesheet" href="css/free.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">

</head>
<body>
<%@ include file="include/header.jspf" %>
<div class="body">
<h2>${vo.mvTitle } 정보</h2>
<hr class="color">
    <div style="display: flex;">
	    <img src="img/${vo.mvPoster}" width="400" height="300" style="width: 30%; height: auto;">
	    <div style="width: 70%; margin-left: 20px;">
	        <form action="writeReview.jsp?movie=${vo.mvNo}" method="post">
	            <input class="write" type="button" value="리뷰 작성" onclick="login_confirm(this.form)">
	        </form>
	        <div>
	            <h2>${vo.mvTitle}</h2>
	            <p><strong>감독:</strong> ${vo.mvDirect}</p>
	            <c:choose>
	                <c:when test="${vo.mvGrade eq '15세이상관람가'}">
	                    <div class="genre-orange">
	                        <p>${vo.mvGrade}</p>
	                    </div>
	                </c:when>
	                <c:when test="${vo.mvGrade eq '12세이상관람가'}">
	                    <div class="genre-blue">
	                        <p>${vo.mvGrade}</p>
	                    </div>
	                </c:when>
	                <c:when test="${vo.mvGrade eq '전체관람가'}">
	                    <div class="genre-green">
	                        <p>${vo.mvGrade}</p>
	                    </div>
	                </c:when>
	                <c:when test="${vo.mvGrade eq '청소년관람불가'}">
	                    <div class="genre-red">
	                        <p>${vo.mvGrade}</p>
	                    </div>
	                </c:when>
	            </c:choose>
	            <p><strong>장르:</strong> ${vo.mvGenre}</p>
	            <p><strong>평점:</strong> ${vo.mvRate}</p>
	            <p><strong>개봉년도:</strong> ${vo.mvDate}</p>
	            <p><strong>출연:</strong> ${vo.mvActor}</p>
	            <p><strong>누적관객:</strong> ${vo.mvAudience}</p>
	        </div>
	    </div>
	</div>
  <h2>${vo.mvTitle } 리뷰</h2>
  <hr class="color">
  <c:forEach var="mvo" items="${mvoList}">
		<p><strong>${mvo.rvNick }</strong> | <a href="rvDetail.jsp?rvNo=${mvo.rvNo }&cPage=1">${mvo.rvTitle }</a></p>
<%-- 		<p>${mvo.rvTitle }</p> --%>
		<p>${mvo.rvContent }</p>
		<p>${mvo.rvDate }</p>
		<br>
	</c:forEach>

</div>
</body>
</html>







