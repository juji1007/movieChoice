package com.project.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.dao.AccountDAO;
import com.project.vo.AccountVO;

public class deleteAccountCommand implements Command{
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		// 유저정보 받기
	    String id = (String) session.getAttribute("id");
	    System.out.println("upid : " + id);
	    
	    // 아이디 DB에서 조회
	    AccountVO avo = AccountDAO.getAccount(id);
	    
	    request.setAttribute("avo", avo);
	    
		return "deleteAccount.jsp";
	}
}
