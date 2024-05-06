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

import com.mystudy.model.dao.movieDAO;
import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.reviewVO;
import com.project.dao.AccountDAO;
//import com.project.dao.AdminDAO;
import com.project.dao.AdminDAO;

@WebServlet("/ajaxMovieController")
public class AjaxMovieController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		System.out.println("action :" + action);
		//영화중복체크
		if ("checkDoubleMovie".equals(action)) {
			//영화정보가져오기
			String mvTitle = req.getParameter("mvTitle");
			String mvDirect = req.getParameter("mvDirect");
			System.out.println("checkmvTitle : " + mvTitle);
			System.out.println("checkmvDirect : " + mvDirect);
			//DB에서 영화체크
			Boolean idDoubleCheck = movieDAO.getMovieSearchCheckDup(mvTitle, mvDirect); //있으면 true
			//응답
			System.out.println(idDoubleCheck);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().write(String.valueOf(idDoubleCheck));
		}
		//영화 삭제
		if ("deleteMovie".equals(action)) {
			int mvNo = Integer.parseInt(req.getParameter("mvNo"));
			System.out.println("delete mvNo : " + mvNo);
			//DB에서 영화삭제
			int result = movieDAO.delete(mvNo);
			//응답
			boolean movieDeleteCheck = false;
			if (result != -1) movieDeleteCheck = true;
			System.out.println(movieDeleteCheck);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().write(String.valueOf(movieDeleteCheck));
		}
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
