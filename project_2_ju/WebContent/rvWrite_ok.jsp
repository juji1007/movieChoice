<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	//리뷰 작성
	request.setCharacterEncoding("UTF-8");

	int mvNo = Integer.parseInt(request.getParameter("mvNo"));
	System.out.println("mvNo : " + mvNo);
	
	//최종 rvNo 번호의 +1 추출
%>
	<%-- enctype="multipart/form-data" 사용시 setProperty 값 설정안됨 --%>
	<jsp:useBean id="voList" class="com.mystudy.model.vo.reviewVO" />
	<jsp:setProperty property="*" name="voList"/>
<%
 	reviewVO vo = new reviewVO();
	
	vo.setRvNo(7);
	vo.setMvNo(mvNo);
	vo.setNo((Integer) session.getAttribute("no"));
	vo.setRvNick((String) session.getAttribute("nick"));
	vo.setRvTitle(request.getParameter("rvTitle"));
	vo.setRvContent(request.getParameter("rvContent"));
	vo.setRvRate(Integer.parseInt(request.getParameter("rvRate")));
	
	
 	int result = reviewDAO.insert(voList);
 	System.out.println(":: 입력 건수 " + result);
	System.out.println(">> write_ok.jsp 삽입 후 vo :" + vo);
	
// 	request.setAttribute("rvVo", vo);
	
	response.sendRedirect("reviewMain.jsp");
// 	response.sendRedirect("rvDetail.jsp");
//	response.sendRedirect("rvDetail.jsp?rvNo=" + vo.getRvNo());
%>