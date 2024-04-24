<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	int mvNo = Integer.parseInt(request.getParameter("mvNo"));
	System.out.println("mvNo : " + mvNo);
	
	request.setAttribute("mvNo", mvNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화정보수정</title>
<script>
	function update(frm) {
		frm.action="controller?type=movieFixOk";
		frm.submit();
	}
</script>
<style type="text/css">
	table {
		border: solid black 1px;
	}
	th, td {
		border: solid black 1px;
	}
</style>
</head>
<body>
	<div id="FixArea">
		<form method="post">
			<table>
				<caption><h2>영화정보수정</h2></caption>
				<thead>
					<tr>
						<th>영화이름</th>
						<td colspan="3">
							<input type="text" name="mvTitle" title="영화이름" />
						</td>
					</tr>
					<tr>
						<th>영화감독</th>
						<td colspan="3">
							<input type="text" name="mvDirect" title="영화감독" />
						</td>
					</tr>
					<tr>
						<th>영화출연진</th>
						<td colspan="3">
							<input type="text" name="mvActor" title="영화출연진" />
						</td>
					</tr>
					<tr>
						<th>영화장르</th>
						<td colspan="3">
							<input type="text" name="mvGenre" title="영화장르" />
						</td>
					</tr>
					<tr>
						<th>영화평점</th>
						<td colspan="3">
							<input type="text" name="mvRate" title="영화평점" />
						</td>
					</tr>
					<tr>
						<th>영화개봉년도</th>
						<td colspan="3">
							<input type="text" name="mvDate" title="영화개봉년도" />
						</td>
					</tr>
					<tr>
						<th>영화누적관객</th>
						<td colspan="3">
							<input type="number" name="mvAudience" title="영화출연" />
						</td>
					</tr>
					<tr>
						<th>영화등급</th>
						<td colspan="3">
							<input type="text" name="mvGrade" title="영화등급" />
						</td>
					</tr>
					<tr>
						<th>영화포스터</th>
						<td colspan="3">
							<input type="text" name="mvPoster" title="영화포스터" />
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<input type="reset" value="초기화"/>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<input type="button" value="수정하기" onclick="update(this.form)"/>
							<input type="hidden" name="mvNo" value="<%= mvNo %>" />
						</td>
					</tr>
				</tbody>
				
			</table>
		</form>
	</div>
</body>
</html>