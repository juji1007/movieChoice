<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
<script>
	function member_join(frm) {
		frm.action="loginController?type=memberJoin";
		frm.submit();
	}
	function login(frm) {
		frm.action="loginController?type=login";
		frm.submit();
	}
	function find_id(frm) {
		frm.action="loginController?type=findId";
		frm.submit();
	}
	function find_password(frm) {
		frm.action="loginController?type=findPassword";
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
	<div id="loginArea">
		<form method="post">
			<table>
				<caption><h2>로그인</h2></caption>
				<thead>
					<tr>
						<th>아이디</th>
						<td colspan="3">
							<input type="text" name="id" title="아이디" />
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td colspan="3">
							<input type="password" name="pwd" title="비밀번호" />
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<input type="reset" value="초기화"/>
							<input type="button" value="회원가입" onclick="member_join(this.form)"/>
							<input type="button" value="아이디찾기" onclick="find_id(this.form)"/>
<!-- 							<input type="button" href="loginController?type=findPassword" value="비밀번호찾기" /> -->
							<input type="button" value="비밀번호찾기" onclick="find_password(this.form)"/>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<input type="button" value="로그인하기" onclick="login(this.form)"/>
						</td>
					</tr>
				</tbody>
				
			</table>
		</form>
	</div>
</body>
</html>