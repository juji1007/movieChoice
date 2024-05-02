<%@page import="com.mystudy.model.dao.warnDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//본인이 작성하지 않은 리뷰 추천 클릭
	//추천한 rvVo 정보
	listTotVO vo = (listTotVO)session.getAttribute("listOne");
	System.out.println(":: 추천할 vo : " + vo);
	
	//rvDetail.jsp 이동을 위해 필요한 cPage
	int cPage = (Integer)session.getAttribute("cPage");
	System.out.println(":: 추천 cPage : " + cPage);
	
	//이동하면서 넘겨준 rvNo 리뷰번호
	int rvNo = Integer.parseInt(request.getParameter("rvNo"));
	System.out.println(":: 추천 rvNo : " + rvNo);
	pageContext.setAttribute("rvNo", rvNo);
	
	//세션에 저장된 회원no
	int sessionNo = (Integer)session.getAttribute("no");
	System.out.println(":: 추천 클릭한 회원no : " + sessionNo);
	
	//처음 신고 버튼 클릭(insert)
	if (warnDAO.warnSearch(sessionNo, rvNo) == 0) {
		int result = warnDAO.clickOn(sessionNo, rvNo);
		System.out.println(":: 신고 클릭 성공 : " + result + "건");

	//신고 1번 클릭한 경우(delete)
	} else {
		int result = warnDAO.clickOff(sessionNo, rvNo);
		System.out.println(":: 추천 해제 성공 : " + result + "건");
	}
	
	//이전 페이지인 rvDetail로 이동
	response.sendRedirect("rvDetail.jsp?rvNo=" + rvNo + "&cPage=" + cPage);
	
%>