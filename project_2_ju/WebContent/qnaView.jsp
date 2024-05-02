<%@page import="com.mystudy.model.dao.inquiryDAO"%>
<%@page import="com.mystudy.model.vo.inquiryVO"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
<%@page import="com.sun.nio.sctp.PeerAddressChangeNotification"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@page import="com.mystudy.model.vo.qnaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	int qaNo = Integer.parseInt(request.getParameter("qaNo"));
	System.out.println("qaNo : " + qaNo);
	String cPage = request.getParameter("cPage");
	
	qnaVO qvo = qnaDAO.selectOne(qaNo);
	System.out.println("게시글 qvo : " + qvo);
	session.setAttribute("qvo", qvo);
	session.setAttribute("cPage", cPage);
	
	inquiryVO ivo = inquiryDAO.ione(qaNo);
	System.out.println("게시글 ivo : " + ivo);
	session.setAttribute("ivo", ivo);
	
	session.getAttribute("no");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세</title>
<script>
	//목록보기
	function list_go() {
		location.href = "qna.jsp";
	}
	//로그인 후 작성가능
	function login_confirm(frm) {
<% 
	if (session.getAttribute("no") == null) {
%>
	alert("로그인 후 작성 가능합니다.");
	frm.location.href = "qnaView.jsp";
<%
	}
	else 
%>
	frm.submit();
}
	
//	게시물 삭제 확인 및 권한
	function qa_delete(frm) {
			let isDelete = confirm("삭제하시겠습니까?");
//	 	let isDelete = confirm(${no});
		if(isDelete) {
				if(${no} == ${qvo.no}) {
				frm.submit();
				}
				else {
				alert("삭제권한이 없습니다");
//	 			history.back();
				}
		
		}
	}
	// 게시물 수정 권한
	function qa_update(frm) {
		if(${no} == ${qvo.no}) {
			frm.submit();
		}else {
			alert("수정권한이 없습니다.")
		}
	}

</script>
</head>
<body>

	<table>
		<tr>
			<td colspan=3><h2>QnA 번호 : ${qvo.qaNo }</h2></td>
		</tr>
		<tr>
			<td>아이디 : ${qvo.id }</td>
		</tr>
		<tr>
			<td>내용 : ${qvo.qaContent }</td>
		</tr>
		<tr>
			<td>${qvo.qaDate }</td>
		</tr>
		<tr>
			<td>
				<form action="qnaDeleteOk.jsp?qaNo=${qvo.qaNo }" method="post">
						<input class="h_button" type="button" value="삭제" onclick="qa_delete(this.form)">
						<input type="hidden" name="qaNo" value="${qvo.qaNo }">
				</form>
			</td>
			<td>
				<form action="qnaUpdate.jsp" method="get">
					<input type="button" value="수정" onclick="qa_update(this.form)">
					<input type="hidden" name="qaNo" value="${qvo.qaNo }">
				</form>
			</td>
			<td>
				<input type="button" value="목록보기" onclick="list_go()">
			</td>
		</tr>
	</table>
	<h2>QnA ${qvo.qaNo }번에 대한 관리자 답변</h2>
  	<hr>
  	<p>${ivo.iqContent }</p> 
</body>
</html>