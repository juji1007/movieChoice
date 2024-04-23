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
	
	int mvNo = Integer.parseInt(request.getParameter("mvNo"));
	System.out.println("mvNo : " + mvNo);
	movieVO mvo = movieDAO.searchOne(mvNo);
	System.out.println("mvo : " + mvo);
	
	pageContext.setAttribute("vo", mvo); 
	
	/* //영화 검색-주은
	movieVO vo = null;
	try (SqlSession ss = DBService.getFactory().openSession()) {
		vo =  ss.selectOne("PROJECT2.mvTitleDetail", mvNo);
	} catch (Exception e) {
		e.printStackTrace();
	} 
	System.out.println("vo : " + vo);
	session.setAttribute("mvDetail", vo); */
	
%>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${vo.mvTitle } 상세 정보</title>
    <style>
        img {
            max-width: 200px;
            height: auto;
        }
    </style>
</head>
<body>
    <img src="ui/title.png" alt="UiTitle">
    <hr>
    <div>
        <img src="poster/${vo.mvPoster }" alt="Kungfu Panda4 Poster">
    </div>
    <button onclick="location.href='writeReview.jsp'">리뷰 작성</button>
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
</body>
</html>








