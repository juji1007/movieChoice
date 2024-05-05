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
	int cPage = 0;
	try {
		if (session.getAttribute("recVo") != null) {
			listTotVO recVo = (listTotVO)session.getAttribute("recVo");
			session.setAttribute("listOne", recVo);
		}
		
		int rvNo = Integer.parseInt(request.getParameter("rvNo"));
		System.out.println("rvNo : " + rvNo);
		
		cPage = Integer.parseInt(request.getParameter("cPage"));
		System.out.println("cPage : " + cPage);
		
		//리뷰 전체(영화,회원) 목록 조회 - mapper에서 3개 테이블 조인
		listTotVO listOne = listTotDAO.selectOne(rvNo);
		System.out.println(">> 리뷰 상세 listOne : " + listOne);
		
		session.setAttribute("listOne", listOne);
		session.setAttribute("cPage", cPage);
		
		int no = (Integer)session.getAttribute("no");
		pageContext.setAttribute("no", no);
		System.out.println("세션 회원no : " + no);
		
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
		
		//로그인 회원NO의 추천&신고 여부 확인
		int recNum = recDAO.recSearch(no, rvNo);
		System.out.println("recNum : " + recNum);
		pageContext.setAttribute("recNum", recNum);
		
		int warnNum = warnDAO.warnSearch(no, rvNo);
		System.out.println("warnNum : " + warnNum);
		pageContext.setAttribute("warnNum", warnNum);
		
	} catch (Exception e) {
%>
<script>
		//출력안됨
		alert("로그인 후 열람 가능합니다.");
		console.log("로그인 하세요");
</script>		
<%
		//rvMain에서 클릭
		response.sendRedirect("reviewController?category=rvMain&cPage=" + cPage);
		//selectOne에서 클릭
// 		response.sendRedirect("reviewController?category=selectOne&cPage=" + cPage);
		
	} 
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세 페이지 [ rvDetail.jsp ]</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/freeView.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	//추천수, 신고수 버튼(toggle 기능 - 한번 클릭 추천, 한번 더 클릭 해제)
	function rec_toggle(frm, recNum) {
		//본인 리뷰가 아닌지 확인
		if (${no} != ${listOne.no}) {
			//추천 클릭시, rvRec.jsp에서 추천 추가(+1)
			//rvRec = 0이 아니라 REC 테이블에 ${no}의 정보가 없을 경우 +1
			if (recNum == 0) {
// 				alert("-" + recNum + "-");
				alert("추천했습니다.");
			//해제(-1) 처리
			} else if (recNum != 0) {
// 				alert("-" + recNum + "-");
				alert("추천을 취소합니다.");
			}
			location.href= "rvRec.jsp?rvNo=${listOne.rvNo}";
		} else if (${no} == 13) {
			alert("관리자 계정입니다.");
		} else {
			alert("본인 리뷰는 추천할 수 없습니다.");
		}
	}
	
	function warn_push(frm, warnNum) {
		//본인 리뷰가 아닌지 확인
		if (${no} != ${listOne.no}) {
			//신고 클릭시, rvWarn.jsp에서 신고 추가(+1)
			if (warnNum == 0) {
// 				alert("-" + warnNum + "-");
				alert("신고했습니다.");
			//해제(-1) 처리
			} else {
// 				alert("-" + warnNum + "-");
				alert("신고를 취소합니다.");
			}
			location.href= "rvWarn.jsp?rvNo=${listOne.rvNo}";
		} else if (${no} == 13) {
			alert("관리자 계정입니다.");
		} else {
			alert("본인 리뷰는 신고할 수 없습니다.");
		}
	}
	
// 	//무한정 추천 가능
// 	function rec_push(frm) {
// 		//본인 리뷰가 아닌 경우 추천 가능
// 		if (${no} != ${listOne.no}) {
// 			//추천 클릭 처리
// 			alert("추천을 눌렀습니다.");
// 			location.href= "rvRec.jsp?rvNo=${listOne.rvNo}";
			
// 		} else {
// 			alert("본인 리뷰는 추천할 수 없습니다!!");
// 			location.href= "rvDetail.jsp?rvNo=${listOne.rvNo}&cPage=${cPage}";
// 		}
// 	}

	//시간 여유 시, 구현 예정
	function prev_go() {
		
	}
	function next_go() {
		
	}
	
	//리뷰 수정 권한
	function update_go(frm) {
		//회원번호 확인
		if(${no} == ${listOne.no}) {
			frm.submit();
		} else {
			alert("수정권한이 없습니다.");
		}
	}
	
	//리뷰 삭제 확인 및 권한
	function delete_go(frm) {
		let isDelete = confirm("삭제하시겠습니까?");
		
		if(isDelete) {
			//회원번호 확인
			if(${no} == ${listOne.no}) {
	 			location.href = "rvDelete.jsp?rvNo=${listOne.rvNo}";
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
	<%@ include file="include/header.jspf" %>
<div class="body">
<table frame="void">	
	<tr>
		<td colspan=7 ><h1>${listOne.rvTitle }</h1></td>
	</tr>
	<tr>
		<td width="20%">작성자 | ${listOne.rvNick }</td>
		<td width="20%">작성일 | ${listOne.rvDate }</td>
		<td>
		<input class="up_button" type="button" value="추천" data-rec-num="${recNum}" 
			onclick="rec_toggle(this.form, this.dataset.recNum)"> ${listOne.rvRec}
	</td>
	<td>
		<input class="up_button" type="button" value="신고" data-warn-num="${warnNum}" 
			onclick="warn_push(this.form, this.dataset.warnNum)"> ${listOne.rvWarn}
	</td>
	<td>
		<form action="rvUpdate.jsp?rvNo=${listOne.rvNo }" method="post">
			<input class="up_button"  type="button" value="수정" onclick="update_go(this.form)">
		</form>
	</td>
	<td>
			<input class="h_button" type="button" value="삭제" onclick="delete_go(this.form)">
	</td>
	<td>
		<input class="li_button"  type="button" value="목록" onclick="javascript:location.href='reviewController?category=rvMain&cPage=${cPage}'">
	</td>
	</tr>

</table>
<hr>
<table>	
	<tr  height="200">
		<td rowspan="2" width="20%">
			<img src="img/${listOne.mvPoster }" alt="포스터" width="300px">
		</td>
		<td id="rvContent" rowspan="2" colspan="3">${listOne.rvContent }</td>
	</tr>
</table>	

<%-- 	<form action="rvUpdate.jsp?rvNo=${listOne.rvNo }" method="post"> --%>
<!-- 	<table frame="void"> -->
<!-- 		<tbody> -->
<!-- 			<tr> -->
<%-- 				<td rowspan="3" width="20%"><img src="img/${listOne.mvPoster }" alt="포스터" width="300px"></td> --%>
<%-- 				<td id="rvTitle" colspan="3" height="40px">${listOne.rvTitle }</td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<%-- 				<td id="rvNick" width="10%" height="40px">${listOne.rvNick }</td> --%>
<%-- 				<td id="rvDate" width="20%">${listOne.rvDate }</td> --%>
<!-- 				<td class="right"> -->
<%-- 					<input class="up_button" type="button" value="추천" data-rec-num="${recNum}"  --%>
<!-- 					onclick="rec_toggle(this.form, this.dataset.recNum)"> -->
<%-- 					${listOne.rvRec} --%>
<%-- 					<input class="up_button" type="button" value="신고" data-warn-num="${warnNum}"  --%>
<!-- 					onclick="warn_push(this.form, this.dataset.warnNum)"> -->
<%-- 					${listOne.rvWarn} --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<%-- 				<td id="rvContent" colspan="3">${listOne.rvContent }</td> --%>
<!-- 			</tr> -->
<!-- 		</tbody> -->
	
<!-- 		<tfoot class="tfoot"> -->
<!-- 			<tr> -->
<!-- 				<td colspan="4"  class="center"> -->
<%-- 					<input class="li_button" type="button" value="목록" onclick="javascript:location.href='reviewController?category=rvMain&cPage=${cPage}'"> --%>
<!-- 					<input class="up_button" type="button" value="수정" onclick="update_go(this.form)"> -->
<!-- 					<input class="h_button" type="button" value="삭제" onclick="delete_go(this.form)"> -->
					
<%-- 					<input type="hidden" name="listOne" value="${listOne}"> --%>
<%-- 					<input type="hidden" name="recNum" value="${recNum}"> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</tfoot> -->
<!-- 	</table> -->
<!-- 	</form> -->
	<hr class="color">
	</div>
</body>
</html>