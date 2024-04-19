<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	var isCheckId = false;
	
	function checkId(frm) {
// 		var checkId = form.elements["id"];
		var checkId = frm.id.value;
		if (checkId.trim().length == 0) {
			alert("아이디를 입력해주세요!");
			return false;
		}
		$.ajax ({
			type: "POST",
			url: "ajaxController",
			data: {
				action: "checkDoubleId",
				id: checkId
			},
			success : function(response){
				if(response == "true") {
					alert("이미 사용중인 아이디 입니다.");
					frm.id.value = "";
					return false;
				} else {
					alert("사용 가능한 아이디 입니다.");
					isCheckId = true;
					return true;
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
				return false;
			}
		});
	}
	
	function check_pwd(frm) {
		var pwd = frm.pwd.value;
		var checkPwd = frm.pwdCheck.value;
		
		if(pwd != checkPwd) {
			alert("비밀번호와 비밀번호확인 값이 다릅니다!");
			frm.pwdCheck.value="";
			return false;
		}
		return true;
	}
	
	function check_critic(frm) {
    var checkCritic = frm.elements["criticCheck"];
    if (checkCritic.checked) {
        checkCritic.value = "1";
    } else {
        checkCritic.value = "0";
    }
}

	
	function memberJoin_ok(frm) {
		
		if(!isCheckId) {
			alert("아이디 중복체크를 먼저 해주세요!");
			return;
		}
		
		frm.action="loginController?type=memberJoinOk";
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
				<caption><h2>회원가입</h2></caption>
				<thead>
					<tr>
						<th>아이디</th>
						<td colspan="3">
							<input type="text" name="id" title="아이디" />
							<input type="button" value="아이디중복체크" onclick="checkId(this.form)"/>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td colspan="3">
							<input type="password" name="pwd" title="비밀번호" />
						</td>
					</tr>
					<tr>
						<th>비밀번호확인</th>
						<td colspan="3">
							<input type="password" name="pwdCheck" title="비밀번호확인" onblur="check_pwd(this.form)"/>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>이름</th>
						<td colspan="3">
							<input type="text" name="name" title="이름" />
						</td>
					</tr>
					<tr>
						<th>닉네임</th>
						<td colspan="3">
							<input type="text" name="nickName" title="닉네임" />
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th>주소</th> -->
<!-- 						<td colspan="3"> -->
<!-- 							<input type="text" name="address" title="주소" /> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr>
						<th>이메일</th>
						<td colspan="3">
							<input type="text" name="email" title="이메일" />
						</td>
					</tr>
					<tr>
						<th>평론가인증</th>
						<td colspan="3">
							<input type="radio" name="criticCheck" title="평론가" onclick="check_critic(this.form)"/>
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
							<input type="button" value="회원가입하기" onclick="memberJoin_ok(this.form)"/>
						</td>
					</tr>
				</tfoot>
				
			</table>
		</form>
	</div>
</body>
</html>