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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
<%--영화검색 --%>
<form action="movieDetail.jsp?mvNo=${mvDetail.mvNo }">
<input type="text" name="mvNo" placeholder="영화제목을 입력하세요">
<input type="submit" value="영화검색">
</form>
<div>

<h3 class="top">현재 상영 영화 TOP10</h3>


<%-- select 해서 영화목록 상위 10개 가져오기 --%>
<div id="frame">
	<div id="banner">
	<c:forEach var="vo" items="${attr_list }">
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