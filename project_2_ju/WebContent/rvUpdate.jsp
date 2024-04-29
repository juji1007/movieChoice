<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//reDetail.jsp에서 입력한 데이터vo 받아오기(session 저장된 vo 확인용)
	reviewVO vo = (reviewVO)session.getAttribute("rvVo");
	//System.out.println(">> reDetail.jsp 가져온 vo : " + vo);
	
	//listTotVO에서 rvNo 검색하여 mvTitle 1개 가져오기(select)
	listTotVO totVo = listTotDAO.selectOne(vo.getRvNo());
	System.out.println("totVo : " + totVo);
	
	session.setAttribute("pageVo", totVo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정 페이지</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">

</head>
<body>
<%@ include file="include/header.jspf" %>
<form action="rvUpdate_ok.jsp" method="post">	
	<table>
		<caption>리뷰 수정</caption>
		<tbody>
			<tr>
				<th>영화</th>
				<td>
					<select id="movie" name="mvNo" disabled="disabled">
			            <option value=${rvVo['mvNo']}>${pageVo['mvTitle']}</option>
        			</select>
				</td>
			</tr>
			<tr>
				<th>평점</th>
				<td>
					<input type="number" name="rvRate" min="0" max="10" title="평점" value="${rvVo.rvRate}">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="rvTitle" title="제목" value="${rvVo.rvTitle}">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="rvContent" rows="8" cols="50" title="내용">${rvVo.rvContent}</textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr id="btn">
				<td colspan="2">
					<input type="hidden" value="${rvVo}">
					
					<input type="submit" value="수정">
			        <input type="reset" value="초기화">
			        <input type="button" value="목록보기" 
			        	onclick="javascript:location.href='reviewMain.jsp'">
			        
				</td>
			</tr>
		</tfoot>
	</table>
</form>	
</body>
</html>