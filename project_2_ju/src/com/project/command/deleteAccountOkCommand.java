package com.project.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	    
	    // 아이디 DB에서 조회
	    AccountVO avo = AccountDAO.getAccountLogin(id, pwd);
	    if (avo == null) {
	    	System.out.println("avo는 널");
	    	//인증안됬으므로 myPage로
	    	return "myPage.jsp";
	    } else {
		    int delNo = avo.getNo();
		    AccountDAO.delete(delNo);
		    return "logout.jsp";
	    }
	    
	}
}
