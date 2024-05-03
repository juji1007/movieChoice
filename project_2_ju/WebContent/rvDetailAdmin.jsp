<%@page import="com.mystudy.model.dao.warnDAO"%>
<%@page import="com.mystudy.model.dao.recDAO"%>
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
	
	String Adminid = (String) session.getAttribute("id");
	System.out.println(">> id : " + Adminid);
	//리뷰 전체(영화,회원) 목록 - mapper에서 3개 테이블 조인
	listTotVO listOne = listTotDAO.selectOne(rvNo);
	System.out.println(">> 리뷰 상세 listOne : " + listOne);
	
	session.setAttribute("listOne", listOne);
	session.setAttribute("cPage", cPage);
	
	int no = (Integer)session.getAttribute("no");
	pageContext.setAttribute("no", no);
	
	//추천수 sum 보여주기 계산
	int rvRec = recDAO.recSum(rvNo);
	System.out.println("rvRec : " + rvRec);
	
	listOne.setRvRec(rvRec);
	System.out.println("<추천수> listOne : " + listOne);
	
	//신고수 sum 보여주기 계산
	int rvWarn = warnDAO.warnSum(rvNo);
	System.out.println("rvwarn : " + rvWarn);
	
	listOne.setRvWarn(rvWarn);
	System.out.println("<신고수> listOne : " + listOne);
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
	
	//리뷰 삭제 확인 및 권한
	function delete_go(frm) {
		let isDelete = confirm("삭제하시겠습니까?");
		var adminId = "ju123";
		if(isDelete) {
			//회원번호 확인
			if(${no} == ${listOne.no} || adminId === "<%=Adminid %>") {
	 			location.href = "rvDelete.jsp?rvNo=${listOne.rvNo}&location=reviewAdmin";
				alert("삭제가 완료되었습니다.");
			} else {
				alert("삭제권한이 없습니다.");
			}
		}
		
	}
	
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/headerAdmin.jspf" %>
	
	<h2>리뷰 상세보기</h2>
	<form action="rvUpdate.jsp?rvNo=${listOne.rvNo }" method="post">
	<table>
		<tbody>
			<tr>
				<td rowspan="3"><img src="img/${listOne.mvPoster }" alt="포스터" width="300px"></td>
				<td id="rvTitle" colspan="3">${listOne.rvTitle }</td>
			</tr>
			<tr>
				<td id="rvNick">${listOne.rvNick }</td>
				<td id="rvDate">${listOne.rvDate }</td>
				<td id="btn">
					<input type="button" value="추천 수" >
					${listOne.rvRec }
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px"> 
					<input type="button" value="신고 수" >
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
					<input type="button" value="목록" onclick="javascript:location.href='reviewController?category=rvMain&location=admin&cPage=${cPage}'">
					<input type="button" value="다음" onclick="next_go()">
				</td>
				<td>
					<input type="button" value="삭제" onclick="delete_go(this.form)">
					
					<input type="hidden" name="listOne" value="${listOne}">
				</td>
			</tr>
		</tfoot>
	</table>
	</form>
	
	
</body>
</html>