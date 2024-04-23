package com.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.criticDAO;
import com.mystudy.model.dao.movieDAO;
import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.vo.criticVO;
import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.reviewVO;

@WebServlet("/controller")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FrontController doGet() 실행~~~");
		
		String type = request.getParameter("type");
		System.out.println("작업형태 type : " + type);
		if ("critic".equals(type)) {
			
			List<criticVO> clist = criticDAO.criticList();
			System.out.println("전문가목록 : " + clist);
			
			request.setAttribute("clist", clist);
			request.getRequestDispatcher("critic.jsp").forward(request, response);
		}
		if ("mvTitle".equals(type)) {
			request.getRequestDispatcher("main.jsp").forward(request, response);
		}
		if ("mvTitleList".equals(type)) {
			//1. 전달받은 파라미터 값 확인 추출(이름 : fullname)
			String mvTitle = request.getParameter("mvTitle");
			System.out.println("mvTitle : " + mvTitle);

			//2. DB에서 성명(fullname)에 있는 직원 조회(DAO 사용)
			movieVO list = movieDAO.getmvTitleList(mvTitle);
			System.out.println(list);
			
			//3. 조회된 데이터를 응답페이지(deptList.jsp)에서 사용토록 저장한다
			request.setAttribute("list", list);
			
			//4. 응답페이지(fullnameList.jsp)로 응답 위임(전가) 처리
			request.getRequestDispatcher("mvTitleList.jsp").forward(request, response);
		}

		if ("movie".equals(type)) {
			String idx = request.getParameter("idx");
			System.out.println("idx: "+ idx );
			
			//단순 페이지 전환인지 DB데이터 조회(검색)처리를 해야 하는지 결정 처리 
			
			// 동적검색 처리 작업 진행
			System.out.println(">>>> 동적검색 처리 작업 진행");
			List<movieVO> list2 = movieDAO.getMovie(idx);
			System.out.println("list2 : " + list2);
			
			//동적검색 작업 형태 확인
			String title = "";
			switch (idx) {
			case "0": title = "정렬"; break;
			case "1": title = "최신순"; break;
			case "2": title = "평점순"; break;
		
			default:
				title = "선택안함";
			}
			
			//동적검색 결과 데이터 응답페이지로 전달
			request.setAttribute("list2", list2);
			
			
			//페이지 전환(searchList.jsp 페이지에 위임)
			request.getRequestDispatcher("main.jsp").forward(request, response);
		}
		
		

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FrontController doPost() 실행~~~");
		doGet(request, response);
	}
	
	
}