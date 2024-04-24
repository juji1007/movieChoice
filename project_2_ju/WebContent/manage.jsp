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
            action: "manageCategory",
            idx: idx,
            keyword: keyword
        },
        dataType: "json",
        success: function(respData) {
            console.log("Ajax 처리 성공 - 응답받은데이터:", respData);

            // 테이블 헤더 생성
            let htmltag = "";
            var checkMovie = 1;
            var checkReview = 1;
            var checkAccount = 1;
//             if (check of respData.listSearch) {
//             htmltag += "<table border='1'><thead><tr><th>테이블</th><th>영화 번호</th><th>제목</th><th>감독</th><th>배우</th><th>장르</th><th>평점</th><th>관람객 수</th><th>등급</th><th>개봉일</th><th>포스터</th></tr></thead><tbody>";
//             }
//             if ()
            // 영화 데이터 반복 처리
            if (respData.length === 0) {
                // 검색 결과가 없을 때
                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
            } else {
                // 검색 결과가 있을 때
                for (let member of respData.listSearch) {
                	respData.listSearch.sort((a, b) => {
                	    if (a.warn > b.warn) return -1; // 내림차순으로 정렬
                	    if (a.warn < b.warn) return 1;  // 오름차순으로 정렬
                	    return 0; // 같은 경우
                	});

                	console.log("sort : ", respData);
					if (member.table === "review") {
						console.log("리뷰html");
						if (checkReview > 0) {
							htmltag += "<tr><th>테이블</th><th>리뷰 번호</th><th>영화 번호</th><th>유저 번호</th><th>유저 닉네임</th><th>리뷰 제목</th><th>리뷰 내용</th><th>리뷰 작성일</th><th>리뷰 추천수</th><th>신고 수</th><th>관리</th></tr>";
						}
						htmltag += "<tr class='" + member.table + "'>";
						htmltag += "<td>" + member.table + "</td>";
			            htmltag += "<td>" + member.rvNo + "</td>";
			            htmltag += "<td>" + member.mvNo + "</td>";
			            htmltag += "<td>" + member.no + "</td>";
			            htmltag += "<td>" + member.rvNick + "</td>";
			            htmltag += "<td>" + member.rvTitle + "</td>";
			            htmltag += "<td>" + member.rvContent + "</td>";
			            htmltag += "<td>" + member.rvDate + "</td>";
			            htmltag += "<td>" + member.rvRec + "</td>";
			            htmltag += "<td>" + member.warn + "</td>";
			            htmltag += "<td><input type='button' value='삭제' onclick='delete(this.form, review)'>";
			            htmltag += "<input type='button' value='수정' onclick='updateReview(this.form)'></td>";
			            htmltag += "</tr>";
			            
			            checkReview--;
						checkMovie = 1;
						checkAccount = 1;
			        }
			        
			        if (member.table === "movie") {
			        	console.log("영화html");
						if (checkMovie > 0) {
							htmltag += "<tr><th>테이블</th><th>영화 번호</th><th>제목</th><th>감독</th><th>배우</th><th>장르</th><th>평점</th><th>관람객 수</th><th>등급</th><th>개봉일</th><th>포스터</th><th>관리</th></tr>";
						}
			        	htmltag += "<tr class='" + member.table + "'>";
			            htmltag += "<td>" + member.table + "</td>";
			            htmltag += "<td>" + member.mvNo + "</td>";
			            htmltag += "<td>" + member.mvTitle + "</td>";
			            htmltag += "<td>" + member.mvDirect + "</td>";
			            htmltag += "<td>" + member.mvActor + "</td>";
			            htmltag += "<td>" + member.mvGenre + "</td>";
			            htmltag += "<td>" + member.mvRate + "</td>";
			            htmltag += "<td>" + member.mvAudience + "</td>";
			            htmltag += "<td>" + member.mvGrade + "</td>";
			            htmltag += "<td>" + member.mvDate + "</td>";
			            htmltag += "<td><img src='img/" + member.mvPoster + "' width='200'></td>";
// 			            htmltag += "<td colspan='2'><input type='button' value='삭제' onclick='delete(this.form, movie, " + member.mvNo + ")'>";
			            htmltag += "<td colspan='2'><input type='button' value='삭제' onclick=\"location.href='controller?type=movieDelete&mvNo=" + member.mvNo + "'\">";
			            htmltag += "<input type='button' value='수정' onclick=\"location.href='controller?type=movieFix&mvNo=" + member.mvNo + "'\"></td>";
			            htmltag += "</tr>";
			            
			            checkMovie--;
			            checkReview = 1;
			            checkAccount = 1;
			        }
			        
			        if (member.table === "account") {
			            console.log("유저html");
			            if (checkAccount > 0) {
			                htmltag += "<tr><th>테이블</th><th>유저 번호</th><th>유저 이름</th><th>유저 아이디</th><th>유저 닉네임</th><th>평론가 구분</th><th>이메일</th><th>신고 수</th><th>관리</th></tr>";
			            }
			            htmltag += "<tr class='" + member.table + "'>";
			            htmltag += "<td>" + member.table + "</td>";
			            htmltag += "<td>" + member.no + "</td>";
			            htmltag += "<td>" + member.name + "</td>";
			            htmltag += "<td>" + member.id + "</td>";
			            htmltag += "<td>" + member.nick + "</td>";
			            htmltag += "<td>" + member.critic_check + "</td>";
			            htmltag += "<td>" + member.email + "</td>";
			            htmltag += "<td>" + member.warn + "</td>"; 
			            htmltag += "<td colspan='2'><input type='button' value='삭제' onclick='deleteAccount(this.form, account)'>";
			            htmltag += "<input type='button' value='수정' onclick='updateAccount()'></td>";
			            htmltag += "</tr>";

			            checkAccount--;
			            checkReview = 1;
			            checkMovie = 1;
			        }
				}
            }
//             htmltag += "</tbody>";

            // 테이블을 #jsonData 엘리먼트에 추가
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
    <div class="header">
    	<a href="main.jsp">
    		<img class= "icon" src="img/moviechoice.png">
		</a>
    	
        <ul class="menu">
          <li><a href="mainAdmin.jsp">영화목록 관리</a></li>
          <li><a href="reviewMain.jsp">리뷰모음 관리</a></li>
          <li><a href="free.jsp">자유게시판 관리</a></li>
          <li><a href="about.asp">Q & A 관리</a></li>
          <li><a href="about.asp">Review Of The Month 관리</a></li>
          <li><a href="about.asp">평론가 관리</a></li>
          <li><a href="about.asp">유저 관리</a></li>
        </ul>
        <hr class="mint">
    </div>
    <div class="body">
        <form method="post"> 
            <table>
                <caption><h2>관리자 검색</h2></caption>
                <thead> 
                    <tr>
                        <td>
                            <select name="idx">
                                <option selected disabled>선택</option>
                                <option value="0">전체</option>
                                <option value="1">리뷰</option>
                                <option value="2">영화</option>
                                <option value="3">유저</option>
                            </select>
                        </td>
                        <td><input type="text" name="keyword"/></td>
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
