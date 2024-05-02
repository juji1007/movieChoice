package com.project.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.project.dao.AccountDAO;
import com.project.vo.AccountVO;

public class LoginCommand implements Command{

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		//아이디, 비번 받기
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
//	 	System.out.println("id : " + id);
		
		//아이디, 비번 DB에서 조회
		AccountVO avo = AccountDAO.getAccountLogin(id, pwd);
		System.out.println("avo : " + avo);
		
		if (avo == null) {
			System.out.println("avo는 널");
			session.setAttribute("id", "null");
		}
		else {
			session.setAttribute("no", avo.getNo());
			session.setAttribute("id", avo.getId());
			session.setAttribute("nick", avo.getNick());
		}
		return "login.jsp";
	}
	
}
