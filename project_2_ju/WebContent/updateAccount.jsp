<%@page import="com.project.vo.AccountVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<%
	request.setCharacterEncoding("UTF-8");

	AccountVO avo = (AccountVO) request.getAttribute("avo");
	System.out.println("avo : " + avo);
	
	request.setAttribute("avo", avo);
	String location = request.getParameter("loaction");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원정보수정</title>
<link rel="stylesheet" href="css/write.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	var check = false;
	
	function check_pwd(frm) {
		var pwd = frm.pwd.value;
		var checkPwd = frm.pwdCheck.value;
		
		if(pwd != checkPwd) {
			alert("비밀번호와 비밀번호확인 값이 다릅니다!");
			frm.pwdCheck.value="";
			check = false;
			return false;
		}
		check = true;
		return true;
	}
	
	function check_critic(frm) {
	var checkCritic = frm.elements["criticCheck"];
		if (checkCritic.checked) {
		    checkCritic.value = "1";
		    location.href="criticApply.jsp?location=myPage&id=<%=avo.getId() %>";
		} else {
		    checkCritic.value = "0";
		}
	}
	
	function update(frm) {
		
		if(!check) {
			alert("비밀번호와 비밀번호확인 값이 다릅니다!");     
			frm.pwdCheck.value="";
			return;
		}
		
	    if (confirm("회원정보를 수정 하시겠습니까?")) {
	    	
	        frm.action = "loginController?type=updateAccountOk";
	        frm.submit();
	        
	    } else {
	    	
	    }
	}
	
	function list_go() {
	    location.href = "myPage.jsp";
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
	<div id="FixArea">
		<form method="post">
			<table>
				<caption><h2>회원정보수정</h2></caption>
				<thead border>
				    <tr>
				        <th>NAME</th>
<!-- 				        <th>이름</th> -->
				        <td colspan="3">
				            <input class="psTitle" type="text" name="name" title="이름" value="<%= avo.getName() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>P/W</th>
<!-- 				        <th>비밀번호</th> -->
				        <td colspan="3">
				            <input class="psTitle" type="password" name="pwd" title="비밀번호" value="<%= avo.getPwd() %>"/>
				        </td>
				    </tr>
				    <tr>
						<th>CHECK P/W </th>
<!-- 						<th>비밀번호확인</th> -->
						<td colspan="3">
							<input class="psTitle" type="password" name="pwdCheck" title="비밀번호확인" onblur="check_pwd(this.form)"/>
						</td>
					</tr>
				    <tr>
				        <th>NICK</th>
				        <td colspan="3">
				            <input class="psTitle" type="text" name="nick" title="닉네임" value="<%= avo.getNick() %>" />
				        </td>
				    </tr>
				    <tr>
				        <th>EMAIL</th>
				        <td colspan="3">
				            <input class="psTitle" type="text" name="email" title="이메일" value="<%= avo.getEmail() %>" />
				        </td>
				    </tr>
				    <tr>
					    <th>CRITIC</th>
					    <td colspan="3">
					        <input class="psTitle" type="radio" name="criticCheck" title="평론가" value="1"
					            <c:if test="${avo.getCriticCheck() == 1}">
					                checked
					            </c:if>
					        <c:if test="${avo.getCriticCheck() != 1}">
					            onclick="check_critic(this.form)"
					        </c:if>
					        />
					    </td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<input type="hidden" name="no" value="<%= avo.getNo()%>" />
						</td>
						<td colspan="3" width="20%">
							<input class="reset" type="reset" value="초기화"/>
							<input class="commitbtn" type="button" value="수정하기" onclick="update(this.form)"/>
<!-- 							 <input class="searchbtn" type="button" value="마이페이지" onclick="list_go()"> -->
						</td>
					</tr>
				</tbody>
				
			</table>
		</form>
	</div>
</div>
	
</body>
</html>