package com.project.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
		
		request.setCharacterEncoding("UTF-8");
		
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

			if(mvTitle == null || mvTitle.trim().length() == 0)
				request.getRequestDispatcher("main.jsp").forward(request, response);
			
			movieVO list = movieDAO.getmvTitleList(mvTitle);
			System.out.println(list);
			
//			if(list == null) {
//				request.getRequestDispatcher("main.jsp").forward(request, response);
//			}
			
			request.setAttribute("list", list);
			
//			request.getRequestDispatcher("movieDetail.jsp?mvNo=${mvDetail.mvNo }").forward(request, response);
			request.getRequestDispatcher("mvTitleList.jsp").forward(request, response);
		}
		if ("movieDelete".equals(type)) {
			String location = request.getParameter("location");
			System.out.println("location : " + location);
			int mvNo = Integer.parseInt(request.getParameter("mvNo"));
			System.out.println("mvNo : " + mvNo);
			
			request.setAttribute("mvNo", mvNo);
			
			int result = movieDAO.delete(mvNo);
			
			if ("mainAdmin".equals(location)) {
				request.getRequestDispatcher("mainAdmin.jsp").forward(request, response);
			}
			request.getRequestDispatcher("manage.jsp").forward(request, response);
		}
		if ("movieFix".equals(type)) {
			String location = request.getParameter("location");
			System.out.println("location : " + location);
			int mvNo = Integer.parseInt(request.getParameter("mvNo"));
			System.out.println("mvNo : " + mvNo);
			
			request.setAttribute("mvNo", mvNo);
			// movieFix를 페이지를 만들고 movieFixOk에서 location 처리하는 것도 생각
//			if ("mainAdmin".equals(location)) {
//				request.getRequestDispatcher("movieFixOk.jsp?location="+location).forward(request, response);
//			}
			request.getRequestDispatcher("movieFixOk.jsp?location="+location).forward(request, response);
		}
		
		// 관리자 페이지에서 수정
		if ("movieFixOk".equals(type)) {
			System.out.println("dao실행");
			int mvNo = Integer.parseInt(request.getParameter("mvNo"));
			String mvTitle = request.getParameter("mvTitle");
		    String mvDirect = request.getParameter("mvDirect");
		    String mvActor = request.getParameter("mvActor");
		    String mvGenre = request.getParameter("mvGenre");
		    int mvRate = Integer.parseInt(request.getParameter("mvRate"));
		    String mvDateStr = request.getParameter("mvDate");
		    java.util.Date utilDate = null;
		    java.sql.Date sqlDate = null;
		    try {
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		        utilDate = sdf.parse(mvDateStr);
		        sqlDate = new java.sql.Date(utilDate.getTime());
		    } catch (ParseException e) {
		        e.printStackTrace();
		    }
		    
		    movieVO mvo = new movieVO();
		    mvo.setMvDate(sqlDate);
		    String mvAudience = request.getParameter("mvAudience");
		    String mvGrade = request.getParameter("mvGrade");
		    String mvPoster = request.getParameter("mvPoster");
		    mvo.setMvNo(mvNo);
		    mvo.setMvTitle(mvTitle);
		    mvo.setMvDirect(mvDirect);
		    mvo.setMvActor(mvActor);
		    mvo.setMvGenre(mvGenre);
		    mvo.setMvRate(mvRate);
		    mvo.setMvAudience(mvAudience);
		    mvo.setMvGrade(mvGrade);
		    mvo.setMvPoster(mvPoster);
		    
//			System.out.println("mvNo : " + mvNo);
		    System.out.println("resultconrotenkqlknwk : " + mvo);
			int result = movieDAO.update(mvo);
			System.out.println("resultresultconrotenkqlknwk : " + result);
			String location = request.getParameter("location");
			System.out.println("mainadmin locatuib: " + location);
			if ("mainAdmin".equals(location)) {
				request.getRequestDispatcher("mainAdmin.jsp").forward(request, response);
			}
			request.getRequestDispatcher("manage.jsp").forward(request, response);
		}
		
		if ("movieInsertOK".equals(type)) {
			System.out.println("movieInsertOK실행");
			// 영화 데이터 받기
			String mvTitle = request.getParameter("mvTitle");
			System.out.println("mvTitle" + mvTitle);
		    String mvDirect = request.getParameter("mvDirect");
		    String mvActor = request.getParameter("mvActor");
		    String mvGenre = request.getParameter("mvGenre");
		    int mvRate = Integer.parseInt(request.getParameter("mvRate"));
		    String mvDateStr = request.getParameter("mvDate");
		    java.util.Date utilDate = null;
		    java.sql.Date sqlDate = null;
		    try {
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		        utilDate = sdf.parse(mvDateStr);	
		        sqlDate = new java.sql.Date(utilDate.getTime());
		    } catch (ParseException e) {
		        e.printStackTrace();
		    }
		    
		    movieVO mvo = new movieVO();
		    mvo.setMvDate(sqlDate);
		    String mvAudience = request.getParameter("mvAudience");
		    String mvGrade = request.getParameter("mvGrade");
		    String mvPoster = request.getParameter("mvPoster");
		    //영화번호 search해서 뽑아야될듯
//		    mvo.setMvNo(11);
		    mvo.setMvTitle(mvTitle);
		    mvo.setMvDirect(mvDirect);
		    mvo.setMvActor(mvActor);
		    mvo.setMvGenre(mvGenre);
		    mvo.setMvRate(mvRate);
		    mvo.setMvAudience(mvAudience);
		    mvo.setMvGrade(mvGrade);
		    mvo.setMvPoster(mvPoster);
		    
		    System.out.println("mvo : " + mvo);
		    int result = movieDAO.insert(mvo);
		    if (result != 1) {
		    	System.out.println("실패");
		    	request.getRequestDispatcher("movieInsert.jsp").forward(request, response);
		    }
			request.getRequestDispatcher("mainAdmin.jsp").forward(request, response);
			
			
		}
		
		if ("movie".equals(type)) {
			String idx = request.getParameter("idx");
			System.out.println("idx: "+ idx );
			
			if (idx == null) {
				request.getRequestDispatcher("main.jsp").forward(request, response);
			}
			
			
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
			request.getRequestDispatcher("main2.jsp").forward(request, response);
		}
		
		if ("movieAdmin".equals(type)) {
			String idx = request.getParameter("idx");
			System.out.println("idx: "+ idx );
			
			if (idx == null) {
				request.getRequestDispatcher("mainAdmin.jsp").forward(request, response);
			}
			
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
			request.getRequestDispatcher("mainAdmin2.jsp").forward(request, response);
		}
		
		

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FrontController doPost() 실행~~~");
		doGet(request, response);
	}
	
	
}