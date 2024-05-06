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
<style>

img.icon {
	position: absolute;
	left: 200px;
	top: 60px;
}

li {
	float: left;
	display: block;
	padding: 10px 26px;
	font-size: 18px;
}

a {
	text-decoration: none;
	color: black;
}

ul.menu {
	position: absolute;
	list-style-type: none;
	margin: 0;
	padding: 0;
	top: 60px;
	left: 530px;
}

li a:hover {
	color: #56BEC0;
	font-weight: bold;
}

hr.mint {
	background-color: #56BEC0;
	height: 3px;
	margin-top: 120px;
}

ul.login {
	position: absolute;
	list-style-type: none;
	margin: 0;
	padding: 0;
	top: 60px;
	right: 200px;
}

ul.login li {
	padding: 12px 5px;
	font-size: 14px;
}

hr.gray {
	background-color: D9D9D9;
	height: 1px;
}

#banner {
	width: 5000px;
}

#frame {
	width: 1130px;
	position: relative;
	overflow: hidden;
}

table {
/* 	position: absolute; */
	top: 50%;
	left: 50%;
  	transform: translate(200px, -10px);  
  	margin-top: -10%;
  	margin-right: 15px;
	width: 80%;
	max-height: 400px;
	overflow-y: auto;
	border-collapse: collapse;
	border: 1px solid black;
}

.body {
	position: relative;
	padding-top: 200px;
}

caption {
	margin-bottom: 50px;
}

th, td {
    border: 1px solid black; /* 테이블 경계선 설정 */
    padding: 8px; /* 셀 안의 여백 설정 */
    text-align: center; /* 가운데 정렬 */
}

thead {
/* 	position: absolute; */
/* 	top: 50%; */
/* 	left: 50%; */
/* 	transform: translate(-50%, -50%); */
/* 	width: 70%; */
 	border: 1px solid black;  
}

thead tr, thead td{
	display: flex;
	align-items: center;
	border: none; 
}

thead select, thead input[type="text"], thead input[type="submit"] {
	margin-right: 10px;
}

tbody th tr td{
	border: 1px solid black; 
	
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function deleteAccount(memberId) {
	console.log("memberId : " + memberId);
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "ajaxLoginController",
            data: {
            	action: "fireAccount",
                id: memberId
            },
            success: function(response) {
                if (response === "true") {
                    // 삭제가 성공한 경우 해당 행을 화면에서 제거
                    $("#" + memberId).remove();
                } else {
                    alert("삭제 실패!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("삭제 요청 실패: " + errorThrown);
            }
        });
    } else {
    	console.log("취소");
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
                	if (checkAccount > 0) {
		                htmltag += "<tr><th>관리</th><th>유저 번호</th><th>유저 이름</th><th>유저 아이디</th><th>유저 닉네임</th><th>평론가 구분</th><th>이메일</th><th>신고 수</th><th>테이블</th></tr>";
		            }
		            htmltag += "<tr id='" + member.id + "'>";
// 		            htmltag += "<td><input type='button' value='삭제' onclick=\"location.href='loginController?type=deleteAccountOk&location=accountAdmin&id=" + member.id + "&pwdCheck=" + member.pwd + "'\">";
		            htmltag += "<td colspan='2'><input type='button' value='삭제' onclick='deleteAccount(" + member.id + ")'></td>";
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
	<%@ include file="include/headerAdmin.jspf" %>
	
    <div class="body">
        <form method="post"> 
            <table>
                <caption><h2>유저 검색</h2></caption>
                <thead> 
                    <tr>
                        <td>
                            <select name="idx">
                                <option selected disabled>선택</option>
                                <option value="0">전체</option>
                                <option value="1">신고순</option>
                                <option value="2">이름순</option>
                                <option value="3">평론가</option>
<!--                                 <option value="4">등급순</option> -->
                            </select>
                        </td>
                        <td><input type="text" name="keyword" placeholder="이름검색"/></td>
                        <td><input type="button" value="검색" onclick="selectCategory(this.form)"/></td>
                    </tr>
                </thead>
                <tbody id="jsonData">
                	<tr>
                		<td>검색 결과가 없습니다.</td>
                	</tr>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
