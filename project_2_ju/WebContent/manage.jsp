<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	
	#banner {width: 5000px;}
	
	 #frame {
        width: 1130px;
        position: relative;
        overflow: hidden;
    }
    
    table {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    width: 70%; /* 테이블 너비를 조절하여 적당한 크기로 설정합니다 */
	    max-height: 400px; /* 최대 높이를 설정하여 스크롤이 나타나도록 합니다 */
	    overflow-y: auto; /* 세로 스크롤이 필요할 때만 스크롤이 나타나도록 합니다 */
	    border-collapse: collapse; /* 테이블 경계를 병합하여 단일 경계선으로 만듭니다 */
	    border: 1px solid black; /* 테이블의 경계선을 설정합니다 */
	}
	
	.body {
	    position: relative; /* 부모 요소의 상대적 위치 설정 */
	    padding-top: 200px; /* 헤더 아래 여백을 설정합니다 */
	}
	
	caption {
   	    margin-bottom: 50px; /* 캡션 아래 여백을 추가하여 수평선과의 간격을 조절합니다 */
	}
		
	thead {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    width: 70%; /* 테이블 너비를 조절하여 적당한 크기로 설정합니다 */
	    border-bottom: none; /* thead의 아래쪽 경계선을 없앱니다 */
	}
	
	thead tr {
	    display: flex;
	    align-items: center;
	}
	
	thead select, thead input[type="text"], thead input[type="submit"] {
	    margin-right: 10px; /* 요소들 간격을 설정합니다 */
	}
	
	tbody {
/*    	    border: 1px solid black; /* 테이블 본문의 경계선을 추가합니다 */ */
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
		
// 		if (checkCategory.trim().length == 0) {
// 			alert("아이디를 입력해주세요!");
// 			return false;
// 		}
		
		var idx = frm.idx.value; // idx 값 가져오기
	    var keyword = frm.keyword.value; // keyword 값 가져오기
	    
		$.ajax ({
			type: "POST",
			url: "ajaxManageController",
			data: {
				action: "manageCategory",
				idx: idx,
				keyword: keyword
				
			},
			dataType: "json",
			success : function(respData){
				alert("Ajax 처리 성공 - 응답받은데이터 : " + respData);
// 				JSON.stringify(obj)
				console.log(respData); //JSON 객체 1개
				console.log(respData.list); //배열데이터
				
				//Json데이터처리
				let htmltag = "";
				
				for (member of respData.list) {
					htmltag += "<div id=" + member.table + ">";
					if ("review".equals(member.table)) {
						htmltag += "<tr>";
						htmltag += "<td>" + member.rvNo + "</td>";
						htmltag += "<td>" + member.mvNo + "</td>";
						htmltag += "<td>" + member.no + "</td>";
						htmltag += "<td>" + member.rvNick + "</td>";
						htmltag += "<td>" + member.rvTitle + "</td>";
						htmltag += "<td>" + member.rvContent + "</td>";
						htmltag += "<td>" + member.rvDate + "</td>";
						htmltag += "<td>" + member.rvRec + "</td>";
					}
					
					if ("movie".equals(member.table)) {
						htmltag += "<tr>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
					}
					
					if ("movie".equals(member.table)) {
						htmltag += "<tr>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
						htmltag += "<td>" + member.table + "</td>";
					}
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
</script>
<body>
    <div class="header">
    	<a href="main.jsp">
    		<img class= "icon" src="img/moviechoice.png">
		</a>
    	
        <ul class="menu">
          <li><a href="main.jsp">영화목록 관리</a></li>
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
                        <td><input type="submit" value="검색" onclick="selectCategory(this.form)"/></td>
                    </tr>
                </thead>
                <tbody class="jsonData">
                	<tr>
                		<td>검색 결과가 없습니다</td>
                	</tr>
                </tbody>
            </table>
        </form>
    </div>
</body>
</html>
