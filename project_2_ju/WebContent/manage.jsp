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
<link rel="stylesheet" href="css/mheader.css">
<link rel="stylesheet" href="css/manage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function deleteAccount(memberId) {
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
// function deleteAccount(frm, memberId) {
// 	console.log("memberId : " + memberId);
// 	console.log("회원삭제실행");
// 	console.log(frm);
// 	let check = confirm("회원 탈퇴시키시겠습니까?");
//     if (check) {
//     	frm.action="loginController?type=deleteAccountOk&location=accountAdmin&id="+memberId;
// 		frm.submit();
//     } else {
//     }
// }
function deleteMovie(mvNo) {
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "ajaxMovieController",
            data: {
            	action: "deleteMovie",
            	mvNo: mvNo
            },
            success: function(response) {
                if (response === "true") {
                    // 삭제가 성공한 경우 해당 행을 화면에서 제거
                    $("#" + mvNo).remove();
                } else {
                    alert("삭제 실패!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("삭제 요청 실패: " + errorThrown);
            }
        });
    }
}




  function deleteReview(rvNo) {
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            type: "POST",
            url: "ajaxReviewController",
            data: {
            	action: "deleteReview",
            	rvNo: rvNo
            },
            success: function(response) {
                if (response === "true") {
                    // 삭제가 성공한 경우 해당 행을 화면에서 제거
                    $("#" + rvNo).remove();
                } else {
                    alert("삭제 실패!");
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert("삭제 요청 실패: " + errorThrown);
            }
        });
    }
}



function selectCategory(frm) {
	var checkCategory = frm.idx.value;
	var keyword = frm.querySelector('input[name="keyword"]');
    var search = frm.querySelector('input[type="button"]');
	if ("0" == checkCategory) {
		keyword.style.display = "none";
		search.style.display = "inline-block";
	} else if ("1" == checkCategory) {
		keyword.style.display = "inline-block";
		keyword.placeholder = "리뷰 제목 검색";  //keyword 형식 지정해야함
        search.style.display = "inline-block";
	} else if ("2" == checkCategory) {
		keyword.style.display = "inline-block";
		keyword.placeholder = "영화 제목 검색";
        search.style.display = "inline-block";
	} else { 
		keyword.style.display = "inline-block";
		keyword.placeholder = "유저 이름 검색";
        search.style.display = "inline-block";
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
            // 데이터 반복 처리
            if (respData.length === 0) {
                // 검색 결과가 없을 때
                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
            } else {
                // 검색 결과가 있을 때
                respData.listSearch.sort((a, b) => {
                	    if (a.warn > b.warn) return -1; // 내림차순으로 정렬
                	    if (a.warn < b.warn) return 1;  // 오름차순으로 정렬
                	    return 0; // 같은 경우
                });
                for (let member of respData.listSearch) {
                	console.log("sort : ", respData);
					if (member.table === "review") {
						console.log("리뷰html");
						if (member.no === "null" || member.no.length === 0) {
                            console.log("리뷰없음html");
                            htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
                            break;
                        }
						if (checkReview > 0) {
							htmltag += "<tr><th>관리</th><th>리뷰 번호</th><th>영화 번호</th><th>유저 번호</th><th>유저 닉네임</th><th>리뷰 제목</th><th>리뷰 내용</th><th>리뷰 작성일</th><th>리뷰 추천수</th><th>신고 수</th><th>테이블</th></tr>";
						}
						htmltag += "<tr id='" + member.rvNo + "'>";
						htmltag += "<td><input class='h_button' type='button' value='삭제' onclick='deleteReview(" + member.rvNo + ")'></td>";
			            htmltag += "<td>" + member.rvNo + "</td>";
			            htmltag += "<td>" + member.mvNo + "</td>";
			            htmltag += "<td>" + member.no + "</td>";
			            htmltag += "<td>" + member.rvNick + "</td>";
			            htmltag += "<td>" + member.rvTitle + "</td>";
			            htmltag += "<td>" + member.rvContent + "</td>";
			            htmltag += "<td>" + member.rvDate + "</td>";
			            htmltag += "<td>" + member.rvRec + "</td>";
			            htmltag += "<td>" + member.warn + "</td>";
// 			            htmltag += "<td><input type='button' value='삭제' onclick=\"location.href='rvDelete.jsp?location=admin&rvNo=" + member.rvNo + "'\">";
						htmltag += "<td>" + member.table + "</td>";
			            htmltag += "</tr>";
			            
			            checkReview--;
						checkMovie = 1;
						checkAccount = 1;
			        }
			        
			        if (member.table === "movie") {
			        	console.log("영화html");
			        	if (member.mvNo === "null" || member.mvNo.length === 0) {
                            console.log("영화없음html");
                            htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
                            break;
                        }
						if (checkMovie > 0) {
							htmltag += "<tr><th>관리</th><th>영화 번호</th><th>제목</th><th>감독</th><th>배우</th><th>장르</th><th>평점</th><th>관람객 수</th><th>등급</th><th>개봉일</th><th>포스터</th><th>테이블</th></tr>";
						}
			        	htmltag += "<tr id='" + member.mvNo + "'>";
			        	htmltag += "<td><input class='h_button' type='button' value='삭제' onclick='deleteMovie(" + member.mvNo + ")'>";
			            htmltag += "<input class='up_button' type='button' value='수정' onclick=\"location.href='controller?type=movieFix&mvNo=" + member.mvNo + "'\"></td>";
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
			            htmltag += "<td>" + member.table + "</td>";
			            htmltag += "</tr>";
			            
			            checkMovie--;
			            checkReview = 1;
			            checkAccount = 1;
			        }
			        
			        if (member.table === "account") {
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
// 			            htmltag += "<td><input class='h_button' type='button' value='삭제' onclick=\"location.href='checkPage.jsp?location=admin&id="+ member.id + "'\">";
			            htmltag += "<td><input class='h_button' type='button' value='삭제' onclick='deleteAccount(" + member.id + ")'></td>";
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
			            checkReview = 1;
			            checkMovie = 1;
			        }
				}
            }

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
	<%@ include file="include/headerAdmin.jspf" %>
    <div class="body">
    <h2>관리자페이지에서는 모두 강제 삭제됩니다.</h2>
    <hr class="color">
    <h2>관리자 검색</h2>

		<div class="box">
		<div class="innerbox">
		<div class="content">
		 <form method="post"> 
		 <select class="select" name="idx">
                                <option value="0">전체</option>
                                <option value="1">리뷰</option>
                                <option value="2">영화</option>
                                <option value="3">유저</option>
         </select>
              <input class="search" type="text" name="keyword" placeholder="." style="display:none;"/>
              <input class="searchbtn" type="button" value="검색" style="display:inline-block;" onclick="selectCategory(this.form)"/>
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