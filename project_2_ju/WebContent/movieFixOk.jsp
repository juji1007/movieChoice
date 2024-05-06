<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	int mvNo = Integer.parseInt(request.getParameter("mvNo"));
	String location = request.getParameter("location");
	movieVO mvo = movieDAO.searchOne(mvNo);
	System.out.println("mvNo : " + mvNo);
	System.out.println("moviefixOklocation : " + location);
	System.out.println("mvo : " + mvo);
	request.setAttribute("location", location);
	request.setAttribute("mvo", mvo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화정보수정</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<link rel="stylesheet" href="css/write.css">
<script>
	function update(frm) {
		frm.action="controller?type=movieFixOk&location=${location}";
		frm.submit();
	}
</script>
<style type="text/css">
/* 	table { */
/* 		border: solid black 1px; */
/* 	} */
/* 	th, td { */
/* 		border: solid black 1px; */
/* 	} */
</style>
</head>
<body>
	<!-- headerAdmin.jspf -->
	<%@ include file="include/headerAdmin.jspf"%>

<div class="body">
	<div id="FixArea">
		<form method="post">
			<table>
				<caption><h2>영화정보수정</h2></caption>
				<thead>
				    <tr>
				        <th>영화이름</th>
				        <td colspan="3">
				            <input class="rvRate" type="text" name="mvTitle" title="영화이름" value="<%= mvo.getMvTitle() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화감독</th>
				        <td colspan="3">
				            <input class="rvRate" type="text" name="mvDirect" title="영화감독" value="<%= mvo.getMvDirect() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화출연진</th>
				        <td colspan="3">
				            <input class="rvRate" type="text" name="mvActor" title="영화출연진" value="<%= mvo.getMvActor() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화장르</th>
				        <td colspan="3">
				            <input class="rvRate" type="text" name="mvGenre" title="영화장르" value="<%= mvo.getMvGenre() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화평점</th>
				        <td colspan="3">
				            <input class="rvRate" type="number" name="mvRate" title="영화평점" value="<%= mvo.getMvRate() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화개봉년도</th>
				        <td colspan="3">
				            <input class="rvRate" type="date" name="mvDate" title="영화개봉년도" value="<%= mvo.getMvDate() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화누적관객</th>
				        <td colspan="3">
				            <input class="rvRate" type="text" name="mvAudience" title="영화출연" value="<%= mvo.getMvAudience() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화등급</th>
				        <td colspan="3">
				            <input class="rvRate" type="text" name="mvGrade" title="영화등급" value="<%= mvo.getMvGrade() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>영화포스터</th>
				        <td colspan="3">
				            <input class="rvRate" id="file2" type="file" name="mvPoster" title="영화포스터" value="<%= mvo.getMvPoster() %>" />
				        </td>
				    </tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="1">
						</td>
						<td colspan="4">
							<input class="reset" type="reset" value="초기화"/>
							<input class="commitbtn" type="button" value="수정하기" onclick="update(this.form)"/>
							<input type="hidden" name="mvNo" value="<%= mvo.getMvNo()%>" />
						</td>
					</tr>
				</tbody>
				
			</table>
		</form>
	</div>
</div>

	<!-- footer.jspf -->
	<%@ include file="include/footer.jspf" %>
</body>
</html>