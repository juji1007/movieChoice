<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String location = request.getParameter("location");
	if ("myPage".equals(location)) {
		int rvNo = Integer.parseInt(request.getParameter("rvNo"));
		System.out.println("rvNo : " + rvNo);
		
		listTotVO listOne = listTotDAO.selectOne(rvNo);
		listTotVO vo = listOne;
		System.out.println(">> myPage 가져온 vo : " + vo);
		
		//listTotVO에서 rvNo 검색하여 mvTitle 1개 가져오기(select)
		listTotVO totVo = listTotDAO.selectOne(vo.getRvNo());
		System.out.println("수정할 vo : " + totVo);
		
		session.setAttribute("upVo", totVo);
		
	} else {
		//reDetail.jsp에서 입력한 데이터vo 받아오기(session 저장된 vo 확인용)
		listTotVO vo = (listTotVO)session.getAttribute("listOne");
		System.out.println(">> reDetail.jsp 가져온 vo : " + vo);
		
		//listTotVO에서 rvNo 검색하여 mvTitle 1개 가져오기(select)
		listTotVO totVo = listTotDAO.selectOne(vo.getRvNo());
		System.out.println("수정할 vo : " + totVo);
		
		session.setAttribute("upVo", totVo);
		
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 페이지</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/write.css">

</head>
<body>
<%@ include file="include/header.jspf" %>
<div class="body">
<div>
<form action="rvUpdate_ok.jsp" method="post">	
	<table>
		<caption>리뷰 수정</caption>
		<tr>
		<th>영화</th>
		<td>
			<select class="movie" id="movie" name="mvNo" disabled="disabled" height="22px">
	        	<option value=${upVo['mvNo']}>${upVo['mvTitle']}</option>
    		</select>
		</td>
		</tr>
		<tr>
			<th>평점</th>
			<td>
				<input class="rvRate" type="number" name="rvRate" min="0" max="10" title="평점" value="${upVo.rvRate}">
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input class="psTitle" type="text" name="rvTitle" title="제목" value="${upVo.rvTitle}">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="psContent" name="rvContent" rows="8" cols="50" title="내용">${upVo.rvContent}</textarea>
			</td>
		</tr>
		<tr>
			<td class="button" colspan="2">
				<input class="commitbtn" type="submit" value="수 정">
		        <input class="reset" type="reset" value="초기화">
		        <input class="reset" type="button" value="전체목록" 
		        	onclick="javascript:location.href='reviewController?category=rvMain'">
			</td>
		</tr>
	</table>
</form>	
</div>
</div>
<!-- 		<tbody> -->
<!-- 			<tr> -->
<!-- 				<th>영화</th> -->
<!-- 				<td> -->
<!-- 					<select id="movie" name="mvNo" disabled="disabled"> -->
<%-- 			            <option value=${upVo['mvNo']}>${upVo['mvTitle']}</option> --%>
<!--         			</select> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>평점</th> -->
<!-- 				<td> -->
<%-- 					<input type="number" name="rvRate" min="0" max="10" title="평점" value="${upVo.rvRate}"> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>제목</th> -->
<!-- 				<td> -->
<%-- 					<input type="text" name="rvTitle" title="제목" value="${upVo.rvTitle}"> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<th>내용</th> -->
<!-- 				<td> -->
<%-- 					<textarea name="rvContent" rows="8" cols="50" title="내용">${upVo.rvContent}</textarea> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</tbody> -->
<!-- 		<tfoot> -->
<!-- 			<tr id="btn"> -->
<!-- 				<td colspan="2"> -->
<%-- 					<input type="hidden" name="rvNo" value="${upVo.rvNo}"> --%>
					
<!-- 					<input type="submit" value="수정"> -->
<!-- 			        <input type="reset" value="초기화"> -->
<!-- 			        <input type="button" value="목록보기"  -->
<%-- 			        	onclick="javascript:location.href='reviewController?category=rvMain&cPage=${cPage}'"> --%>
			        
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</tfoot> -->

</body>
</html>