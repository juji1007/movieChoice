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
		
//		if ("manageCategory".equals(action)) {
//			System.out.println("검색처리");
//			
//			//검색종류 받아서 검색
//			String idx = req.getParameter("idx");
//			String keyword = req.getParameter("keyword");
//			System.out.println("idx, keyword : " + idx + ", " + keyword);
//			
//			//없으면 다시 처음화면으로
//			if (keyword == null || keyword.trim().length() == 0) {
//				req.getRequestDispatcher("manage.jsp").forward(req, resp);
//				return;
//			}
//			
//			//검색DB처리
//			Map<String, List<?>> listSearch = AdminDAO.selectData(idx);
//			// 키값 가져오기
//			Set<String> keys = listSearch.keySet();
//			for (String key : keys) {
//			    System.out.println("Key: " + key);
//			}
//			
//			resp.setContentType("text/html; charset=UTF-8");
//			
//			
//		}
		
	}
	
	private String makeJson(Map<String, List<?>> listSearch) {
		//Json만들기
		StringBuilder result = new StringBuilder();
		result.append("{ \"listSearch\" : [");
		// 맵의 각 항목을 반복하면서 키와 값을 가져옴
		for (Map.Entry<String, List<?>> entry : listSearch.entrySet()) {
		    String key = entry.getKey(); // 현재 항목의 키 가져오기
		    List<?> value = entry.getValue(); // 현재 항목의 값(리스트) 가져오기
		    
		    System.out.println("Key: " + key);
		    System.out.println("Value: " + value);
		    // 리스트의 각 요소 Json넣기
		    for (Object item : value) {
		    	if ("review".equals(key)) {
		    		reviewVO rvo = new reviewVO();
			    	result.append("{");
			    	result.append("\"table\":" + key + ", ");
			    	result.append("\"rvNo\":" + rvo.getRvNo() + ", ");
			    	result.append("\"mvNo\":" + rvo.getMvNo() + ", ");
			    	result.append("\"no\":" + rvo.getNo() + ", ");
			    	result.append("\"rvNick\":" + rvo.getRvNick() + ", ");
			    	result.append("\"rvTitle\":" + rvo.getRvTitle() + ", ");
			    	result.append("\"rvContent\":" + rvo.getRvContent() + ", ");
			    	result.append("\"rvDate\":" + rvo.getRvDate() + ", ");
			    	result.append("\"rvRec\":" + rvo.getRvRec() + ", ");
			    	result.append("},");
		    	}
		    	
		    	if ("movie".equals(key)) {
		    		movieVO mvo = new movieVO();
			    	result.append("{");
			    	result.append("\"table\":" + key + ", ");
			    	result.append("\"mvNo\":" + mvo.getMvNo() + ", ");
			    	result.append("\"mvTitle\":" + mvo.getMvTitle() + ", ");
			    	result.append("\"mvDirect\":" + mvo.getMvDirect() + ", ");
			    	result.append("\"mvActor\":" + mvo.getMvActor() + ", ");
			    	result.append("\"mvGenre\":" + mvo.getMvGenre() + ", ");
			    	result.append("\"mvRate\":" + mvo.getMvRate() + ", ");
			    	result.append("\"mvAudience\":" + mvo.getMvAudience() + ", ");
			    	result.append("\"mvGrade\":" + mvo.getMvGrade() + ", ");
			    	result.append("\"mvDate\":" + mvo.getMvDate() + ", ");
			    	result.append("\"mvPoster\":" + mvo.getMvPoster() + ", ");
			    	result.append("},");
		    	}
		    	
		    	if ("account".equals(key)) {
			    	result.append("{");
			    	result.append("\"table\":" + key + ", ");
			    	result.append("\"table\":" + key + ", ");
			    	result.append("\"table\":" + key + ", ");
			    	result.append("},");
		    	}
		    }
		}
		result.deleteCharAt(result.length() - 1);
		result.append("]}");

		return result.toString();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
