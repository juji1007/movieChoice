<%@page import="com.mystudy.model.dao.warnDAO"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
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
//  	int pcNo = Integer.parseInt(request.getParameter("pcNo"));
// 	int no = (int)session.getAttribute("no");
	
	String cPage = request.getParameter("cPage");
	
	postVO pvo = postDAO.selectOne(psNo);
	System.out.println("게시글 pvo : " + pvo);
	
	//신고수 sum 보여주기 계산
	int psWarn = warnDAO.warnSumBypsNo(psNo);
	System.out.println("psWarn : " + psWarn);
	
	pvo.setPsWarn(psWarn);
	System.out.println("<신고 계산> pvo : " + pvo);
	
	//로그인 회원NO, psNo의 신고 여부 확인
	int no = (Integer)session.getAttribute("no");
	pageContext.setAttribute("no", no);
	int warnNum = warnDAO.warnSearchPost(no, psNo);
	System.out.println("warnNum : " + warnNum);
	pageContext.setAttribute("warnNum", warnNum);
	
	session.setAttribute("pvo", pvo);
	session.setAttribute("cPage", cPage);
	
	// 게시물 댓글
	session.getAttribute("no");
	session.getAttribute("nick");
	List<postCommentVO> commList = postDAO.getCommList(psNo);
	System.out.println("댓글목록 commList : " + commList);
	session.setAttribute("c_list", commList);//댓글목록
// 	System.out.println("댓글작성자번호 : " + commList.get(0).getNo());
	
	session.getAttribute("coo");


%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<script>

//   게시물 삭제 확인 및 권한
function ps_delete(frm) {
      let isDelete = confirm("삭제하시겠습니까?");
//    let isDelete = confirm(${no});
   if(isDelete) {
         if(${no} == ${pvo.no}) {
         frm.submit();
         alert("삭제가 완료되었습니다.")
         }
         else {
         alert("삭제권한이 없습니다");
//          history.back();
         }
   
   }
}
// 게시물 수정 권한
function ps_update(frm) {
   if(${no} == ${pvo.no}) {
      frm.submit();
   }else {
      alert("수정권한이 없습니다.")
   }
}

// 댓글 삭제 확인

	function pc_delete(frm, commNo) {
		let isDelete = confirm("삭제하시겠습니까?");
// 		alert(commNo);
		if(isDelete) {
			if(${no} == commNo) {
			frm.submit();
			alert("삭제가 완료되었습니다.")
			}
			else {
			alert("삭제권한이 없습니다");
// 			history.back();
			}
	
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
	
	//신고 버튼(toggle 기능 - 한번 클릭 추천, 한번 더 클릭 해제)
	//게시물 신고버튼
	function warn_push(frm, warnNum) {
		//본인 리뷰가 아닌지 확인
		if (${no} != ${pvo.no}) {
			//신고 클릭시, rvWarn.jsp에서 신고 추가(+1)
			if (warnNum == 0) {
// 				alert("-" + warnNum + "-");
				alert("신고했습니다.");
			//해제(-1) 처리
			} else {
// 				alert("-" + warnNum + "-");
				alert("신고를 취소합니다.");
			}
			location.href= "psWarn.jsp?psNo=${pvo.psNo}";
		} else if (${no} == 13) {
			alert("관리자 계정입니다.");
		} else {
			alert("본인 리뷰는 신고할 수 없습니다.");
		}
	}

</script>
</head>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/freeView.css">
<body>
<%@ include file="include/header.jspf" %>
<div class="body">
<table frame="void">
<!-- <table border> -->
	<tr>
	<td colspan=7><h1>${pvo.psTitle }</h1></td>
	</tr>
	<tr>
	<td width="20%">작성자 | ${pvo.psNick }</td>
<%-- 	<td>${pvo.no }</td> --%>
	<td width="20%">작성일 | ${pvo.psDate }</td>
	<td>
	<input class="up_button" type="button" value="신고"
		data-warn-num="${warnNum}" 
		onclick="warn_push(this.form, this.dataset.warnNum)"> ${pvo.psWarn }
	</td>
	<td>
	<form action="postUpdate.jsp" method="get">
		<input class="up_button"  type="button" value="수정" onclick="ps_update(this.form)">
		<input type="hidden" name="psNo" value="${pvo.psNo }">
		<input type="hidden" name="no" value="${vo.no }">
	</form>
	</td>
	<td>
	<form action="postDelete.jsp" method="get">
		<input class="h_button" type="button" value="삭제" onclick="ps_delete(this.form)">
		<input type="hidden" name="psNo" value="${pvo.psNo }">
		<input type="hidden" name="no" value="${vo.no }">
	</form>
	</td>
	<td>
	<input class="li_button"  type="button" value="목록" onclick="list_go()">
	</td>
	
	</tr>

</table>

<hr>
<table >
	<tr height="200">
		<td >${pvo.psContent }</td>
	</tr>
	<tr>
	<td>
		<c:if test="${empty pvo.psFile }">
			첨부파일없음
		</c:if>
		<c:if test="${not empty pvo.psFile }">
			<img src="img/${pvo.psOrifile }" width="200">
		</c:if>
		</td>
	</tr>
</table>
<hr>
<!-- 댓글작성 -->
<div class="comment">
	<form action="postComment_write_ok.jsp" method="post">
<table>
	<tr>
		<td colspan=7>
			<input type="hidden" name="no" value="${no }">
			<textarea name="pcContent" rows="2" cols="55"></textarea>
			<input class="writeBtn" type="button" value="댓글작성" onclick="login_confirm(this.form);">
			<input type="hidden" name="psNo" value="${pvo.psNo }">
			<input type="hidden" name="cPage" value="${cPage }">
			</td>
		</tr>
</table>
	</form>
<hr class="color">

<!-- 댓글표시 및 삭제-->
<table class="comment" border frame=void>
	<c:forEach var="commVO" items="${c_list }">
		<form action="postComment_del_ok.jsp" method="get">
		<tr>
			<td width="20%">
				작성자 | ${commVO.pcNick }
			</td>
			<td width="20%">
			 작성일 | ${commVO.pcDate }
			</td>
			<td >
			${commVO.pcContent }
			</td>
			<td class="deleteComment">
				<input class="deleteBtn" type="button" value="댓글삭제"  
					data-comm-no="${commVO.no}" onclick="pc_delete(this.form, this.dataset.commNo)">
				<input type="hidden" name="pcNo" value="${commVO.pcNo }">
				<input type="hidden" name="no" value="${commVO.no }">
			</td>
		</tr>
		</form>
	</c:forEach>
</table>
	</div>
	</div>


</body>
</html>