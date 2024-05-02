<%@page import="com.mystudy.model.dao.inquiryDAO"%>
<%@page import="com.mystudy.model.vo.inquiryVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 필요한 값들 가져오기
    int qaNo = Integer.parseInt(request.getParameter("qaNo")); // QA_NO를 가져와야 함
    String iqContent = request.getParameter("iqContent");

    // inquiryVO 객체 생성 및 값 설정
    inquiryVO ivo = new inquiryVO();
    ivo.setQaNo(qaNo); // 외래 키인 QA_NO를 설정해야 함
    ivo.setIqContent(iqContent);

    // inquiryDAO를 사용하여 데이터베이스에 저장
    int result = inquiryDAO.insert(ivo);

    if(result > 0) {
        // 성공적으로 저장된 경우
        response.sendRedirect("qnaAdmin.jsp");
    } else {
        // 저장에 실패한 경우
        out.println("<script>");
        out.println("alert('답변 작성에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>