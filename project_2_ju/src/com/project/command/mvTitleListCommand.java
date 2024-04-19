package com.project.command;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.movieDAO;
import com.mystudy.model.vo.movieVO;

public class mvTitleListCommand implements Command{
	
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 전달받은 파라미터 값 확인 추출(이름 : fullname)
		String mvTitle = request.getParameter("mvTitle");
		System.out.println("mvTitle : " + mvTitle);

		//2. DB에서 성명(fullname)에 있는 직원 조회(DAO 사용)
		movieVO list = movieDAO.getmvTitleList(mvTitle);
		
		//3. 조회된 데이터를 응답페이지(deptList.jsp)에서 사용토록 저장한다
		request.setAttribute("list", list);
		
		//4. 응답페이지(fullnameList.jsp)로 응답 위임(전가) 처리
		//request.getRequestDispatcher("mvTitleList.jsp").forward(request, response);
		request.setCharacterEncoding("UTF-8");
		
		return "mvTitleList.jsp";
	}

}
