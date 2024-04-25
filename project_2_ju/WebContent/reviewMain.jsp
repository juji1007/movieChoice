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
			        console.log(">> 리뷰 내용 실행");
			        str += "<tr>";
			        str += "<td>" + member.mvTitle + "</td>";
			        str += "<td>" + member.rvTitle + "</td>";
			        str += "</tr>";
			        
					str += "<tr>";
					str += "<td>" + member.rvNick + "</td>";
			        str += "<td>" + member.rvDate + "</td>";
			        str += "</tr>";
			       
/*
			        str += "<tr>";
 			        str += "<td>" + member.mvTitle + "</td>"
			        str += "<td id=\"rvDetail\" colspan=\"2\">";
			        str += "<a href=\"reviewController?type=rvDetail&rvNo=\"" + member.rvNo + ">" + member.rvTitle + "</a>";
			        str += "</td>";
			        str += "</tr>";
			        
			        str += "<tr>";
 			        str += "<td rowspan=\"2\">";
 			        str += "포스터 경로";
// 			        str += "<img src=\"img\"" + member.mvPoster + \" alt=\"포스터\" width=\"150px\">";
// 			        str += "<img src=\"img/exhuma.jpg" alt=\"포스터\" width=\"150px\">";
			        str += "</td>"; 
			        str += "<td>" + member.rvNick +"</td>";
			        str += "<td>" + member.rvDate +"</td>";
			        
			        str += "<tr>";
			        str += "<td class=\"recNo\" colspan=\"2\">";
			        str += "<input type=\"button\" value=\"추천수 \" onclick=\"reviewController?type=rvRecommand&rvNo=&rvRec=\">";
			        str += "<img src=\"img/iconRec.png\" id=\"iconRec\" alt=\"추천\" width=\"25px\">" + member.rvRec;
			        str += "</td>";
			        str += "</tr>";
*/
			    }
			    $("#reviewOne").html(str);
			    
// 			    for (let member of respData.listAll) {
// 			       console.log(">> 리뷰 btn 실행");
			        
// 			    }
// 			    $("#reviewOne").html(str);
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

	<!-- 리뷰 목록 검색 -->	
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
	
	<hr>
	<h2>리뷰모음</h2>
	<!-- 리뷰 전체보기 -->
	<table border>
		<tbody id="reviewOne">
	        <tr>
	            <td class="col1">파묘</td>
	            <td>리뷰-제목</td>
	        </tr>
	        <tr>
	            <td class="col1">작성자-닉네임</td>
	            <td>작성일</td>
	        </tr>
	    </tbody>
	    
	    <tfoot>
	        <tr>
	            <td id="recBtn">추천수</td>
	            <td id="warnBtn">신고수</td>
	        </tr>
	        <tr>
	        	<td>
					<ol class="paging">
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${pvo.beginPage == 1 }">
						<li class="disable">이전</li> 
					</c:if>
					<c:if test="${pvo.beginPage != 1 }">
						<li>
							<a href="reviewMain.jsp?cPage=${pvo.endPage - 1 }">이전</a>
						</li> 
					</c:if>
					
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
					<c:choose>
						<c:when test="${pageNo == pvo.nowPage }">
							<li class="now">${pageNo }</li>
						</c:when>
						<c:otherwise>
							<li><a href="reveiwMain.jsp?cPage=${pageNo }">${pageNo }</a></li>
						</c:otherwise>
					</c:choose>
					</c:forEach>
						
					<%--[다음]에 대한 사용여부 처리 --%>	
					<c:if test="${pvo.endPage < pvo.totalPage }">
						<li>
							<a href="reveiwMain.jsp?cPage=${pvo.endPage + 1 }">다음</a>
						</li> 
					</c:if>
					<c:if test="${pvo.endPage >= pvo.totalPage }">
						<li class="disable">다음</li> 
					</c:if>
					</ol>
				</td>
				<td>
					<input type="button" value="리뷰작성" 
						onclick="javascript:location.href='rvWrite.jsp'">
				</td>
	    	</tr>
	    </tfoot>
	</table>
			<!-- <tr>
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
			<tr>
				<td class="recNo" colspan="2">
					<input type="button" value="추천수 " onclick="reviewController?type=rvRecommand&rvNo=&rvRec=">
					<img src="img/iconRec.png" id="iconRec" alt="추천" width="25px">
					추천수0
				</td>
			</tr> -->
	
	<!-- 페이징 버튼 -->
		<%-- <tfoot>
		<tr>
			<td colspan="2">
				<ol class="paging">
				[이전]에 대한 사용여부 처리
				<c:if test="${pvo.beginPage == 1 }">
					<li class="disable">이전</li> 
				</c:if>
				<c:if test="${pvo.beginPage != 1 }">
					<li>
						<a href="reviewMain.jsp?cPage=${pvo.endPage - 1 }">이전</a>
					</li> 
				</c:if>
				
				블록내에 표시할 페이지 태그 작성(시작~끝)
				<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
				<c:choose>
					<c:when test="${pageNo == pvo.nowPage }">
						<li class="now">${pageNo }</li>
					</c:when>
					<c:otherwise>
						<li><a href="reveiwMain.jsp?cPage=${pageNo }">${pageNo }</a></li>
					</c:otherwise>
				</c:choose>
				</c:forEach>
					
				[다음]에 대한 사용여부 처리	
				<c:if test="${pvo.endPage < pvo.totalPage }">
					<li>
						<a href="reveiwMain.jsp?cPage=${pvo.endPage + 1 }">다음</a>
					</li> 
				</c:if>
				<c:if test="${pvo.endPage >= pvo.totalPage }">
					<li class="disable">다음</li> 
				</c:if>
				</ol>
			</td>
			<td>
				<input type="button" value="리뷰작성" 
					onclick="javascript:location.href='rvWrite.jsp'">
			</td>
		</tr>
		</tfoot>
	</table> --%>
	
</body>
</html>