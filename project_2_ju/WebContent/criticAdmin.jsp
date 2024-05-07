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
   
   //승인 (CRITICAPPLY)
   List<criticVO> listca = null;
   try (SqlSession ss = DBService.getFactory().openSession()) {
      listca = ss.selectList("critic.allApply");
   } catch (Exception e) {
      e.printStackTrace();
   }
   System.out.println("listca : " + listca);
   request.setAttribute("listca", listca);
   
   
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
<title>평론가 관리자</title>
<link rel="stylesheet" href="css/mheader.css">
<link rel="stylesheet" href="css/free.css">
<style>
  body {
    background-color: #fff;
    margin: 0;
    padding: 20px;
  }
  
  h1 {
    text-align: left;
    color: #333;
  }
  
  .table-container {
    text-align: center; 
  }
  
  table {
    width: 50%;
    border-collapse: collapse;
    border: 1px solid #ddd;
    background-color: #fff;
    table-layout: fixed;
    border-radius: 10px;
    overflow: hidden;
    margin: 0 auto;
  }
  
  th, td {
    padding: 8px;
    border: 1px solid #ddd;
    word-wrap: break-word;
    max-width: 150px;
  }
  
  th {
    background-color: #f2f2f2;
  }
  
  tr:nth-child(even) {
    background-color: #f9f9f9;
  }
  
  tr:hover {
    background-color: #f2f2f2;
  }
  
  img {
    max-width: 180px;
    max-height: 150px;
  }
  
  td {
    text-align: center;
  }
</style>
<script>
	function criticDelete(frm) {
	    let cDelete = confirm("정말로 삭제하시겠습니까?");
	    if (cDelete) {
	    	frm.submit();
	    } else {
	    }
	}
	
	function criticApply(frm) {
	    let cApply = confirm("정말로 승인하시겠습니까?");
	    if (cApply) {
	    	frm.submit();
	    } else {
	    }
	}
	
	function criticApplyDelete(frm) {
	    let caDelete = confirm("정말로 거절하시겠습니까?");
	    if (caDelete) {
	    	frm.submit();
	    } else {
	    }
	}
</script>
</head>
<body>
<%@ include file="include/headerAdmin.jspf" %>
<div class="body">
<h2>승인 대기</h2>
<hr class="color">
<div class="table-container">
	<c:forEach var="vo" items="${listca }">
		<table>
			   <tr>
			       <th rowspan="4"><img src="img/${vo.filename }" alt="평론가 사진"></th>
			       <th colspan="5">정보</th>
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
				<td colspan="5">
				    <div style="display: flex; justify-content: center; gap: 10px;">
				        <form action="criticApplyOk.jsp?critic=${vo.no }" method="post">
				            <input type="button" class="up_button" value="승인" onclick="criticApply(this.form)">
				        </form>
				        <form action="criticApplyDelete.jsp?critic=${vo.no }" method="post">
				            <input type="button" class="del_button" value="거절" onclick="criticApplyDelete(this.form)"> 
				        </form>
				    </div>
				</td>
			</tr>
		</table>
	</c:forEach>
	</div>
	<br><br><br><br><br><br><br><br><br><br><br>
	<hr>
	<h2>평론가 정보</h2>
	<hr class="color">
	<c:forEach var="vo" items="${listc }" varStatus="loop">
		<form action="criticDeleteOk.jsp?critic=${vo.no }" method="post">
			<table>
			    <tr>
			        <th rowspan="4"><img src="img/${vo.filename }" alt="평론가 사진"></th>
			        <th colspan="5">정보</th>
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
			    	<td colspan="5">리뷰건수 : <a href="criticDetailAdmin.jsp?critic=${vo.no }">${numa[loop.index]}</a>
			    	<input type="button" class="del_button" value="삭제"  onclick="criticDelete(this.form)">
			    	<input type="button" class="up_button" value="수정" onclick="location.href='criticUpdate.jsp?critic=${vo.no }'"> 
			    	</td>
			    </tr>
			</table>
		</form>
	</c:forEach>
	
	</div>
</body>
</html>


