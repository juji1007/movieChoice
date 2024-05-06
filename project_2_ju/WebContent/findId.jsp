<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디찾기</title>
<link rel="stylesheet" href="css/write.css">
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
	<div id="findIdArea">
		<form method="post">
			<table >
				<caption><h2>아이디찾기</h2></caption>
				<thead>
					<tr>
						<th rowspan="2">EMAIL</th>
						<td colspan="5" rowspan="2">
							<input class="psTitle" type="text" name="email" title="이메일"/>
						</td>
						<td>
<!-- 							<input class="reset" type="reset" value="초기화"> -->
						</td>
						<td>
							<input class="commitbtn" type="button" value="아이디찾기" onclick="findId_Ok(this.form)"/>
<!-- 							<input type="button" value="아이디찾기" onclick="location.href='loginController?type=findIdOk'"/> -->
						</td>
					</tr>
				</thead>
			</table>
		</form>
	</div>
	
</div>
	
</body>
</html>