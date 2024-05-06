package com.project.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.criticDAO;
import com.project.dao.AccountDAO;
import com.project.vo.AccountVO;

public class deleteAccountOkCommand implements Command{
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 유저정보 받기
	    String id = request.getParameter("id");
	    String pwd = request.getParameter("pwdCheck");
	    System.out.println("delid : " + id);
	    System.out.println("delpw : " + pwd);
	    
	    String location = request.getParameter("location");
	    System.out.println("location : " + location);
	    if ("admin".equals(location)) {
	    	// 아이디 DB에서 조회
		    AccountVO avoAdmin = AccountDAO.getAccount(id);
		    pwd = avoAdmin.getPwd();
	    	System.out.println("delpw11 : " + avoAdmin);
	    }
	    if ("accountAdmin".equals(location)) {
	    	// 아이디 DB에서 조회
		    AccountVO avoAdmin = AccountDAO.getAccount(id);
		    pwd = avoAdmin.getPwd();
	    	System.out.println("delpw11 : " + avoAdmin);
	    }
	    // 아이디 DB에서 조회
	    AccountVO avo = AccountDAO.getAccountLogin(id, pwd);
	    if (avo == null) {
	    	System.out.println("avo는 널");
	    	if ("admin".equals(location)) {
	    		//인증안됬으므로 manage로
			    return "manage.jsp";
		    } else if ("accountAdmin".equals(location)) {
		    	return "accountManage.jsp";
		    } else {
		    	//인증안됬으므로 myPage로
		    	return "myPage.jsp";
		    }
	    } else {
		    int delNo = avo.getNo();
		    criticDAO.delete(delNo);
		    AccountDAO.delete(delNo);
		    if ("admin".equals(location)) {
			    return "manage.jsp";
		    } else if ("accountAdmin".equals(location)) {
		    	return "accountManage.jsp";
		    }
		    return "logout.jsp";
	    }
	    
	}
}
