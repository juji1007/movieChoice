<%@page import="com.mystudy.model.vo.postVO"%>
<%@page import="com.mystudy.model.dao.warnDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//본인이 작성하지 않은 게시물 추천 클릭
	//신고한 rvVo 정보
	postVO vo = (postVO)session.getAttribute("pvo");
	System.out.println(":: 신고할 vo : " + vo);
	
	//freeView.jsp 이동을 위해 필요한 cPage
	String cPage = (String)session.getAttribute("cPage");
	System.out.println(":: 신고 cPage : " + cPage);
	
	//이동하면서 넘겨준 psNo 리뷰번호
	int psNo = Integer.parseInt(request.getParameter("psNo"));
	System.out.println(":: 신고 psNo : " + psNo);
	pageContext.setAttribute("rvNo", psNo);
	
	//세션에 저장된 회원no
	int sessionNo = (Integer)session.getAttribute("no");
	System.out.println(":: 신고 클릭한 회원no : " + sessionNo);
	
	//처음 신고 버튼 클릭(insert)
	if (warnDAO.warnSearchPost(sessionNo, psNo) == 0) {
		int result = warnDAO.clickOnPost(sessionNo, psNo);
		System.out.println(":: 신고 클릭 성공 : " + result + "건");

	//신고 1번 클릭한 경우(delete)
	} else {
		int result = warnDAO.clickOffPost(sessionNo, psNo);
		System.out.println(":: 신고 해제 성공 : " + result + "건");
	}
	
	//이전 페이지인 rvDetail로 이동
	response.sendRedirect("freeView.jsp?psNo=" + psNo + "&cPage=" + cPage);
	
%>