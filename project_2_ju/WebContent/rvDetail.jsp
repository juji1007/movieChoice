<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	System.out.println("rvNo : " + rvNo);
	
	reviewVO vo = reviewDAO.selectOne(rvNo);
	System.out.println("vo : " + vo);
	
	session.setAttribute("rvVo", vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지 [ rvDetail.jsp ]</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvDetail.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function prev_go() {
		
	}
	
	function list_go() {
		location.href = "reviewMain.jsp";
	}
	
	function next_go() {
		
	}
	
	function update_go(frm) {
		location.href = "rvUpdate.jsp?rvNo=${rvVo.rvNo}";
	}
	
	function delete_go(frm) {
		location.href = "rvDelete.jsp?rvNo=${rvVo.rvNo}";
		alert("삭제하시겠습니까?");
		
	}
	
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
	<h2>리뷰 상세보기</h2>
	<form>
	<table border>
		<tbody>
			<tr>
				<td rowspan="3"><img src="img/${mvOne.mvPoster }" alt="포스터" width="300px"></td>
				<td id="rvTitle" colspan="3">${rvVo.rvTitle }</td>
			</tr>
			<tr>
				<td id="rvNick">${rvVo.rvNick }</td>
				<td id="rvDate">${rvVo.rvDate }</td>
				<td id="btn">
					<input type="button" value="추천 " onclick="recommand_push()">
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px"> 
					<input type="button" value="신고" onclick="warn_push()">
					${rvVo.rvRec }
				</td>
			</tr>
			<tr>
				<td id="rvContent" colspan="3">${rvVo.rvContent }</td>
			</tr>
		</tbody>
	
		<tfoot class="tfoot">
			<tr>
				<td colspan="3">
					<input type="button" value="이전" onclick="prev_go()">
					<input type="button" value="목록" onclick="reviewMain.jsp">
					<input type="button" value="다음" onclick="next_go()">
				</td>
				<td>
					<input type="button" value="수정" onclick="update_go(this.form)">
					<input type="button" value="삭제" onclick="delete_go(this.form)">
					
					<input type="hidden" value="${rvVo}">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
	
	
</body>
</html>