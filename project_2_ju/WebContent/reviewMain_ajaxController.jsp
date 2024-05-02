<%@page import="com.project.review.paging.Paging"%>
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
			        str += "<td>";
			        str += "<a href=\"reviewController?type=rvDetail\"" + member.rvNo + ">";
			        str += member.rvTitle;
			        str += "</a>";
			        str += "</td>";
			        str += "</tr>";
			        
					str += "<tr>";
					str += "<td>" + member.rvNick + "</td>";
			        str += "<td>" + member.rvDate + "</td>";
			        str += "</tr>";
			        
			        str += "<tr>";
			    	str += "<td>";
			        str += "<input type=\"button\" value=\"추천수 \" onclick=\"reviewController?type=rvRecommand\">";
			    	str += member.rvRec;
			    	str += "</td>";
			    	str += "<td>";
			        str += "<input type=\"button\" value=\"신고수 \" onclick=\"reviewController?type=rvWarn\">";
			    	str += member.warn;
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
	<table>
		<tbody id="reviewOne">
	        <tr>
	            <td>파묘</td>
	            <td>리뷰-제목</td>
	        </tr>
	        <tr>
	            <td>작성자-닉네임</td>
	            <td>작성일</td>
	        </tr>
	        <tr>
	            <td>추천수</td>
	            <td>신고수</td>
	        </tr>
	    </tbody>
	    
	    <tfoot id="page">
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
					<c:if test="${Pvo.endPage >= pvo.totalPage }">
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
	
</body>
</html>

