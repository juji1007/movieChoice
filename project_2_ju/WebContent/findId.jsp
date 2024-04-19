<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디찾기</title>
<script>
	function findId_Ok(frm) {
		frm.action="loginController?type=findIdOk";
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
	<div id="findIdArea">
		<form method="post">
			<table>
				<caption><h2>아이디찾기</h2></caption>
				<thead>
					<tr>
						<th>이메일입력</th>
						<td colspan="5">
							<input type="text" name="email" title="이메일"/>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<input type="reset" value="초기화"/>
						</td>
						<td colspan="4">
<!-- 							<input type="button" value="아이디찾기" onclick="location.href='loginController?type=findIdOk'"/> -->
							<input type="button" value="아이디찾기" onclick="findId_Ok(this.form)"/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
</body>
</html>