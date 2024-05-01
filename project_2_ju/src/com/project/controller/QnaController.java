package com.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.qnaDAO;
import com.mystudy.model.vo.qnaVO;


@WebServlet("/qnaController")
public class QnaController extends HttpServlet { 
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("QnaController doGet() 실행");
		
		String type = request.getParameter("type");
		System.out.println("작업형태 type : " + type);
		
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		request.setCharacterEncoding("UTF-8");
		
		if ("qnaList".equals(search)) {
			System.out.println(">> qnaList 요청 처리");
			
			String idx = request.getParameter("idx");
			String keyword = request.getParameter("keyword");
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			if (keyword == null || keyword.trim().length() == 0) {
				request.getRequestDispatcher("qna.jsp").forward(request, response);
				return;
			}
			
			List<qnaVO> listOne = qnaDAO.qnaList(idx, keyword);
			System.out.println("listOne : " + listOne);
			
			String sort = "";
			switch(idx) {
			case "0" : sort="작성일"; break;
			}
			
			request.setAttribute("listOne", listOne);
			request.setAttribute("sort", sort);
			
			request.getRequestDispatcher("qnaList.jsp").forward(request, response);
		
		}
	}
		
		
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("QnaController doPost() 실행");
			doGet(request, response);
}
}
