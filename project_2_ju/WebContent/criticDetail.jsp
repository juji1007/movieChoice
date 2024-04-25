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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세정보</title> 
</head>
<body>
	<c:forEach var="cvo" items="${cvoList}">
		<p>${cvo.rvNick }</p>
		<p>${cvo.rvTitle }</p>
		<p>${cvo.rvContent }</p>
		<p>${cvo.rvDate }</p>
		<hr>
	</c:forEach>
</body>
</html>