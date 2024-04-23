<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.vo.criticVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
    List<criticVO> listc = null;
   try (SqlSession ss = DBService.getFactory().openSession()) {
      listc = ss.selectList("critic.all");
   } catch (Exception e) {
      e.printStackTrace();
   }
   System.out.println("listc : " + listc);
   request.setAttribute("listc", listc);
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평론가</title>
</head>
<body>

<h1>평론가</h1>
	<c:forEach var="vo" items="${listc }">
	    <div>
	        <img src="poster/noImage.jpg" alt="평론가 사진">
	        <p><a href="criticDetail.jsp?critic=${vo.no }"><strong>${vo.name }</strong></p> 
	    </div>
	</c:forEach>

</body>
</html>