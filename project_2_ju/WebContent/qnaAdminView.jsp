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
<title>QnA 관리자 상세</title>
<script>
	
	//	QnA 삭제 확인
	function qa_delete(frm) {
		let qaDelete = confirm("삭제하시겠습니까?");
		if(qaDelete) {
			frm.submit();
		} else{
		}
	}
	
	// INQUIRY 삭제 확인
	function iq_delete(frm) {
		let iqDelete = confirm("삭제하시겠습니까?");
		if(iqDelete) {
			frm.submit();
		} else{
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
			<td>닉네임 : ${qvo.nick }</td>
		</tr>
		<tr>
			<td>내용 : ${qvo.qaContent }</td>
		</tr>
		<tr>
			<td>${qvo.qaDate }</td>
		</tr>
		<tr>
			<td>
				<form action="qnaAdminDeleteOk.jsp?qaNo=${qvo.qaNo }" method="post">
						<input class="h_button" type="button" value="삭제" onclick="qa_delete(this.form)">
						<input type="hidden" name="qaNo" value="${qvo.qaNo }">
				</form>
			</td>
			<td>
				<input type="button" value="목록보기" onclick="location.href = 'qna.jsp'">
			</td>
		</tr>
	</table>
	<h2>QnA ${qvo.qaNo }번에 대한 관리자 답변</h2>
	<input class="write" type="button" value="답변달기" onclick="location.href = 'inquiryWrite.jsp?qaNo=${qvo.qaNo }'">
  	<hr>
  	<p>${ivo.iqContent }</p> 
  	<div>
  		<form action="inquiryAdminDeleteOk.jsp?iqNo=${ivo.iqNo }" method="post">
				<input class="h_button" type="button" value="삭제" onclick="iq_delete(this.form)">
				<input type="hidden" name="iqNo" value="${ivo.iqNo }">
		</form>
  	</div>
</body>
</html>