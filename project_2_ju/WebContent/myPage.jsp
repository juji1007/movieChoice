<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
	request.setCharacterEncoding("UTF-8");

	//account
	
	
	//movie 추천이네 이런거
	
	//review 추천 + 내가쓴거
	
	//post 추천 + 내가쓴거
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
table {
/* 	position: absolute; */
	top: 50%;
	left: 60%;
  	transform: translate(200px, -10px);  
  	margin-top: 10%;
  	margin-right: 15%;
	width: 80%;
	max-height: 400px;
	overflow-y: auto;
	border-collapse: collapse;
	border: 1px solid black;
}

.body {
	position: relative;
	padding-top: 200px;
}

caption {
	margin-bottom: 50px;
}

th, td {
    border: 1px solid black; /* 테이블 경계선 설정 */
    padding: 8px; /* 셀 안의 여백 설정 */
    text-align: center; /* 가운데 정렬 */
}


select, thead input[type="text"], thead input[type="submit"] {
	margin-right: 10px;
}

th tr td{
	display: flex;
	align-items: center;
	border: none; 
	border: 1px solid black; 
	
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	function updateAccount(frm) {
		console.log("회원정보수정실행");
		console.log(frm);
		frm.action="loginController?type=updateAccount";
// 		frm.action="mainAdmin.jsp";
		frm.submit();
	}
	window.onload = function() {
		getAccountInfo();
		
	};
	
	function getAccountInfo() {
		
		$.ajax({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "accountMypage"
			},
			dataType: "json",
			 success: function(respData) {
	            console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
	            
	            let htmltag = "";
	       	    // 데이터 처리
	            if (respData.length === 0) {
	                // 검색 결과가 없을 때
	                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	            } else {
	                // 검색 결과가 있을 때
	                for (let member of respData.listSearch) {
	                	 if (member.table === "account") {
	 			            console.log("유저html");
	 			            htmltag += "<tr><th>회원번호</th><td>" + member.no + "</td></tr>";
	 			            htmltag += "<tr><th>이름</th><td>" + member.name + "</td></tr>";
	 			            htmltag += "<tr><th>아이디</th><td>" + member.id + "</td></tr>";
	 			            htmltag += "<tr><th>닉네임</th><td>" + member.nick + "</td></tr>";
	 			            htmltag += "<tr><th>평론가 구분</th><td>" + member.criticCheck + "</td></tr>";
	 			            htmltag += "<tr><th>이메일</th><td>" + member.email + "</td></tr>";
	 			            htmltag += "<tr><th>신고 수</th><td>" + member.warn + "</td></tr>"; 
// 	 			            htmltag += "<tr><td colspan='2'><input type='button' value='삭제' onclick='deleteAccount(this.form, account)'>";
// 	 			            htmltag += "<input type='button' value='수정' onclick='updateAccount()'></td>";
	 			            htmltag += "</tr>";
	 			        }
	                }
	            }
	       	    
	            $('#accountThead').html(htmltag);
		            
	            	let footerHtml = "";
	            	
	            	footerHtml = "<tr><td colspan='2'><input type='button' value='수정' onclick='updateAccount(this.form)'></td></tr>";
	            	 $('#accountTbody').html(footerHtml);
			 },
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert("Ajax 처리 실패:\n" +
		                "jqXHR.readyState: " + jqXHR.readyState + "\n" +
		                "textStatus: " + textStatus + "\n" +
		                "errorThrown: " + errorThrown);
		        }

		});
	}
</script>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>

<!-- 회원정보조회 
	 회원정보수정
	 회원탈퇴
-->
<div class="infoPage">
<div id="frame">
	<form method="post">
		<table id="accountTable">
			<caption>나의 회원정보</caption>
			<thead id="accountThead">
				<tr>
					<th>이름</th>
					<td>검색결과가없습니다</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td></td>
				</tr>
				<tr>
					<th>평론가 구분</th>
					<td></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td></td>
				</tr>
				<tr>
					<th>신고 수</th>
					<td></td>
				</tr>
			</thead>
			<tbody id="accountTbody">
				<tr>
					<td><input type='button' value='회원정보삭제' onclick='delete(this.form, review)'></td>
					<td><input type='button' value='회원정보수정' onclick='updateReview(this.form)'></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<hr>
<div id="frame">
	<table id="movieTable">
		<caption>나의 영화정보</caption>
		<thead id="accountThead">
			<tr>
				<th>이름</th>
				<td></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td></td>
			</tr>
			<tr>
				<th>평론가 구분</th>
				<td></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td></td>
			</tr>
			<tr>
				<th>신고 수</th>
				<td></td>
			</tr>
		</thead>
	</table>
</div>
<hr>
<div id="frame">
	<table id="accountTable">
		<caption>나의 회원정보</caption>
		<thead id="accountThead">
			<tr>
				<th>이름</th>
				<td></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td></td>
			</tr>
			<tr>
				<th>평론가 구분</th>
				<td></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td></td>
			</tr>
			<tr>
				<th>신고 수</th>
				<td></td>
			</tr>
		</thead>
	</table>
</div>
<hr>
<div id="frame">
	<table id="accountTable">
		<caption>나의 회원정보</caption>
		<thead id="accountThead">
			<tr>
				<th>이름</th>
				<td></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td></td>
			</tr>
			<tr>
				<th>평론가 구분</th>
				<td></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td></td>
			</tr>
			<tr>
				<th>신고 수</th>
				<td></td>
			</tr>
		</thead>
	</table>
</div>
</div>
</body>
</html>