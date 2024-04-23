<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
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
<title>main</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">
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
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>


<%--영화검색 --%>
<form action="controller?type=mvTitleList" method="post">
<input type="text" name="mvTitle" placeholder="영화제목을 입력하세요">
<input type="submit" value="영화검색">
</form>
<div>

<h3 class="top">현재 상영 영화 TOP10</h3>


<%-- select 해서 영화목록 상위 10개 가져오기 --%>
<div id="frame">
	<div id="banner">
	<c:forEach var="vo" items="${attr_list }">
	<a href="mvDetail.jsp">
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
	</a>
	</c:forEach>
	
	</div>
</div>
<a href="#" id="next">
<button id="next">></button>
</a>
</div>
<br>

<div>
<h2>영화목록</h2> 
<form action="controller?type=movie" method="post">
  <select name="idx">
  <option value="0" disabled selected>정렬</option>
    <option value="1" >최신순</option>
    <option value="2"  >평점순</option>
  </select>
  <input type="submit" value="동적검색">
</form>
<hr class="gray">
<c:forEach var="vo" items="${list2 }">
<a href="movieDetail.jsp?mvNo=${vo.mvNo }">
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
</a>
</c:forEach>

</div>
</body>
</html>