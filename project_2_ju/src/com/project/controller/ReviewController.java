package com.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.vo.reviewVO;

@WebServlet("/reviewController")
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//리뷰메인 페이지
		String type = request.getParameter("type");
		System.out.println("type : " + type);
		
		request.setCharacterEncoding("UTF-8");

		//리뷰 선택(영화명,작성자,작성일) 검색
		String category = request.getParameter("category");
		System.out.println("category : " + category);
		
		if ("selectOne".equals(category)) {
			System.out.println(">> selectOne 요청 처리~~");
			
			String idx = request.getParameter("idx");
			String keyword = request.getParameter("keyword");
			request.setAttribute("keyword", keyword);
			
			System.out.println("keyword : " + keyword);
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			if (keyword == null || keyword.trim().length() == 0) {
				request.getRequestDispatcher("reviewMain.jsp").forward(request, response);
				//키워드 입력 alert(); 출력
				
				return;
			}
			
			List<reviewVO> listOne = reviewDAO.selectOne(idx, keyword);
			System.out.println("list : " + listOne);
			
			String sort = "";
			switch(idx) {
			case "0" : sort="영화명"; break;
			case "1" : sort="작성자"; break;
			case "2" : sort="작성일"; break;
			}
			
			request.setAttribute("listOne", listOne);
			request.setAttribute("sort", sort);
			
			request.getRequestDispatcher("selectOne.jsp").forward(request, response);
			
			return;
		}
		
/*		
		//리뷰 상세보기
		type = request.getParameter("type");
		System.out.println("type : " + type);
		
		if ("rvDetail".equals(type)) {
			System.out.println(">> rvDetail 페이지");
			
			int mvNo = Integer.parseInt(request.getParameter("mvNo"));
			int rvNo = Integer.parseInt(request.getParameter("rvNo"));
			System.out.println("mvNo : " + mvNo);
			System.out.println("rvNo : " + rvNo);
			
			reviewVO rvOne = reviewDAO.mvNoRv(mvNo, rvNo);
			System.out.println("rvOne : " + rvOne);
			
			movieVO mvOne = movieDAO.searchOne(mvNo);
			System.out.println("mvOne : " + mvOne);
			
			request.setAttribute("rvOne", rvOne);
			request.setAttribute("mvOne", mvOne);
			
			request.getRequestDispatcher("rvDetail.jsp").forward(request, response);
			
			return;
		}
		
		//추천수 sum 계산
		if ("rvRecommand".equals(type)) {
			System.out.println(">> rvRecommand 페이지");
			
			//rvNo, rvRec 가져오기
			
		}
*/		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
