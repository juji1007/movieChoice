<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
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
<input type="button" value="작성하기">
<form>
<input type="text">
<input type="submit" value="검색">
</form>
<table>
<tr>
<td>
</tr>
</table>
</body>
</html>