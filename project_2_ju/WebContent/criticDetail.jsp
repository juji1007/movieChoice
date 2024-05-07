<%@page import="java.util.List"%>
<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.dao.criticDAO"%>
<%@page import="com.mystudy.model.vo.criticVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
	  	int cNo = Integer.parseInt(request.getParameter("critic"));
		System.out.println("cNo : " + cNo);
		
		List<criticVO> cvoList = null; // Change criticVO cvo = null; to List<criticVO> cvoList = null;
		try (SqlSession ss = DBService.getFactory().openSession()) {
		    cvoList = ss.selectList("critic.one", cNo);
		} catch (Exception e) {
		    e.printStackTrace();
		}
		System.out.println("cvoList : " + cvoList);
		request.setAttribute("cvoList", cvoList);
		
		criticVO vo = criticDAO.criticCname(cNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보</title> 
<link rel="stylesheet" href="css/free.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/rvMain.css">
<style>
	.li_button {
        background-color: #6c757d; 
        color: #fff;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        margin-right: 20px; 
        border-radius: 10px;
    }
</style>
</head>
<body>
<%@ include file="include/header.jspf" %>
<div class="body">
	<h2><%=vo.getName() %> 평론가 리뷰</h2> 
	<input class="li_button" type="button" value="목록" onclick="location.href = 'critic.jsp'">
	<hr class="color">
	<c:forEach var="cvo" items="${cvoList}">
		<p><strong>${cvo.rvNick }</strong> | ${cvo.rvTitle }</p>
		<p>${cvo.rvContent }</p>
		<p>${cvo.rvDate }</p>
		<br>
	</c:forEach>
</div>
</body>
</html>