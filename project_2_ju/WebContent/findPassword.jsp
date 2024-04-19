<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호찾기</title>
<script>
	function check_password(frm) {
		var password = frm.password.value;
		var checkPassword = frm.passwordCheck.value;
		
		if(password != checkPassword) {
			alert("비밀번호와 비밀번호확인 값이 다릅니다!");
			frm.passwordCheck.value="";
		}
	}
	function findPassword_Ok(frm) {
		frm.action="loginController?type=findPasswordOk";
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
	<div id="findPasswordArea">
		<form method="post">
			<table>
				<caption><h2>비밀번호찾기</h2></caption>
				<thead>
					<tr>
						<th>아이디입력</th>
						<td colspan="3">
							<input type="text" name="id" title="아이디"/>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>비밀번호재설정</th>
						<td colspan="3">
							<input type="password" name="password" title="새로운비밀번호"/>
						</td>
					</tr>
					<tr>
						<th>비밀번호재설정확인</th>
						<td colspan="3">
							<input type="password" name="passwordCheck" title="새로운비밀번호확인" onblur="check_password(this.form)"/>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">
							<input type="reset" value="초기화"/>
						</td>
					</tr>
					<tr>
						<td colspan="4">
<!-- 							<input type="button" value="아이디찾기" onclick="location.href='loginController?type=findIdOk'"/> -->
							<input type="button" value="비밀번호재설정" onclick="findPassword_Ok(this.form)"/>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</body>
</html>