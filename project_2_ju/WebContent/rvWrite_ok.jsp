<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//리뷰 작성
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="rvVo" class="com.mystudy.model.vo.reviewVO" />
	<jsp:setProperty property="*" name="rvVo"/>
	\${rvVo } : ${rvVo }
	<hr>
<%
	reviewVO vo = new reviewVO();
	
	//int mvNo = Integer.parseInt(request.getParameter("mvNo"));
	int no = (Integer) session.getAttribute("no");
	String rvNick = request.getParameter("rvNick");
	String rvTitle = request.getParameter("rvTitle");
	String rvContent = request.getParameter("rvContent");
	//vo.setMvNo(mvNo);
	vo.setNo(no);
	vo.setRvNick(rvNick);
	vo.setRvTitle(rvTitle);
	vo.setRvContent(rvContent);
	System.out.println(">> write_ok.jsp vo :" + vo);
	
	int result = reviewDAO.insert(vo);
	System.out.println(":: 입력 건수 " + result);
	
	response.sendRedirect("reviewMain.jsp");
// 	response.sendRedirect("rvDetail.jsp?rvNo=" + vo.getRvNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>