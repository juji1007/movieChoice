<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입</title>
<link rel="stylesheet" href="css/write.css">
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
			url: "ajaxLoginController",
			data: {
				action: "checkDoubleId",
				id: checkId
			},
			success : function(response){
				if(response == "true") {
					alert("이미 사용중인 아이디 입니다.");
					frm.id.value = "";
					isCheckId = false;
				} else {
					alert("사용 가능한 아이디 입니다.");
					isCheckId = true;
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR.readyState : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
				isCheckId = false;
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

	function check_email(frm) {
	    var checkEmail = frm.email.value;
	    var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	    if (!emailReg.test(checkEmail) || checkEmail.trim() === '') {
	        alert("이메일 형식이 맞지 않습니다!");
	        frm.email.value = "";
	        return false;
	    }
	    return true;
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

	th {
		width : 30px;
	}
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
	<div id="loginArea">
		<form method="post">
			<table>
				<caption><h2>회원가입</h2></caption>
				<thead>
					<tr>
						<th>ID </th>
						<td colspan="2" width="40px">
							<input class="psTitle" type="text" name="id" title="아이디" />
						</td>
						<td>
							<input class="searchbtn" type="button" value="중복체크" onclick="checkId(this.form)"/>
						</td>
					</tr>
					<tr>
						<th>P/W </th>
						<td colspan="2">
							<input class="psTitle" type="password" name="pwd" title="비밀번호" />
						</td>
					</tr>
					<tr>
						<th>CHECK P/W </th>
						<td colspan="2">
							<input class="psTitle" type="password" name="pwdCheck" title="비밀번호확인" onblur="check_pwd(this.form)"/>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>NAME </th>
						<td colspan="2">
							<input class="psTitle" type="text" name="name" title="이름" />
						</td>
					</tr>
					<tr>
						<th>NICK </th>
						<td colspan="2">
							<input class="psTitle" type="text" name="nickName" title="닉네임" />
						</td>
					</tr>
					<tr>
						<th>EMAIL </th>
						<td colspan="2">
							<input class="psTitle" type="email" name="email" title="이메일" onblur="check_email(this.form)"/>
						</td>
					</tr>
					<tr>
						<th>CRITIC </th>
						<td colspan="2">
							<input class="psTitle" type="radio" name="criticCheck" title="평론가" onclick="check_critic(this.form)">
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td>
						</td>
						<td>
						</td>
						<td>
							<input class="reset" type="button" value="메인가기" onclick="javascript:location.href='main.jsp'">
							<input class="searchbtn" type="button" value="로그인가기" onclick="javascript:location.href='login_page.jsp'">
							<input class="searchbtn" type="button" value="아이디찾기" onclick="javascript:location.href='loginController?type=findId'">
							<input class="reset" type="reset" value="초기화">
							<input class="commitbtn" type="button" value="회원가입" onclick="memberJoin_ok(this.form)">
						</td>
					</tr>
				</tfoot>
				
			</table>
		</form>
	</div>
</div>
	
</body>
</html>