package com.project.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.mystudy.model.dao.movieDAO;
import com.mystudy.model.vo.movieVO;

public class MovieCommand implements Command{
	
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idx = request.getParameter("idx");
		System.out.println("idx: "+ idx);
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
		request.setAttribute("title", title);
		
		//페이지 전환(searchList.jsp 페이지에 위임)
		//request.getRequestDispatcher("searchList.jsp").forward(request, response);
		
		return "main.jsp";
	}

}

