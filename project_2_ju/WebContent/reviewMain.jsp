<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.listMvRvVO"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 메인 페이지</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
	function recommand_push() {
		location.href = "rvRecommand.jsp";
		submit();
	}
	
	//AJAX controller 연결 - review 전체 조회
	$(document).ready(function(){
		console.log(">> reviewMain.jsp 접속 성공!!");
		
		
		$.ajax({
			type : "POST",
			url : "ajaxReviewController",
			data : {
				action: "reviewMain"
			},
			dataType: "json",
			//dataType : "html",
			success : function(respData){
			    console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
			    //Json데이터 처리
			    let str = null;
			    for (let member of respData.listRv) {
			        console.log("실행시;ㄹ행")
			        str += "<h2>" + member.rvNo + "</h2>"
			        str += "<h2>" + member.rvTitle + "</h2>"
			        str += "<h2>" + member.rvRec + "</h2>"
			    }
			    $("#reviewDiv").html(str);
			},

			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			},
			complete : function(){
				alert(":: complete 실행");
			}
		});
		
	}); 
	
	
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
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
	
	<h2>리뷰모음</h2>
	<hr>

	<h3>리뷰 목록</h3>
	<div id="reviewDiv">
		<h4>영화제목</h4>
		<h4>영화포스터</h4>
		<h4>리뷰번호</h4>
		<h4>리뷰제목</h4>
		<h4>리뷰추천수</h4>
	</div>

	
<%-- 	<c:forEach var="vo" items="${listMv }">
		<!-- <a href="reviewController?type=rvDetail"> -->
		<table id="reviewOne">
			<tbody>
				<tr>
					<td colspan=>영화명${mvVo.mvTitle }</td>
					<td id="rvDetail" colspan="2">
						<a href="reviewController?type=rvDetail&mvNo=${vo.mvNo }&rvNo=${vo.rvNo}">${vo.rvTitle }</a>
					</td>
				</tr>
				<tr>
					<td rowspan="2"><img src="img/kungfu.jpg" alt="포스터" width="150px"></td>
					<td>${vo.rvNick }</td>
					<td>${vo.rvDate }</td>
				</tr>
			</tbody>
			
			<tfoot id="tfoot">
				<tr>
					<td class="recNo" colspan="3">
						<input type="button" value="추천수 " onclick="reviewController?type=rvRecommand&rvNo=${vo.rvNo}&rvRec=${vo.rvRec}">
						<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px">
						${vo.rvRec }
					</td>
				</tr>
			</tfoot>
		</table>
	</c:forEach> 
--%>
	
</body>
</html>