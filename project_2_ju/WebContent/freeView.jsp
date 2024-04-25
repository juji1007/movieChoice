<%@page import="com.sun.nio.sctp.PeerAddressChangeNotification"%>
<%@page import="com.mystudy.model.vo.postCommentVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	int psNo = Integer.parseInt(request.getParameter("psNo"));
// 	int pcNo = Integer.parseInt(request.getParameter("pcNo"));
// 	int no = Integer.parseInt(request.getParameter("no"));
	String cPage = request.getParameter("cPage");
	
	postVO pvo = postDAO.selectOne(psNo);
	System.out.println("게시글 pvo : " + pvo);
	
	session.setAttribute("pvo", pvo);
	session.setAttribute("cPage", cPage);
	
	// 게시물 댓글
	session.getAttribute("no");
	session.getAttribute("nick");
	
	List<postCommentVO> commList = postDAO.getCommList(psNo);
	System.out.println("댓글목록 commList : " + commList);
	
	session.setAttribute("c_list", commList);//댓글목록
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
<script>

// 댓글 삭제 확인
	function pc_delete(frm) {
		let isDelete = confirm("삭제하시겠습니까?");
		if(isDelete) {
			frm.submit();
		} else {
			history.back();
		}
	}
	//목록보기
	function list_go() {
		location.href = "free.jsp";
	}
	//로그인 후 작성가능
	function login_confirm(frm) {
<% 
	if (session.getAttribute("no") == null) {
%>
	alert("로그인 후 작성 가능합니다.");
	frm.location.href = "freeView.jsp";
<%
	}
	else 
%>
	frm.submit();
}
</script>
</head>
<body>
<table>
	<tr>
	<td colspan=3><h1>${pvo.psTitle }</h1></td>
	</tr>
	<tr>
	<td>${nick }</td>
	<td>${pvo.psDate }</td>
	
	
	<td>
	<a href = "postUpdate.jsp"><input type="button" value="수정"></a>
	<input type="button" value="목록보기" onclick="list_go()">
	</td>
	</tr>
	
	
</table>

<hr>
<tr>
	<td colspan=3>${pvo.psContent }</td>
</tr>
<tr>
<td>
	<c:if test="${empty pvo.psFile }">
		첨부파일없음
		</c:if>
		<a href="#">${pvo.psFile }</a>
	
	</td>
</tr>

<hr>
<!-- 댓글작성 -->
<form action="postComment_write_ok.jsp" method="post">
		<input type="hidden" name="no" value="${no }">
		<textarea name="pcContent" rows="2" cols="55"></textarea>
		<input type="button" value="댓글작성" onclick="login_confirm(this.form)">
		<input type="hidden" name="psNo" value="${pvo.psNo }">
		<input type="hidden" name="cPage" value="${cPage }">
	</form>
	<hr>

<!-- 댓글표시 -->
<c:forEach var="commVO" items="${c_list }">
	<div>
		<form action="postComment_del_ok.jsp" method="get">
			<p>${nick}  ${commVO.pcDate }</p>
			<p>${commVO.pcContent }</p>
			<input type="button" value="댓글삭제" onclick="pc_delete(this.form)">
			<input type="hidden" name="pcNo" value="${commVO.pcNo }">
		</form>
	</div>
	<hr>
	</c:forEach>
</body>
</html>