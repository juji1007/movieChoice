<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호찾기</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/login.css">
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
/* 	table { */
/* 		border: solid black 1px; */
/* 	} */
/* 	th, td { */
/* 		border: solid black 1px; */
/* 	} */
</style>
</head>
<body>

<div class="body">
	
		<div class="text">
				<h2>비밀번호 재설정</h2>
				</div>
				<br>
				<div id="findPasswordArea">
		<form method="post">
				<hr>
			<div class="table">
			<table class="tb">
					<tr>
<!-- 						<th>아이디입력</th> -->
						<td colspan="2">
							<input class="psTitle" type="text" name="id" title="아이디" placeholder="아이디"/>
						</td>
					</tr>
				<tbody>
					<tr>
<!-- 						<th>비밀번호재설정</th> -->
						<td colspan="2">
							<input class="psTitle" type="password" name="password" title="새로운비밀번호" placeholder="새 비밀번호"/>
						</td>
					</tr>
					<tr>
<!-- 						<th>비밀번호재설정확인</th> -->
						<td colspan="2">
							<input class="psTitle" type="password" name="passwordCheck" title="새로운비밀번호확인"  placeholder="비밀번호 확인"onblur="check_password(this.form)"/>
						</td>
					</tr>
					<tr>
						
						<td align="right">
							<input class="searchbtn" type="button" value="메인가기" onclick="javascript:location.href='main.jsp'">
							
							<input class="searchbtn" type="button" value="아이디찾기" onclick="javascript:location.href='loginController?type=findId'">
							
							<input class="loginbtn" type="button" value="비밀번호 변경" onclick="findPassword_Ok(this.form)"/>
						</td>
					</tr>
					<tr>
					<td>
					<input class="joinbtn" type="button" value="로그인 가기" onclick="javascript:location.href='login_page.jsp'">
					</td>
					</tr>
					<tr>
						<td align="right">
						<input class="searchbtn" type="reset" value="초기화"/>
						</td>
					</tr>
			</table>
			</div>
		</form>
	</div>
</div>
	
</body>
</html>