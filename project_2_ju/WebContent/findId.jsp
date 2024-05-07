<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디찾기</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/login.css">
<script>
	function findId_Ok(frm) {
		frm.action="loginController?type=findIdOk";
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
		<h2>아이디찾기</h2>
	</div>
	<br>
	<div id="loginArea">
		<form method="post">
		<hr>
		<div class="table">
			<table class="tb" >
					<tr>
						<td colspan="2" >
							<input class="psTitle" type="text" name="email" title="이메일"  placeholder="이메일을 입력하세요"/>
						</td>
						</tr>
						<tr>
						<td>
							<input class="loginbtn" type="button" value="아이디찾기" onclick="findId_Ok(this.form)"/>
<!-- 							<input type="button" value="아이디찾기" onclick="location.href='loginController?type=findIdOk'"/> -->
						</td>
					</tr>
			</table>
			</div>
		</form>
	</div>
	
</div>
	
</body>
</html>