<%@page import="com.mystudy.model.dao.recDAO"%>
<%@page import="com.mystudy.model.dao.listTotDAO"%>
<%@page import="com.mystudy.model.vo.listTotVO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
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
	
	//처음 추천하기 버튼 클릭(insert)
	if (recDAO.recSearch(sessionNo, rvNo) == 0) {
		int result = recDAO.clickOn(sessionNo, rvNo);
		System.out.println(":: 추천 클릭 성공 : " + result + "건");

	//추천하기 1번 클릭한 경우(delete)
	} else {
		int result = recDAO.clickOff(sessionNo, rvNo);
		System.out.println(":: 추천 해제 성공 : " + result + "건");
	}
	
	//이전 페이지인 rvDetail로 이동
	response.sendRedirect("rvDetail.jsp?rvNo=" + rvNo + "&cPage=" + cPage);
	
	
	//무한정 추천 클릭 기능
// 	System.out.println("추천 클릭 가능~~");
// 	int rvRec = vo.getRvRec(); //추천 적용 전 rec수
//  	System.out.println("추천 후 rvRec 전 : " + rvRec);
	
// 	int result = reviewDAO.recCnt(rvNo, rvRec);
// 	System.out.println(">> 추천클릭 result : " + result + "건수");
	
// 	listTotVO recVo =  listTotDAO.selectOne(rvNo);
// 	System.out.println("추천 후 rvRec 수 : " + recVo.getRvRec());
// 	System.out.println("<< 추천 vo 조회 recVo :" + recVo);
	
//  response.sendRedirect("rvDetail.jsp?rvNo=" + rvNo + "&cPage=" + cPage);
%>
