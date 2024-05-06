<%@page import="com.mystudy.post.common.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Paging p = new Paging();

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
</head>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/manage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
// function deleteAccount(memberId) {
// 	console.log("memberId : " + memberId);
//     if (confirm("회원 탈퇴시키시겠습니까?")) {
//         $.ajax({
//             type: "POST",
//             url: "ajaxLoginController",
//             data: {
//             	action: "fireAccount",
//                 id: memberId
//             },
//             success: function(response) {
//                 if (response === "true") {
//                     // 삭제가 성공한 경우 해당 행을 화면에서 제거
//                     $("#" + memberId).remove();
//                 } else {
//                     alert("삭제 실패!");
//                 }
//             },
//             error: function(jqXHR, textStatus, errorThrown) {
//                 alert("삭제 요청 실패: " + errorThrown);
//             }
//         });
//     } else {
//     	console.log("취소");
//     }
// }

function deleteAccount(frm, memberId) {
	console.log("memberId : " + memberId);
	console.log("회원삭제실행");
	console.log(frm);
	let check = confirm("회원 탈퇴시키시겠습니까?");
    if (check) {
    	frm.action="loginController?type=deleteAccountOk&location=accountAdmin&id="+memberId;
		frm.submit();
    } else {
    }
}

function selectCategory(frm) {

	var checkCategory = frm.idx.value;
	if ("선택" == checkCategory) {
		alert("검색종류를 선택해주세요!");
		return;
	}
	
	var idx = frm.idx.value;
    var keyword = frm.keyword.value;
    
    $.ajax({
        type: "POST",
        url: "ajaxManageController",
        data: {
            action: "accountManageCategory",
            idx: idx,
            keyword: keyword
        },
        dataType: "json",
        success: function(respData) {
            console.log("Ajax 처리 성공 - 응답받은데이터:", respData);

            let htmltag = "";
            var checkAccount = 1;
            
            if (respData.length === 0) {
                // 검색 결과가 없을 때
                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
            } else {
                // 검색 결과가 있을 때
                for (let member of respData.listSearch) {
                	console.log("유저html");
                	 if (member.no === "null" || member.no.length === 0) {
                         console.log("유저없음html");
                         htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
                         break;
                     }
                	if (checkAccount > 0) {
		                htmltag += "<tr><th>관리</th><th>유저 번호</th><th>유저 이름</th><th>유저 아이디</th><th>유저 닉네임</th><th>평론가 구분</th><th>이메일</th><th>신고 수</th><th>테이블</th></tr>";
		            }
		            htmltag += "<tr id='" + member.id + "'>";
// 		            htmltag += "<td><input type='button' value='삭제' onclick=\"location.href='loginController?type=deleteAccountOk&location=accountAdmin&id=" + member.id + "&pwdCheck=" + member.pwd + "'\">";
		            htmltag += "<td><input class='h_button' type='button' value='삭제' onclick='deleteAccount(this.form, \"" + member.id + "\")'></td>";
// 		            htmltag += "<input class='up_button' type='button' value='수정' onclick='updateReview(this.form, \"" + member.rvNo + "\")'></td>";
// 		            htmltag += "<td><input type='button' value='삭제' onclick=\"location.href='checkPage.jsp?location=accountAdmin&id=" + member.id + "&pwdCheck=" + member.pwd + "'\">";
		            htmltag += "<td>" + member.no + "</td>";
		            htmltag += "<td>" + member.name + "</td>";
		            htmltag += "<td>" + member.id + "</td>";
		            htmltag += "<td>" + member.nick + "</td>";
		            htmltag += "<td>" + member.criticCheck + "</td>";
		            htmltag += "<td>" + member.email + "</td>";
		            htmltag += "<td>" + member.warn + "</td>"; 
		            htmltag += "<td>" + member.table + "</td>";
		            htmltag += "</tr>";
		            
		            checkAccount--;
                }
            }
            
            $('#jsonData').html(htmltag);
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Ajax 처리 실패:\n" +
                "jqXHR.readyState: " + jqXHR.readyState + "\n" +
                "textStatus: " + textStatus + "\n" +
                "errorThrown: " + errorThrown);
        }
    });

}
</script>
<body>
	<!-- header.jspf -->
	<%@ include file="include/headerAdmin.jspf"%>
	<div class="body">
		<hr class="color">
		<h2>유저 검색</h2>
		<div class="box">
			<div class="innerbox">
				<div class="content">
					<form method="post">
						<select class="select" name="idx">
							<option selected disabled>선택</option>
							<option value="0">전체</option>
							<option value="1">신고순</option>
							<option value="2">이름순</option>
							<option value="3">평론가</option>
						</select> 
						<input class="search" type="text" name="keyword" placeholder="이름검색" /> 
						<input class="searchbtn" type="button" value="검색" onclick="selectCategory(this.form)" />
					</form>
				</div>
			</div>
		</div>
	</div>
	<div id="post">
		<form method="post">
			<table>
				<tbody id="jsonData">
					<tr>
						<td>검색 결과가 없습니다.</td>
					</tr>
				</tbody>
				<tfoot id="pageData">
				</tfoot>
			</table>
		</form>
	</div>
</body>
</html>
