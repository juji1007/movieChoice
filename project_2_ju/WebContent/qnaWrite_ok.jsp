<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.post.common.Paging"%>
<%@page import="com.mystudy.model.dao.qnaDAO"%>
<%@page import="com.mystudy.model.vo.qnaVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 필요한 값들 가져오기
    int no = (Integer) session.getAttribute("no");
    String nick = request.getParameter("nick");
    String qaTitle = request.getParameter("qaTitle");
    String qaContent = request.getParameter("qaContent");
    String qaCategory = request.getParameter("qaCategory");
	
    // qnaVO 객체 생성 및 값 설정
    qnaVO qo = new qnaVO();
    qo.setNo(no);
    qo.setNick(nick);
    qo.setQaTitle(qaTitle);
    qo.setQaContent(qaContent);
    if (!qaCategory.equals("선택")) {
    	qo.setQaCategory(qaCategory);
    }

    // qnaDAO를 사용하여 데이터베이스에 저장
    int result = qnaDAO.insert(qo);

    if(result > 0) {
        // 성공적으로 저장된 경우
        response.sendRedirect("qna.jsp");
    } else {
        // 저장에 실패한 경우
        out.println("<script>");
        out.println("alert('게시글 작성에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>