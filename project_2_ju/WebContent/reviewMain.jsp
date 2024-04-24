<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//페이징 처리를 위한 객체(Paging) 생성
	Paging p = new Paging();

	//1. 전체 게시물 수량 구하기
	p.setTotalRecord(reviewDAO.getTotalCount());
	p.setTotalPage();
	
	System.out.println(">전체 게시글 수 : " + p.getTotalRecord());
	System.out.println(">전체 페이지 수 : " + p.getTotalPage());
	
	//2. 현재 페이지 번호 구하기
	String cPage = request.getParameter("cPage");
	if (cPage != null) {
		p.setNowPage(Integer.parseInt(cPage));
	}
	System.out.println("> cPage : " + cPage);
	System.out.println("> Paging nowPage : " + p.getNowPage());
	
	//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
	p.setEnd(p.getNowPage() * p.getNumPerPage());
	p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
	
	System.out.println(">> 시작번호(begin) : " + p.getBegin());
	System.out.println(">> 끝번호(end) : " + p.getEnd());
	
	//4. --- 블록(block) 계산하기 -----
	//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
	int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
	p.setNowBlock(nowBlock);
	p.setEndPage(nowBlock * p.getPagePerBlock());
	p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
	System.out.println(">> nowBlock : " + p.getNowBlock());
	System.out.println(">> beginPage : " + p.getBeginPage());
	System.out.println(">> endPage : " + p.getEndPage());
	
	// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
	// 끝페이지를 전체페이지 수로 변경 처리
	if (p.getEndPage() > p.getTotalPage()) {
		p.setEndPage(p.getTotalPage());
		System.out.println(">>정정후 endPage : " + p.getEndPage());
	}
%>
<%
	//DB 연동 작업
	//현재페이지 기준으로 DB 데이터(게시글) 가져오기
	//시작번호(begin), 끝번호(end)
	List<reviewVO> list = reviewDAO.getList(p.getBegin(), p.getEnd());
	System.out.println(">> 현재페이지 글목록 : " + list);
%>
<%
	//EL, JSTL 사용을 위해 scope에 데이터 등록(page영역)
	// 페이징처리객체 page 영역에 저장
	pageContext.setAttribute("pvo", p);
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰목록 메인 페이지</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
	function recommand_push() {
		location.href = "rvRecommand.jsp";
		submit();
		
	}
	
	//AJAX controller 연결 - review 전체 조회
	$(document).ready(function(){
		console.log(">> reviewMain.jsp 접속 성공!!");
		
		$.ajax({
			type : "POST",
			url : "ajaxReviewController",
			data : {
				action: "reviewMain"
			},
			dataType: "json",
			success : function(respData){
			    console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
			    //Json데이터 처리
			    let str = null;
			    for (let member of respData.listAll) {
			        console.log("실행");
			        str += "<tbody>";
			        str += "<tr>";
 			        str += "<td>" + member.mvTitle + "</td>"
			        str += "<td id=\"rvDetail\" colspan=\"2\">";
			        str += "<a href=\"reviewController?type=rvDetail&rvNo=\" + member.rvNo + \">" + member.rvTitle + "</a>";
			        str += "</td>";
			        str += "</tr>";
			        
			        str += "<tr>";
 			        str += "<td rowspan=\"2\">";
 			        str += "<img src=\"img\" + member.mvPoster + \" alt=\"포스터\" width=\"150px\">";
// 			        str += "<img src=\"img/exhuma.jpg" alt=\"포스터\" width=\"150px\">";
			        str += "</td>"; 
			        str += "<td>" + member.rvNick +"</td>";
			        str += "<td>" + member.rvDate +"</td>";
			        str += "</tbody>";
			        
			        str += "<tr>";
			        str += "<td class=\"recNo\" colspan=\"3\">";
			        str += "<input type=\"button\" value=\"추천수 \" onclick=\"reviewController?type=rvRecommand&rvNo=&rvRec=\">";
			        str += "<img src=\"img/iconRec.png\" id=\"iconRec\" alt=\"추천\" width=\"25px\">" + member.rvRec;
			        str += "</td>";
			        str += "</tr>";
			    }
			    $("#reviewOne").html(str);
			},

			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			},
			complete : function(){
				alert(":: complete 실행");
			}
		});

	}); 
	
	
	
</script>
</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
	<form action="reviewController?category=selectOne" method="get">
		<select name="idx">
			<option selected disabled>::선택</option>
			<option value="0">영화명</option>
			<option value="1">작성자</option>
			<option value="2">작성일</option>
		</select>
		<input type="text" name="keyword">
		<input type="submit" value="검색">
		
		<input type="hidden" name="category" value="selectOne">
	</form>
	
	<h2>리뷰모음</h2>
	<input type="button" value="리뷰작성" onclick="javascript:location.href='rvWrite.jsp'">
	<hr>

	<h3>리뷰 목록</h3>
<!--
 	<div id="reviewDiv">
		<h4>영화제목</h4>
		<h4>영화포스터</h4>
		<h4>리뷰번호</h4>
		<h4>리뷰제목</h4>
		<h4>리뷰추천수</h4>
	</div> 
-->
	<table id="reviewOne" border>
		<tbody>
			<tr>
				<td id="movieTitle">영화명</td>
				<td id="rvDetail" colspan="2">
					<a href="reviewController?type=rvDetail&mvNo=&rvNo=">영화제목</a>
				</td>
			</tr>
			<tr>
				<td rowspan="2" id="moviePoster"><img src="img/kungfu.jpg" alt="포스터" width="150px">포스터</td>
				<td>작성자</td>
				<td>작성일</td>
			</tr>
		</tbody>
		
		<tfoot id="tfoot">
			<tr>
				<td class="recNo" colspan="3">
					<input type="button" value="추천수 " onclick="reviewController?type=rvRecommand&rvNo=&rvRec=">
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px">
					추천수0
				</td>
			</tr>
		</tfoot>
	</table>
	
<%-- 	<c:forEach var="vo" items="${listMv }">
		<!-- <a href="reviewController?type=rvDetail"> -->
		<table id="reviewOne">
			<tbody>
				<tr>
					<td colspan=>영화명${mvVo.mvTitle }</td>
					<td id="rvDetail" colspan="2">
						<a href="reviewController?type=rvDetail&mvNo=${vo.mvNo }&rvNo=${vo.rvNo}">${vo.rvTitle }</a>
					</td>
				</tr>
				<tr>
					<td rowspan="2"><img src="img/kungfu.jpg" alt="포스터" width="150px"></td>
					<td>${vo.rvNick }</td>
					<td>${vo.rvDate }</td>
				</tr>
			</tbody>
			
			<tfoot id="tfoot">
				<tr>
					<td class="recNo" colspan="3">
						<input type="button" value="추천수 " onclick="reviewController?type=rvRecommand&rvNo=${vo.rvNo}&rvRec=${vo.rvRec}">
						<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px">
						${vo.rvRec }
					</td>
				</tr>
			</tfoot>
		</table>
	</c:forEach> 
--%>
	
</body>
</html>