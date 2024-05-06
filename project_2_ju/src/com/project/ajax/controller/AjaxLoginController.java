package com.project.ajax.controller;


import java.io.IOException;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.reviewVO;
import com.project.dao.AccountDAO;
//import com.project.dao.AdminDAO;
import com.project.dao.AdminDAO;

@WebServlet("/ajaxLoginController")
public class AjaxLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
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
		
		//회원탈퇴
		if ("fireAccount".equals(action)) {
			//아이디가져오기
			String id = req.getParameter("id");
			System.out.println("checkFireid : " + id);
			int no = AccountDAO.getAccountNo(id);
			//DB에서 아이디 체크
			int idFired = AccountDAO.delete(no);
			boolean idFiredCheck = false;
			if (idFired != -1) idFiredCheck = true;
			//응답
			System.out.println(idFiredCheck);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().write(String.valueOf(idFiredCheck));
			
		}
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		doGet(req, resp);
	}

}
