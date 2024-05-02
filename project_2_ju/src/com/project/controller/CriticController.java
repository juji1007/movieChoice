package com.project.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.criticDAO;
import com.mystudy.model.vo.criticVO;

@WebServlet("/criticController")
public class CriticController extends HttpServlet { 
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("CriticController doGet() 실행~~~");
		
		String type = request.getParameter("type");
		System.out.println("작업형태 type : " + type);
		
		request.setCharacterEncoding("UTF-8");
		
		//전문가 신청 페이지
		if ("criticApply".equals(type)) {
			System.out.println("criticApply 요청 처리");
			
			request.setCharacterEncoding("UTF-8");
			
			int no = Integer.parseInt(request.getParameter("no")); 
			
	        String company = request.getParameter("company");
	        String career = request.getParameter("career");
	        String filename = request.getParameter("filename");
	        
	        criticVO cvo = new criticVO();
	        cvo.setNo(no);
	        cvo.setCompany(company);
	        cvo.setCareer(career);
	        cvo.setFilename(filename);

	        criticDAO.insertApply(cvo); 

	        response.sendRedirect("");
			}
		}
		
		
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("CriticController doPost() 실행~~~");
			doGet(request, response);
		}
}
