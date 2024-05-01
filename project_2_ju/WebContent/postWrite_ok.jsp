<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

%>	
<%-- 	<jsp:useBean id="po" class="com.mystudy.model.vo.postVO" /> --%>
<%-- 	<jsp:setProperty property="*" name="po"/> --%>

<%
	//파일 저장
	String path = application.getRealPath("/fileSave");
	File fileDir = new File(path);
	if (!fileDir.exists()) {
		fileDir.mkdirs();
	}
	MultipartRequest mr = new MultipartRequest(
			request, path, (10 * 1024 * 1024),
			"UTF-8", new DefaultFileRenamePolicy());
	
	postVO po = new postVO();
	po.setPsNick((String) session.getAttribute("nick"));
	po.setNo((Integer) session.getAttribute("no"));
	po.setPsTitle(mr.getParameter("psTitle"));
	po.setPsContent(mr.getParameter("psContent"));
	
	//첨부파일 데이터 처리
	System.out.println("mr.getFile : " + mr.getFile("psFile"));
	if(mr.getFile("psFile") != null) {
		po.setPsFile(mr.getFilesystemName("psFile"));
		po.setPsOrifile(mr.getOriginalFileName("psFile"));
	} else {
		po.setPsFile("");
		po.setPsOrifile("");
	}

	System.out.println("> write_ok.jsp po : " + po);
	int result = postDAO.insert(po);
	System.out.println(":: 입력완료 입력건수 : " + result);
	
	response.sendRedirect("free.jsp");
%>