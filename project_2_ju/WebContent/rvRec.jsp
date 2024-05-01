<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천수 count</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	//history.go(-1);
</script>
</head>
<body>
<%
	//본인 리뷰가 아닌 경우만 추천 클릭 가능!
	listTotVO vo = (listTotVO)session.getAttribute("listOne");
	System.out.println(":: 추천할 vo : " + vo);

	int cPage = (Integer)session.getAttribute("cPage");
	System.out.println(":: 추천 cPage : " + cPage);
	
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	System.out.println(":: 추천 rvNo : " + rvNo);
	pageContext.setAttribute("rvNo", rvNo);
	
	int sessionNo = (Integer)session.getAttribute("no");
	System.out.println(":: 추천 클릭한 회원no : " + sessionNo);
	
	
	System.out.println("추천 클릭 가능~~");
	int rvRec = vo.getRvRec(); //추천 적용 전 rec수
 	System.out.println("추천 후 rvRec 전 : " + rvRec);
	
	int result = reviewDAO.recCnt(rvNo, rvRec);
	System.out.println(">> 추천클릭 result : " + result + "건수");
	
	listTotVO recVo =  listTotDAO.selectOne(rvNo);
	System.out.println("추천 후 rvRec 수 : " + recVo.getRvRec());
	System.out.println("<< 추천 vo 조회 recVo :" + recVo);
	
 	response.sendRedirect("rvDetail.jsp?rvNo=" + rvNo + "&cPage=" + cPage);
%>
	
</body>
</html>