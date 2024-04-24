<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	//int no = (int) session.getAttribute("no");
	//System.out.println(no);
	
	//String nick = (String) session.getAttribute("nick");
	//System.out.println(nick);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
	<h1>리뷰 작성하기</h1>
    <form action="reviewController?type=rvWrite" method="get">
        <label for="movie">영화 선택:</label>
        <select id="movie" name="movie">
            <option value="1">쿵푸팬더4</option>
            <option value="2">파묘</option>
            <option value="3">댓글부대</option>
        </select>
        <label for="rate">평점</label>
        <input type="number" id="rate" name="rate" min="0" max="10" required>
        <br><br>
        <label for="username">작성자</label>
        <input type="text" id="username" name="username" value="${nick }">
        <br><br>
        <label for="title">제목</label>
        <input id="title" name="title" required>
        <br><br>
        <label for="comment">내용</label><br>
        <textarea id="comment" name="comment" rows="4" cols="50" required></textarea>
        <br><br>
        <input type="submit" value="등록하기">
        <input type="reset" value="초기화">
        <input type="button" value="리뷰목록" onclick="rvList()">
    </form>
    
</body>
</html>