<%@page import="com.mystudy.model.dao.criticDAO"%>
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
   
   String cNo = request.getParameter("critic");
   
   int[] numa=new int[listc.size()]; 
   int i = 0;
   for (criticVO cvo :  listc) {
	   System.out.println("listc.no : " + cvo.getNo());
	   int num = cvo.getNo();
	   int no = criticDAO.criticCnt(num);
	   System.out.println("num : " + no); 
	   numa[i] = no;
	   i++;
   }
   
   request.setAttribute("numa", numa);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평론가</title>
<link rel="stylesheet" href="css/header.css">
<script>
	function criticDelete(frm) {
	    let cDelete = confirm("정말로 삭제하시겠습니까?");
	    if (cDelete) {
	    	frm.submit();
	    } else {
	    }
	}
</script>
<style>
	table { border-collapse: collapse; }
	table, th, td { border: 1px solid black; }
	td { text-align: center; }
	tr { height: 40px; }
</style>
</head>
<body>
<%@ include file="include/headerAdmin.jspf" %>
<h1>평론가</h1>
	<c:forEach var="vo" items="${listc }" varStatus="loop">
		<form action="criticDeleteOk.jsp?critic=${vo.no }" method="post">
			<table border>
				<colgroup>
					<col width="100">
					<col width="100">
					<col width="50">
					<col width="100">
					<col width="200">
				</colgroup>
			    <tr>
			        <th rowspan="4"><img src="img/${vo.filename }" width="100" height="150px" alt="평론가 사진"></th>
			        <th colspan="4">정보</th>
			    </tr>
			    <tr>
			        <td rowspan="2"><strong>${vo.name }</strong></td>
			        <td colspan="2">소속</td>
			        <td colspan="2">경력</td>
			    </tr>
			    <tr>
			    	<td colspan="2">${vo.company }</td>
			    	<td colspan="2">${vo.career }</td>
			    </tr>
			    <tr>
			    	<td colspan="4">리뷰건수 : <a href="criticDetail.jsp?critic=${vo.no }">${numa[loop.index]}</a>
			    	<input type="button" value="삭제"  onclick="criticDelete(this.form)">
			    	<input type="button" value="수정" onclick="location.href='criticUpdate.jsp?critic=${vo.no }'"> 
			    	</td>
			    </tr>
			</table>
		</form>
	</c:forEach>
</body>
</html>