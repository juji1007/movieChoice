<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	System.out.println("rvNo : " + rvNo);
	
	int cPage = Integer.parseInt(request.getParameter("cPage"));
	System.out.println("cPage : " + cPage);
	
	//리뷰 전체(영화,회원) 목록 - mapper에서 3개 테이블 조인
	listTotVO listOne = listTotDAO.selectOne(rvNo);
	System.out.println(">> 리뷰 상세 listOne : " + listOne);
	
	session.setAttribute("listOne", listOne);
	session.setAttribute("cPage", cPage);
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

	
	function next_go() {
		
	}
	
	function update_go(frm) {
		location.href = "rvUpdate.jsp?rvNo=${listOne.rvNo}";
		//조건 작성 - 아이디 확인 후
	}
	
	function delete_go(frm) {
 		location.href = "rvDelete.jsp?rvNo=${listOne.rvNo}";
		alert("삭제하시겠습니까?");
		//조건 작성 - 아이디 확인
		
	}
	
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
	<h2>리뷰 상세보기</h2>
	<form action="rvUpdate.jsp?rvNo=${listOne.rvNo }" method="post">
	<table border>
		<tbody>
			<tr>
				<td rowspan="3"><img src="img/${listOne.mvPoster }" alt="포스터" width="300px"></td>
				<td id="rvTitle" colspan="3">${listOne.rvTitle }</td>
			</tr>
			<tr>
				<td id="rvNick">${listOne.rvNick }</td>
				<td id="rvDate">${listOne.rvDate }</td>
				<td id="btn">
					<input type="button" value="추천 " onclick="recommand_push()">
					${listOne.rvRec }
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px"> 
					<input type="button" value="신고" onclick="warn_push()">
					${listOne.rvWarn }
				</td>
			</tr>
			<tr>
				<td id="rvContent" colspan="3">${listOne.rvContent }</td>
			</tr>
		</tbody>
	
		<tfoot class="tfoot">
			<tr>
				<td colspan="3">
					<input type="button" value="이전" onclick="prev_go()">
					<input type="button" value="목록" onclick="javascript:location.href='reviewController?category=rvMain&cPage=${cPage}'">
					<input type="button" value="다음" onclick="next_go()">
				</td>
				<td>
					<input type="button" value="수정" onclick="update_go(this.form)">
					<input type="button" value="삭제" onclick="delete_go(this.form)">
					
					<input type="hidden" name="listOne" value="${listOne}">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
	
	
</body>
</html>