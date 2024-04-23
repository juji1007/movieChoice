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
	List<postCommentVO> commList = postDAO.getCommList(psNo);
	System.out.println("댓글목록 commList : " + commList);
	
	pageContext.setAttribute("c_list", commList);//댓글목록
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
</head>
<body>
<table>
	<tr>
	<td colspan=3><h1>${pvo.psTitle }</h1></td>
	</tr>
	<tr>
	<td>작성자</td>
	<td>${pvo.psDate }</td>
	<td>추천수</td>
	</tr>
</table>
<hr>
<tr>
	<td colspan=3>${pvo.psContent }</td>
</tr>
	

<hr>
<!-- 댓글작성 -->
<form action="postComment_write_ok.jsp" method="post">
<!-- 로그인 후 댓글작성가능, 댓글작성한사람의 회원번호 받아와서 사용해야함 -->
		<input type="hidden" name="no" value="${pvo.no }">
		<textarea name="pcContent" rows="2" cols="55"></textarea>
		<input type="submit" value="댓글작성">
		<input type="hidden" name="psNo" value="${pvo.psNo }">
		<input type="hidden" name="cPage" value="${cPage }">
	</form>
	<hr>

<!-- 댓글표시 -->
<c:forEach var="commVO" items="${c_list }">
	<div>
		<form action="postComment_del.jsp" method="get">
			<p>작성자  ${commVO.pcDate }</p>
			<p>${commVO.pcContent }</p>
			<input type="submit" value="댓글삭제">
<%-- 			<input type="hidden" name="pcNo" value="${commVO.pcNo }"> --%>
		</form>
	</div>
	<hr>
	</c:forEach>
</body>
</html>