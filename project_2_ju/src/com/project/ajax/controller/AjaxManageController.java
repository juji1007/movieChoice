package com.project.ajax.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
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
import com.project.vo.AccountVO;

@WebServlet("/ajaxManageController")
public class AjaxManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		System.out.println("action :" + action);
		
		//관리자검색처리
		if ("manageCategory".equals(action)) {
			System.out.println("검색처리");
			
			//검색종류 받아서 검색
			String idx = req.getParameter("idx");
			String keyword = req.getParameter("keyword");
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			//없으면 다시 처음화면으로
			if (idx == null || idx.trim().length() == 0) {
//				req.getRequestDispatcher("manage.jsp").forward(req, resp);
				return;
			}
			
			//검색DB처리
			Map<String, List<?>> listSearch = AdminDAO.selectData(idx, keyword);
			System.out.println("ajaxlistSearch : " + listSearch);
			//listSearch없으면 다시 처음화면으로
			if (listSearch == null) {
//				req.getRequestDispatcher("manage.jsp").forward(req, resp);
				return;
			} 
			// 키값 가져오기
			Set<String> keys = listSearch.keySet();
			for (String key : keys) {
			    System.out.println("Key: " + key);
			}
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
			
		}
		
		//유저관리자검색처리
		if ("accountManageCategory".equals(action)) {
			System.out.println("유저검색처리");
			
			//검색종류 받아서 검색
			String idx = req.getParameter("idx");
			String keyword = req.getParameter("keyword");
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			//없으면 다시 처음화면으로
			if (idx == null || idx.trim().length() == 0) {
				req.getRequestDispatcher("accountManage.jsp").forward(req, resp);
				return;
			}
			
			//검색DB처리
			List<AccountVO> list = AdminDAO.selectAccountData(idx, keyword);
			System.out.println("ajaxlistSearch : " + list);
			//listSearch없으면 다시 처음화면으로
			if (list == null) {
				req.getRequestDispatcher("accountManage.jsp").forward(req, resp);
				return;
			} 
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("account", list);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
			
		}
		
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
		            rvo = (reviewVO) item;
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"rvNo\": \"" + rvo.getRvNo() + "\", ");
		            result.append("\"mvNo\": \"" + rvo.getMvNo() + "\", ");
		            result.append("\"no\": \"" + rvo.getNo() + "\", ");
		            result.append("\"rvNick\": \"" + rvo.getRvNick() + "\", ");
		            result.append("\"rvTitle\": \"" + rvo.getRvTitle() + "\", ");
		            result.append("\"rvContent\": \"" + rvo.getRvContent() + "\", ");
		            result.append("\"rvDate\": \"" + rvo.getRvDate() + "\", ");
		            result.append("\"rvRec\": \"" + rvo.getRvRec() + "\", ");
		            result.append("\"warn\": \"" + rvo.getWarn() + "\"");
		            result.append("},");
		        }
		        
		        if ("movie".equals(key)) {
		            movieVO mvo = (movieVO) item;
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"mvNo\": \"" + mvo.getMvNo() + "\", ");
		            result.append("\"mvTitle\": \"" + mvo.getMvTitle() + "\", ");
		            result.append("\"mvDirect\": \"" + mvo.getMvDirect() + "\", ");
		            result.append("\"mvActor\": \"" + mvo.getMvActor() + "\", ");
		            result.append("\"mvGenre\": \"" + mvo.getMvGenre() + "\", ");
		            result.append("\"mvRate\": \"" + mvo.getMvRate() + "\", ");
		            result.append("\"mvAudience\": \"" + mvo.getMvAudience() + "\", ");
		            result.append("\"mvGrade\": \"" + mvo.getMvGrade() + "\", ");
		            result.append("\"mvDate\": \"" + mvo.getMvDate() + "\", ");
		            result.append("\"mvPoster\": \"" + mvo.getMvPoster() + "\"");
		            result.append("},");
		        }
		        
		        if ("account".equals(key)) {
		        	AccountVO avo = (AccountVO) item;
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"no\": \"" + avo.getNo() + "\", ");
		            result.append("\"name\": \"" + avo.getName() + "\", ");
		            result.append("\"id\": \"" + avo.getId() + "\", ");
		            result.append("\"nick\": \"" + avo.getNick() + "\", ");
		            result.append("\"criticCheck\": \"" + avo.getCriticCheck() + "\", ");
		            result.append("\"email\": \"" + avo.getEmail() + "\", ");
		            result.append("\"warn\": \"" + avo.getWarn() + "\"");
		            result.append("},");
		        }
		    }
		}
		result.deleteCharAt(result.length() - 1); // 마지막 쉼표(,) 제거
		result.append("]}");

		return result.toString();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}