package com.project.ajax.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.dao.AccountDAO;

@WebServlet("/ajaxController")
public class AjaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		System.out.println("action :" + action);
		//아이디중복체크
		if ("checkDoubleId".equals(action)) {
			//아이디가져오기
			String checkId = req.getParameter("id");
			System.out.println("checkid : " + checkId);
			//DB에서 아이디 체크
			Boolean idDoubleCheck = AccountDAO.getAccountSearchLoginCheckId(checkId);
			//응답
			System.out.println(idDoubleCheck);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().write(String.valueOf(idDoubleCheck));
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
