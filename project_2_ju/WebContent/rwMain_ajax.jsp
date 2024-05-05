<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.mystudy.model.dao.recDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//rvDate 초기값은 시스템 날짜로 추출
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
Date now = new Date();

String rvDate = sdf.format(now);
System.out.println("rvDate : " + rvDate);

// DB 데이터 가져오기(조회)
//listTotVO의 전체 목록 리뷰 작성된 rvDate만 추출
List<listTotVO> listAll = listTotDAO.getList();
System.out.println("전체 목록 listAll : " + listAll);

//중복된 날짜 빼고 set에 yyyymm값 저장
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
String thisMonth = sdf2.format(now); //이번달 날짜
String valueThisMonth = sdf.format(now); //이번달 날짜

request.setAttribute("thisMonth", thisMonth);
request.setAttribute("valueThisMonth", valueThisMonth);

Set<String> set = new HashSet<>();
Set<String> setValue = new HashSet<>();
Map<String, Set<String>> map = new HashMap<>();

for (int i = 0; i < listAll.size(); i++) {
	//option태그 표시 값
	String yearMonth = sdf2.format(listAll.get(i).getRvDate()); //yyyy-MM
	set.add(yearMonth);
	//option태그 value 값
	String yyyyMM = sdf.format(listAll.get(i).getRvDate());
	setValue.add(yyyyMM);
	
	//set-setValue를 묶어서 Map<String, Set<String>>에 저장
	map.put("set", set);
	map.put("setValue", setValue);
}
request.setAttribute("setValue", setValue);

//set에서 이번달 날짜 제거
set.remove(thisMonth);
setValue.remove(valueThisMonth);
System.out.println("set : " + set);
request.setAttribute("set", set);

System.out.println("map : " + map);
request.setAttribute("map", map);

Set<String> s = map.get("set");
Set<String> sv = map.get("setValue");
request.setAttribute("s", s);
request.setAttribute("sv", sv);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이달의 리뷰</title>
<link rel="stylesheet" href="css/header.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
function selectCategory(frm) {
	//날짜 카테고리 클릭시 작동
// 	var checkCategory = frm.date.value;
// 	alert("var frm.date.value : " + checkCategory);
// 	var search = frm.querySelector('input[type="button"]');
	
// 	var date = frm.date.value;
	

	$.ajax({
		type : "POST",
		url : "ajaxRewardController",
		data : {
			action: "rwMain_ajax",
			date : date
		},
		dataType: "json",
		success : function(respData){
		    console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
		    
		    //Json데이터 처리
		    let str = null;
		    for (let member of respData.vo) {
		        console.log(">> 리뷰 내용 실행");
		        str += "<tr>";
		        str += "<td id=\"mvTitle\">" + member.mvTitle + "</td>";
		        str += "<td id=\"rvTitle\" colspan=\"3\">" + member.rvTitle + "</td>";
		        str += "</tr>";
		        str += "<tr>";
		        str += "<td rowspan=\"2\"><img src=\"img/${rwVo.mvPoster }\" alt=\"포스터\" width=\"300px\"></td>";
		        str += "<td id=\"rvNick\">" + member.rvNick + "</td>";
		        str += "<td id=\"rvDate\">" + member.rvDate + "</td>";
		        str += "<td id=\"btn\">";
		        str += "<input type=\"rec\" value=\"추천\">" + member.rvRec;
		        str += "<input type=\"warn\" value=\"신고\">" + member.rvWarn;
	        	str += "</td>";
		        str += "</tr>";
		        str += "<tr>";
		        str += "<td id=\"rvContent\" colspan=\"3\">" + member.rvContent + "</td>";
		        str += "</tr>";
		    }
		    $("#reviewOne").html(str);	
		}, 
		error : function(jqXHR, textStatus, errorThrown){
			alert("Ajax 처리 실패 : \n"
					+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
					+ "textStatus : " + textStatus + "\n"
					+ "errorThrown : " + errorThrown);
		}
// 		},
// 		complete : function(){
// 			alert(":: complete 실행");
// 		}   
	});
	
}
	
</script>

</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
	
	<h1>Review Of The Month</h1>
	
	<h3>월별 조회
		<input type="button" value="이달의 리뷰" onclick="javascript:location.href='rewardController?category=rwMain'">
	</h3>
<!-- 	<form method="post"> -->
	<form action="ajaxRewardController?action=rwMain_ajax" method="post">
		<table border>
		<thead>
			<tr>
				<th>
					<select id="date" name="date">
							<option value="${thisMonth}">${thisMonth}</option>
						<c:forEach var="date" items="${set}"><!--높은 추천수,월별로 조회한 배열vo-->
							<option value="${date}">${date}</option>
						</c:forEach>
					</select>
					<input type="button" value="검색" onclick="selectCategory(this.form)"/>
<!-- 					<input type="submit" value="검색"> -->
				</th>
			</tr>
		</thead>
		<tbody  id="reviewOne">
			<tr>
				<td id="mvTitle"></td>
				<td id="rvTitle" colspan="3"></td>
			</tr>
			<tr>
				<td rowspan="2"><img src="img/" alt="포스터" width="300px"></td>
				<td id="rvNick"></td>
				<td id="rvDate"></td>
				<td id="btn">
					<input type="button" value="추천">
					<input type="button" value="신고">
				</td>
			</tr>
			<tr>
				<td id="rvContent" colspan="3"></td>
			</tr>
		</tbody>
		<tfoot>
		</tfoot>
	</table>
	</form>
	
</body>
</html>