<%@page import="com.mystudy.model.dao.warnDAO"%>
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
//	rvDate(월별) 추천 수가 많은 vo를 선택하여 [reward]에 해당 월의 리뷰vo insert 
//	화면에 보이는 페이지/관리자가 업로드 할 수 있는 페이지 따로 구현
	//rvDate 초기값은 시스템 날짜로 추출
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
	Date now = new Date();
	
	String rvDate = sdf.format(now);
	System.out.println("rvDate : " + rvDate);
	
	
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
	//Set<String> setValue = new HashSet<>();
	//Map<String, Set<String>> map = new HashMap<>();
	for (int i = 0; i < listAll.size(); i++) {
		//option태그 표시 값
		String yearMonth = sdf2.format(listAll.get(i).getRvDate()); //yyyy-MM
		set.add(yearMonth);
		//option태그 value 값
		String yyyyMM = sdf.format(listAll.get(i).getRvDate());
		//setValue.add(yyyyMM);
		
		//set-setValue를 묶어서 Map<String, Set<String>>에 저장
		//map.put("set", set);
		//map.put("setValue", setValue);
	}
	//request.setAttribute("setValue", setValue);
	
	//set에서 이번달 날짜 제거
	set.remove(thisMonth);
	//setValue.remove(valueThisMonth);
	System.out.println("set : " + set);
	request.setAttribute("set", set);
	
	//System.out.println("map : " + map);
	//request.setAttribute("map", map);
	
	//Set<String> s = map.get("set");
	//Set<String> sv = map.get("setValue");
	//request.setAttribute("s", s);
	//request.setAttribute("sv", sv);
	
	//review 테이블에서 월별로 rvNo 번호 추출
	List<reviewVO> list = reviewDAO.selectVO(rvDate);
	System.out.println("시스템날짜 List : " + list);
	
	//해당 월의 rvNo에서 높은 추천수인 rvNo번호 추출
	int rvNo = 0;
	int recNum = 0;
	int i;
	List<Integer> rwRvNo = new ArrayList<>();
	
	for(i=0; i < list.size(); i++) {
		rvNo = list.get(i).getRvNo();
		recNum = recDAO.getRec(rvNo);
		rwRvNo.add(i, recNum);
	}
	System.out.println("rwRvNo : " + rwRvNo);
	
	int largeRecNum = rwRvNo.get(0);
	int rvNoLarge = list.get(0).getRvNo();
	for(i=0; i < rwRvNo.size(); i++) {
		if (rwRvNo.get(i) > largeRecNum) {
			largeRecNum = rwRvNo.get(i);
			rvNoLarge = list.get(i).getRvNo();
		}
	}
	System.out.println("largeRwNo : " + largeRecNum);
	System.out.println("rvNoLarge : " + rvNoLarge);
	
	//rvNo(추천수 높은 largeRvNo)로 listTot에서 vo 정보 받아오기
	listTotVO vo = listTotDAO.selectOne(rvNoLarge);
	System.out.println("추천수 높은 vo : " +  vo);
	
	//rvRec, rvWarn 계산 처리 필요!!!=>request로 rvRec, rvWarn 넘겨주기 
	//추천수 sum 보여주기 계산
	int selRvNo = vo.getRvNo();
	System.out.println("> 이달의 리뷰 selRvNo : " + selRvNo);
	
	int rvRec = recDAO.recSum(selRvNo);
	System.out.println("::recDAO.recSum rvRec : " + rvRec);
	if (rvRec == -1) {
		rvRec = 0;
	}
	vo.setRvRec(rvRec);
	
	//신고수 sum 보여주기 계산
	int rvWarn = warnDAO.warnSum(rvNo);
	System.out.println("::warnDAO.warnSum rvWarn : " + rvWarn);
	if (rvWarn == -1) {
		rvWarn = 0;
	}
	vo.setRvWarn(rvWarn);
	System.out.println("<추천/신고 계산>추천수 높은 vo : " + vo);

	request.setAttribute("rwVo", vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이달의 리뷰</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/rwMain.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

function selectCategory(frm) {
	var checkCategory = frm.rwDate.value;
	alert("checkCategory rwDate : " + checkCategory);
	
	$.ajax({
		type : "POST",
		url : "ajaxRewardController",
		data : {
			action: "rwMain_ajax",
			date : rwDate
		},
		dataType: "json",
		success : function(respData){
		    console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
		    
		    //Json데이터 처리
		    let str = "";
		    if (respData.vo.length === 0) {
                // 검색 결과가 없을 때
                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
            } else {
                // 검색 결과가 있을 때
                }
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
			}
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
	
}
</script>

</head>
<body>
	<!-- header.jspf -->
	<%@ include file="include/header.jspf" %>
<div class="body">
	<h2>월별 조회
		<input class="write" type="button" value="이달의 리뷰" onclick="javascript:location.href='rewardController?category=rwMain'">
	</h2>
	<hr class="color">
	
	<div class="box">
	<div class="innerbox">
	<div class="content">
	<form action="rewardController?action=rwMain_ajax" method="post">
		<select class="select" id="rwDate" name="rwDate">
				<option value="${thisMonth}">${thisMonth}</option>
			<c:forEach var="date" items="${set}"><!--높은 추천수,월별로 조회한 배열vo-->
				<option value="${date}">${date}</option>
			</c:forEach>
		</select>
		<input class="searchbtn" type="button" value="검색" onclick="selectCategory(this.form)">
	</form>
		<table border frame=void>
			<thead>
				<tr>
					<th>영화</th>
					<th colspan="4">리뷰</th>
				</tr>
			</thead>
			<tbody  id="reviewOne">
				<tr>
					<td id="mvTitle" width="20%" height="60px">${rwVo.mvTitle}</td>
					<td id="rvTitle" colspan="4">${rwVo.rvTitle }</td>
				</tr>
				<tr>
					<td rowspan="2"><img src="img/${rwVo.mvPoster }" alt="포스터" width="300px"></td>
					<td id="rvNick" width="30%" height="30px">작성자 | ${rwVo.rvNick }</td>
					<td id="rvDate" width="30%">작성일 | ${rwVo.rvDate }</td>
					<td id="btn" width="10%">
						<input class="up_button" type="button" value="추천">
						${rwVo.rvRec}
					</td>
					<td width="10%">
						<input class="up_button" type="button" value="신고">
						${rwVo.rvWarn}
					</td>
				</tr>
				<tr>
					<td id="rvContent" colspan="4">${rwVo.rvContent }</td>
				</tr>
			</tbody>
		</table>
	</div>
	</div>
	</div>
	
	<hr class="color2">
	<hr class="color">
</div>
	
	<!-- footer.jspf -->
	<%@ include file="include/footer.jspf" %>
	<!-- 	<form action="rewardController?category=search" method="post"> -->
<!-- 		<select id="search" name="search"> -->
<%-- 				<option value="${thisMonth}">${thisMonth}</option> --%>
<%-- 			<c:forEach var="date" items="${set}"><!--높은 추천수,월별로 조회한 배열vo--> --%>
<%-- 				<option value="${date}">${date}</option> --%>
<%-- 			</c:forEach> --%>
<!-- 		</select> -->
<!-- 		<input type="submit" value="검색"> -->
		
<!-- 		<input type="hidden" name="category" value="search"> -->
<!-- 	</form> -->
</body>
</html>