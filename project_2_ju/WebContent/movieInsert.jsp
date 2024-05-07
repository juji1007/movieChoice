<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영화추가</title>
<link rel="stylesheet" href="css/mheader.css">
<!-- <link rel="stylesheet" href="css/footer.css"> -->
<link rel="stylesheet" href="css/write.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	var isCheckDup = false;
	
	function checkDup(frm) {
// 		var checkId = form.elements["id"];
		var checkMovieTitle = frm.mvTitle.value;
		var checkMovieDirect = frm.mvDirect.value;
		
		//특정 입력조건 필요
		if (!/^[\s,가-힣]+$/.test(checkMovieDirect)) {
			alert("형식에 맞지않습니다.")
			frm.mvDirect.value = "";
			return false;
		}
		
		console.log(checkMovieDirect);
		if (checkMovieTitle.trim().length == 0) {
			alert("영화제목을 입력해주세요!");
			return false;
		}
		
		if (checkMovieDirect.trim().length == 0) {
			alert("영화감독을 입력해주세요!");
			return false;
		}
		$.ajax ({
			type: "POST",
			url: "ajaxMovieController",
			data: {
				action: "checkDoubleMovie",
				mvTitle: checkMovieTitle,
				mvDirect: checkMovieDirect
			},
			success : function(response){
				if(response == "true") {
					alert("이미 존재하는 영화 입니다.");
					frm.id.value = "";
					return false;
				} else {
					alert("추가 가능한 영화 입니다.");
					isCheckDup = true;
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
	
	function movieInsert_ok(frm) {
		
		if(!isCheckDup) {
			alert("영화 중복체크를 먼저 해주세요!");
			return;
		}
		
		frm.action="controller?type=movieInsertOK";
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
	<!-- header.jspf -->
	<%@ include file="include/headerAdmin.jspf" %>

<div class="body">
	<div id="movieInserArea">
		<form method="post">
			<table>
				<caption><h2>영화추가</h2></caption>
				<thead>
					<tr>
						<th>영화제목</th>
						<td colspan="2">
							<input class="rvRate" type="text" name="mvTitle" title="영화제목" />
						</td>
						<td>
							<input class="h_button" type="button" value="중복체크" onclick="checkDup(this.form)"/>
						</td>
					</tr>
					<tr>
						<th>영화감독</th>
						<td colspan="3">
							<input class="rvRate" type="text" name="mvDirect" title="영화감독" placeholder="쉼표와 공백 한글로만 작성"/>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<td colspan="3"> -->
<!-- 								<input class="h_button" type="button" value="중복체크" -->
<!-- 									 onclick="checkDup(this.form)"/> -->
<!-- 						</td> -->
<!-- 					</tr> -->
				</thead>
				<tbody>
					<tr>
						<th>영화출연진</th>
						<td colspan="3">
							<input class="rvRate" type="text" name="mvActor" title="영화출연진"/>
						</td>
					</tr>
					<tr>
						<th>영화장르</th>
						<td colspan="3">
							<input class="rvRate" type="text" name="mvGenre" title="영화장르" />
						</td>
					</tr>
					<tr>
						<th>영화평점</th>
						<td colspan="3">
							<input class="rvRate" type="number" name="mvRate" title="영화평점" />
						</td>
					</tr>
					<tr>
						<th>영화누적관객</th>
						<td colspan="3">
							<input class="rvRate" type="text" name="mvAudience" title="영화누적관객" />
						</td>
					</tr>
					<tr>
						<th>영화관람가</th>
						<td colspan="3">
							<input class="rvRate" type="text" name="mvGrade" title="영화관람가"/>
						</td>
					</tr>
					<tr>
						<th>영화개봉일</th>
						<td colspan="3">
							<input class="rvRate"  type="date" name="mvDate" title="영화개봉일"/>
						</td>
					</tr>
					<tr>
						<th>영화포스터</th>
						<td colspan="3">
							<input class="rvRate" id="file2" type="file" name="mvPoster" title="영화포스터"/>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="1">
						</td>
						<td colspan="4">
							<input class="reset" type="reset" value="초기화"/>
							<input class="commitbtn" type="button" value="영화 추가" onclick="movieInsert_ok(this.form)"/>
						</td>
					</tr>
					<tr>
					</tr>
				</tfoot>
				
			</table>
		</form>
	</div>
</div>
	
	<!-- footer.jspf -->
	<%@ include file="include/footer.jspf" %>
</body>
</html>