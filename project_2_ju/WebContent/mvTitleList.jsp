<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화제목으로 검색</title>
</head>
<body>
<h1>영화검색</h1>
	<ul>
	<c:forEach var="vo" items="${list }">
		<li>
			${vo.mvGenre }, 
			${vo.mvTitle }, 
			${vo.mvGrade },
			${vo.mvDirect },
			${vo.mvActor },
			${vo.mvAudience },
			${vo.mvActor }
		</li>
	</c:forEach>
	</ul>
</body>
</html>