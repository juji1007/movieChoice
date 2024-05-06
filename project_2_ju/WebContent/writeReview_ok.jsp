<%@page import="com.mystudy.model.vo.movieVO"%>
<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.reviewDAO"%>
<%@page import="com.mystudy.model.vo.reviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 필요한 값들 가져오기
    int no = (Integer) session.getAttribute("no");
    String rvNick = (String) session.getAttribute("nick"); 
    int mvNo = Integer.parseInt(request.getParameter("mvNo"));
    int rvRate = Integer.parseInt(request.getParameter("rvRate"));
    String rvTitle = request.getParameter("rvTitle");
    String rvContent = request.getParameter("rvContent");
	
    // reviewVO 객체 생성 및 값 설정
   reviewVO rvo = new reviewVO();
    rvo.setNo(no);
    rvo.setRvNick(rvNick);
    rvo.setMvNo(mvNo);
    rvo.setRvNick(rvNick);
    rvo.setRvRate(rvRate);
    rvo.setRvTitle(rvTitle);
   rvo.setRvContent(rvContent);

    // reviewDAO를 사용하여 데이터베이스에 저장
    int result = reviewDAO.insert(rvo);

    if(result > 0) {
        // 성공적으로 저장된 경우
        response.sendRedirect("reviewController?category=rvMain");
    } else {
        // 저장에 실패한 경우
        out.println("<script>");
        out.println("alert('리뷰 작성에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>