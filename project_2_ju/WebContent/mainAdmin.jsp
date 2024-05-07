<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
//영화 탑텐 불러오기
List<movieVO> top = null;
try (SqlSession ss = DBService.getFactory().openSession()) {
	top =  ss.selectList("PROJECT2.mvTop");
} catch (Exception e) {
	e.printStackTrace(); 
}  
System.out.println("top : " + top);
System.out.println("top.size : " + top.size());
session.setAttribute("top", top);

//영화 전체 목록 불러오기
List<movieVO> list = null; 
try (SqlSession ss = DBService.getFactory().openSession()) {
	list =  ss.selectList("PROJECT2.mvTitle");
} catch (Exception e) {
	e.printStackTrace(); 
}  
System.out.println("list : " + list);
System.out.println("list.size : " + list.size());
session.setAttribute("attr_list", list);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainAdmin</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/mheader.css">
<link rel="stylesheet" href="css/main.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>


<script>
	$(document).ready(function(){
    let $list = $("#banner");
    console.log(":: 이미지 갯수 : " + $("#banner img").length);
 // 앞의 이미지 5개를 복사(clone)해서 맨뒤에 붙이기
    $list.append($("#banner table:lt(5)").clone());
    console.log(":: 이미지 갯수 : " + $("#banner img").length);
  //next : 좌측 마진 값에서 -200 처리
    let clickCnt = 0;
    $("#next").click(function(){
        $list.stop(true); //기존 애니메이션 있으면 중지(큐삭제)
        clickCnt++;
        if (clickCnt > 2) {
            $list.css("margin-left", "0px");
            clickCnt = 1;
        }
        let marginLeft = -1130 * clickCnt;
        $list.animate({"margin-left" : marginLeft}, 300);
    });
	});
</script>
<body>
	<%@ include file="include/headerAdmin.jspf" %>
<div class="body">
 
		<nav>
			<%--영화추가 --%>
			<div id="movieInsertArea">
				<input class="commitbtn" type="button" value="영화추가"
					onclick="location.href='movieInsert.jsp'">
			</div>
		</nav>
<div>

<h2 class="top">현재 상영 영화 TOP10</h2>


<%-- select 해서 영화목록 상위 10개 가져오기 --%>
<div id="frame">
	<div id="banner">
	<c:forEach var="vo" items="${top }">
	<table>
			<tr>
			<td>
			<img src="img/${vo.mvPoster }" alt="제품이미지" width="200">
			</td>
			</tr>
			<tr>
			<td >${vo.mvTitle }</td>
			</tr>
	</table>
	</c:forEach>
	
	</div>
</div>
<a href="#" id="next">
<button id="next" class="button button--shikoba button--round-s button--border-thin"><i class="button__icon icon icon-next"></i><span>></span></button>
</a>
</div>
<br>

<div>
<h2>영화목록</h2> 
<form action="controller?type=movieAdmin" method="post">
<!-- <form action="main2.jsp" method="get"> -->
<div class="right">
  <select class="select" name="idx">
  <option value="0" disabled selected>정렬</option>
    <option value="1" >최신순</option>
    <option value="2"  >평점순</option>
  </select>
  <input class="searchbtn" type="submit" value="동적검색">
<input type="hidden" name="type" value="movie">
</div>
</form>
<hr class="gray">
<!-- 영화 목록 보기 -->
<c:forEach var="vo" items="${attr_list }">
	<table>
			<tr>
			<td>
			<img src="img/${vo.mvPoster }" alt="제품이미지" width="200">
			</td>
			</tr>
			<tr>
			<td >${vo.mvTitle }</td>
			</tr>
			<tr>
			<td>

			<input class="h_button" type="button" value="삭제" onclick="location.href='controller?type=movieDelete&location=mainAdmin&mvNo=${vo.mvNo }'">

			<input class="up_button" type="button" value="수정" onclick="location.href='controller?type=movieFix&location=mainAdmin&mvNo=${vo.mvNo }'">
			<input type="hidden" name="mvNo" value="${vo.mvNo }">
			</td>
			</tr>
	</table>
	</c:forEach>

</div>
</div>
</body>
</html>