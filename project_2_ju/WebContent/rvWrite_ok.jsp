<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//리뷰 작성
	request.setCharacterEncoding("UTF-8");
%>
	<%-- enctype="multipart/form-data" 사용시 setProperty 값 설정안됨 --%>
	<jsp:useBean id="voList" class="com.mystudy.model.vo.reviewVO" />
	<jsp:setProperty property="*" name="voList"/>
	
	<hr>
	
<%
	reviewVO vo = new reviewVO();
	
	vo.setNo((Integer) session.getAttribute("no"));
	vo.setRvNick((String) session.getAttribute("nick"));
	//rvNo 임의 7
	vo.setRvNo(7);
	//vo.getRvNo();
	
	//듄 mvNo = 4
	vo.setMvNo(4);
	System.out.println(vo.getMvNo());
	
	vo.setRvRate(Integer.parseInt(request.getParameter("rate")));
	vo.setRvTitle(request.getParameter("subject"));
	vo.setRvContent(request.getParameter("content"));
	System.out.println(">> write_ok.jsp vo :" + vo);
	
	int result = reviewDAO.insert(vo);
	System.out.println(":: 입력 건수 " + result);
	
	response.sendRedirect("rvDetail.jsp?rvNo=" + vo.getRvNo());
%>