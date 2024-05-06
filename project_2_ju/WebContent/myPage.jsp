<%@page import="com.project.mybatis.DBService"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="com.mystudy.model.dao.movieDAO"%>
<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
	request.setCharacterEncoding("UTF-8");

	//account
	
	//movie 추천이네 이런거
	
	//review 추천 + 내가쓴거
	
	//post 추천 + 내가쓴거
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPage</title>
<!-- style 태그 -->
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/myPage.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<!-- style 태그 -->
<link rel="stylesheet" href="css/myPage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	window.onpopstate = function(event) {
	    // 뒤로가기 이벤트 감지
	    location.reload(); // 페이지 새로고침
	};

	function deleteAccount(frm) {
		console.log("회원삭제실행");
		console.log(frm);
		let check = confirm("회원 탈퇴하시겠습니까?");
	    if (check) {
	    	frm.action="loginController?type=deleteAccount";
			frm.submit();
	    } else {
	    }
	}
	function updateAccount(frm) {
		console.log("회원정보수정실행");
		console.log(frm);
		let check = confirm("회원 정보를 수정하시겠습니까?");
	    if (check) {
	    	frm.action="loginController?type=updateAccount";
			frm.submit();
	    } else {
	    }
	}
	function deleteReview(frm, rvNo) {
		console.log("리뷰정보삭제실행");
		console.log(frm);
		let check = confirm("리뷰 정보를 삭제하시겠습니까?");
	    if (check) {
	    	frm.action="rvDelete.jsp?location=myPage&rvNo="+rvNo;
			frm.submit();
	    } else {
	    }
	}
	function updateReview(frm, rvNo) {
		console.log("리뷰정보수정실행");
		console.log(frm);
		let check = confirm("리뷰 정보를 수정하시겠습니까?");
	    if (check) {
	    	frm.action="rvUpdate.jsp?location=myPage&rvNo="+rvNo;
			frm.submit();
	    } else {
	    }
	}
	function updatePost(frm, psNo) {
		console.log("자유게시판정보수정실행");
		console.log(frm);
		let check = confirm("자유게시판 정보를 수정하시겠습니까?");
	    if (check) {
	    	frm.action="freeView.jsp?psNo="+psNo;
			frm.submit();
	    } else {
	    }
 	}
	function deletePost(frm, psNo) {
		console.log("자유게시판정보삭제실행");
		console.log(frm);
		let cDelete = confirm("해당 댓글내역도 모두 삭제됩니다.\n 정말로 삭제하시겠습니까?");
	    if (cDelete) {
	    	frm.action="postDelete.jsp?location=myPage&psNo="+psNo;
			frm.submit();
	    } else {
	    }
	}
	function deletePsComment(frm, pcNo) {
		console.log("댓글정보삭제실행");
		console.log(frm);
		let check = confirm("댓글을 삭제하시겠습니까?");
	    if (check) {
	    	frm.action="postComment_del_ok.jsp?location=myPage&pcNo="+pcNo;
			frm.submit();
	    } else {
	    }
	}
	function deleteQna(frm, qaNo) {
		console.log("qna정보삭제실행");
		console.log(frm);
		let check = confirm("QnA를 삭제하시겠습니까?");
	    if (check) {
	    	frm.action="qnaDeleteOk.jsp?location=myPage&qaNo="+qaNo;
			frm.submit();
	    } else {
	    }
	}
	window.onload = function() {
		getAccountInfo();
		getReviewInfo();
		getPostInfo();
		getPostCommentInfo();
		getQnaInfo();
	};
	
	function getAccountInfo() {
		
		$.ajax({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "accountMypage"
			},
			dataType: "json",
			 success: function(respData) {
	            console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
	            
	            let htmltag = "";
	       	    // 데이터 처리
	            if (respData.length === 0) {
	                // 검색 결과가 없을 때
	                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	            } else {
	                // 검색 결과가 있을 때
	                console.log("유저html");
	                for (let member of respData.listSearch) {
	                	 if (member.table === "account") {
	 			            htmltag += "<tr><th>회원번호</th><td>" + member.no + "</td></tr>";
	 			            htmltag += "<tr><th>이름</th><td>" + member.name + "</td></tr>";
	 			            htmltag += "<tr><th>아이디</th><td>" + member.id + "</td></tr>";
	 			            htmltag += "<tr><th>닉네임</th><td>" + member.nick + "</td></tr>";
	 			            htmltag += "<tr><th>평론가 구분</th><td>" + member.criticCheck + "</td></tr>";
	 			            htmltag += "<tr><th>이메일</th><td>" + member.email + "</td></tr>";
	 			            htmltag += "<tr><th>신고 수</th><td>" + member.warn + "</td></tr>"; 
	 			            htmltag += "</tr>";
	 			        }
	                }
	            }
	       	    
	            $('#accountThead').html(htmltag);
		            
		            let footerHtml = "<tr>";
		            footerHtml += "<td colspan='2'>";
		            footerHtml += "<input class='searchbtn' type='button' value='회원탈퇴' onclick='deleteAccount(this.form)'>";
		            footerHtml += "<input class='commitbtn' type='button' value='회원정보 수정 및 평론가 신청' onclick='updateAccount(this.form)'>";
		            footerHtml += "<input class='reset' type='button' value='평론가 탈퇴' onclick=\"location.href='criticCancelWrite.jsp'\">";
		            footerHtml += "</td>";
		            footerHtml += "</tr>";

	            	$('#accountTbody').html(footerHtml);
			 },
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert("Ajax 처리 실패:\n" +
		                "jqXHR.readyState: " + jqXHR.readyState + "\n" +
		                "textStatus: " + textStatus + "\n" +
		                "errorThrown: " + errorThrown);
		        }

		});
	}
	
		
	function getReviewInfo() {
		
		$.ajax({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "reviewMypage"
			},
			dataType: "json",
			 success: function(respData) {
	            console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
	            
	            let htmltag = "";
	       	    // 데이터 처리
	            if (respData.length === 0) {
	                // 검색 결과가 없을 때
	                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	            } else {
	                // 검색 결과가 있을 때
	                 console.log("리뷰html");
	                htmltag += "<tr><th>리뷰 번호</th><th>영화 번호</th><th>유저 번호</th><th>유저 닉네임</th><th>리뷰 제목</th><th>리뷰 내용</th><th>리뷰 작성일</th><th>리뷰 추천수</th><th>신고 수</th><th>관리</th></tr>";
	                for (let member of respData.listSearch) {
	                	 if (member.table === "review") {
	                		 
	                		 if (member.no === "null" || member.no.length === 0) {
	                			 console.log("리뷰없음html");
	                			 htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	                			 break;
	                		 }
	 			            htmltag += "<tr>";
	 			            htmltag += "<td>" + member.rvNo + "</td>";
				            htmltag += "<td>" + member.mvNo + "</td>";
				            htmltag += "<td>" + member.no + "</td>";
				            htmltag += "<td>" + member.rvNick + "</td>";
				            htmltag += "<td>" + member.rvTitle + "</td>";
				            htmltag += "<td>" + member.rvContent + "</td>";
				            htmltag += "<td>" + member.rvDate + "</td>";
				            htmltag += "<td>" + member.rvRec + "</td>";
				            htmltag += "<td>" + member.warn + "</td>";
 	 			            htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick='deleteReview(this.form, \"" +  member.rvNo + "\")'>";
 	 			            htmltag += "<input class='up_button' type='button' value='수정' onclick='updateReview(this.form, \"" + member.rvNo + "\")'></td>";
 	 			            htmltag += "</tr>";
	 			        }
	                }
	            }
	       	    
	            $('#reviewThead').html(htmltag);
		            
			 },
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert("Ajax 처리 실패:\n" +
		                "jqXHR.readyState: " + jqXHR.readyState + "\n" +
		                "textStatus: " + textStatus + "\n" +
		                "errorThrown: " + errorThrown);
		        }

		});
	}
	
	function getPostInfo() {
		
		$.ajax({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "postMypage"
			},
			dataType: "json",
			 success: function(respData) {
	            console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
	            
	            let htmltag = "";
	       	    // 데이터 처리
	            if (respData.length === 0) {
	                // 검색 결과가 없을 때
	                 console.log("Ajax 처리 성공 - 응답받은데이터없음:", respData);
	                htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	            } else {
	                // 검색 결과가 있을 때
	                console.log("포스트html");
	                htmltag += "<tr><th>자유게시판 번호</th><th>유저 번호</th><th>유저 닉네임</th><th>자유게시판 제목</th><th>자유게시판 내용</th><th>자유게시판 작성일</th><th>자유게시판 첨부파일</th><th>신고 수</th><th>관리</th></tr>";
	                for (let member of respData.listSearch) {
	                	 if (member.table === "post") {
	                		 
	                		if (member.no === "null" || member.no.length === 0) {
	                			 console.log("포스트없음html");
	                			 htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	                			 break;
	                		}
	 			            htmltag += "<tr>";
	 			           htmltag += "<td><a href='freeView.jsp?psNo=" + member.psNo + "'>" + member.psNo + "</a></td>";
				            htmltag += "<td>" + member.no + "</td>";
				            htmltag += "<td>" + member.psNick + "</td>";
				            htmltag += "<td>" + member.psTitle + "</td>";
				            htmltag += "<td>" + member.psContent + "</td>";
				            htmltag += "<td>" + member.psDate + "</td>";
				            htmltag += "<td>" + member.psFile + "</td>";
				            htmltag += "<td>" + member.psWarn + "</td>";
 	 			            htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick='deletePost(this.form, \"" + member.psNo + "\")'>";
 	 			            htmltag += "<input class='up_button' type='button' value='수정' onclick='updatePost(this.form, \"" + member.psNo + "\")'></td>";
 	 			            htmltag += "</tr>";
	 			        }
	                }
	            }
	       	    
	            $('#postThead').html(htmltag);
		            
			 },
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert("Ajax 처리 실패:\n" +
		                "jqXHR.readyState: " + jqXHR.readyState + "\n" +
		                "textStatus: " + textStatus + "\n" +
		                "errorThrown: " + errorThrown);
		        }

		});
	}
	
	function getPostCommentInfo() {
		
		$.ajax({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "postCommentMypage"
			},
			dataType: "json",
			 success: function(respData) {
				console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
	            let htmltag = "";
	       	    // 데이터 처리
	            if (respData.length === 0) {
	                // 검색 결과가 없을 때
	                 htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	            } else {
	                // 검색 결과가 있을 때
	                console.log("포스트댓글html");
	                htmltag += "<tr><th>댓글 번호</th><th>자유게시판 번호</th><th>유저 닉네임</th><th>댓글 작성일</th><th>댓글 내용</th><th>관리</th></tr>";
	                for (let member of respData.listSearch) {
	                	 if (member.table === "postComment") {
	                		if (member.no === "null" || member.no.length === 0) {
	                			 console.log("댓글없음html");
	                			 htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	                			 break;
	                		}
	 			            htmltag += "<tr>";
	 			            htmltag += "<td>" + member.pcNo + "</td>";
	 			            htmltag += "<td><a href='freeView.jsp?psNo=" + member.psNo + "'>" + member.psNo + "</a></td>";
				            htmltag += "<td>" + member.pcNick + "</td>";
				            htmltag += "<td>" + member.pcDate + "</td>";
				            htmltag += "<td>" + member.pcContent + "</td>";
//  	 			            htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick=\"location.href='postComment_del_ok.jsp?location=myPage&pcNo=" + member.pcNo + "'\"></td>";
//  	 			            htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick='deletePsComment(this.form)'></td>";
 	 			            htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick='deletePsComment(this.form, \"" + member.pcNo + "\")'></td>";
 	 			            htmltag += "</tr>";
	 			        }
	                }
	            }
	       	    
	            $('#postCommentThead').html(htmltag);
		            
			 },
		        error: function(jqXHR, textStatus, errorThrown) {
		            alert("Ajax 처리 실패:\n" +
		                "jqXHR.readyState: " + jqXHR.readyState + "\n" +
		                "textStatus: " + textStatus + "\n" +
		                "errorThrown: " + errorThrown);
		        }

		});
	}
	
	function getQnaInfo() {
		
		$.ajax({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "qnaMypage"
			},
			dataType: "json",
			 success: function(respData) {
				console.log("Ajax 처리 성공 - 응답받은데이터:", respData);
	            let htmltag = "";
	       	    // 데이터 처리
	            if (respData.length === 0) {
	                // 검색 결과가 없을 때
	                 htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	            } else {
	                // 검색 결과가 있을 때
	                console.log("qnahtml");
	                htmltag += "<tr><th>QnA 번호</th><th>QnA 내용</th><th>QnA 작성일</th><th>QnA 카테고리</th><th>QnA 답변 유무</th><th>관리</th></tr>";
	                for (let member of respData.listSearch) {
	                    if (member.table === "qna") {
	                        if (member.no === "null" || member.no.length === 0) {
	                            console.log("qna없음html");
	                            htmltag += "<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>";
	                            break;
	                        }
	                        htmltag += "<tr>";
	                        htmltag += "<td><a href='qnaView.jsp?qaNo=" + member.qaNo + "'>" + member.qaNo + "</a></td>";
	                        htmltag += "<td>" + member.qaContent + "</a></td>";
	                        htmltag += "<td>" + member.qaDate + "</td>";
	                        htmltag += "<td>";
	                        if (member.qaCategory !== "null") {
	                            htmltag += member.qaCategory;
	                        }
	                        htmltag += "</td>";
	                        htmltag += "<td id ='inquiryCheck'>";
	                        if (member.inquiryCheck === "true") {
	                            htmltag += "<span style='color: red;'>답변이 있습니다.</span>";
	                        } else {
	                            htmltag += "<span>답변이 없습니다.</span>";
	                        }
	                        htmltag += "</td>";

// 	                        htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick='deleteQna(this.form)'></td>";
	                        htmltag += "<td colspan='2'><input class='h_button' type='button' value='삭제' onclick='deleteQna(this.form, \"" + member.qaNo + "\")'></td>";
// 	                        htmltag += "<input type='hidden' name='location' value='myPage'>";
	                        htmltag += "</tr>";
	                    }
	                }

	            }
	       	    
	            $('#qnaThead').html(htmltag);
		            
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
	<%@ include file="include/header.jspf" %>

<!-- 회원정보조회 
	 회원정보수정
	 회원탈퇴
-->
<div class="infoPage">
<div id="frame">
	<form method="post">
		<table id="accountTable">
			<caption>나의 회원정보</caption>
			<thead id="accountThead">
				<tr>
					<th>이름</th>
					<td>검색결과가없습니다</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td></td>
				</tr>
				<tr>
					<th>평론가 구분</th>
					<td></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td></td>
				</tr>
				<tr>
					<th>신고 수</th>
					<td></td>
				</tr>
			</thead>
			<tbody id="accountTbody">
				<tr>
					<td><input class="h_button" type="button" value='회원정보삭제' onclick='delete(this.form, review)'></td>
					<td><input class="up_button" type="button" value='회원정보수정' onclick='updateReview(this.form)'></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<hr>
<div id="frame">
	<form method="post">
		<table id="reviewTable">
			<caption>나의 리뷰정보</caption>
			<thead id="reviewThead">
				<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>
			</thead>
			<tbody id="reviewTbody">
				<tr>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<hr>
<div id="frame">
	<form method="post">
		<table id="postTable">
			<caption>나의 자유게시판정보</caption>
			<thead id="postThead">
				<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>
			</thead>
		</table>
	</form>
</div>
<hr>
<div id="frame">
	<form method="post">
		<table id="postComment">
			<caption>나의 댓글정보</caption>
			<thead id="postCommentThead">
				<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>
			</thead>
		</table>
	</form>
</div>
<hr>
<div id="frame">
	<form method="post">
		<table id="qna">
			<caption>나의 QnA정보</caption>
			<thead id="qnaThead">
				<tr><td colspan='11'>검색 결과가 없습니다.</td></tr>
			</thead>
		</table>
	</form>
</div>
</div>
</body>
</html>