package com.project.ajax.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.listTotVO;
import com.project.mybatis.DBService;

@WebServlet("/ajaxReviewController")
public class AjaxReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		
		System.out.println(":: AjaxReviewController doGet 시작~~");
		//DB 데이터 조회 후 JSON 형식 문자열 생성해서 응답하기
		
		// DB 데이터 가져오기(조회)
		//리뷰메인 페이지에서 회원,영화,리뷰 테이블 전체조회 
		String action = request.getParameter("action");
		System.out.println("action : " + action);
		
		if ("reviewMain".equals(action)) {
			System.out.println(">> reviewMain 요청 처리~~");
				
			List<listTotVO> list = null;
			try (SqlSession ss = DBService.getFactory().openSession()) {
				list = ss.selectList("listTotal.listAll");
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("listAll : " + list);
			
			//JSON 형식 문자열 만들기
			// { "list" : [ {},{},{}, ..., {}] }
			String resultRv= makeJson(list);
			System.out.println("resultRv : \n" + resultRv);
			
			//응답하기
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(resultRv);
		}

	
	}
	

	private String makeJson(List<listTotVO> list) {
		//JSON 형식 문자열 만들기
		StringBuilder result = new StringBuilder();
		result.append("{ \"listAll\" : [");
		
		for (listTotVO vo : list) {
			result.append("{");
			result.append("\"no\": \"" + vo.getNo() + "\", ");
			result.append("\"name\": \"" + vo.getName() + "\", ");
			result.append("\"id\": \"" + vo.getId() + "\", ");
			result.append("\"pwd\": \"" + vo.getPwd() + "\", ");
			result.append("\"nick\": \"" + vo.getNick() + "\", ");
			result.append("\"critic_check\": \"" + vo.getCritic_check() + "\", ");
            result.append("\"email\": \"" + vo.getEmail() + "\", ");
            
            result.append("\"mvNo\": \"" + vo.getMvNo() + "\", ");
            result.append("\"mvTitle\": \"" + vo.getMvTitle() + "\", ");
            result.append("\"mvDirect\": \"" + vo.getMvDirect() + "\", ");
            result.append("\"mvActor\": \"" + vo.getMvActor() + "\", ");
            result.append("\"mvGenre\": \"" + vo.getMvGenre() + "\", ");
            result.append("\"mvRate\": \"" + vo.getMvRate() + "\", ");
            result.append("\"mvAudience\": \"" + vo.getMvAudience() + "\", ");
            result.append("\"mvGrade\": \"" + vo.getMvGrade() + "\", ");
            result.append("\"mvDate\": \"" + vo.getMvDate() + "\", ");
            result.append("\"mvPoster\": \"" + vo.getMvPoster() + "\", ");
            
            result.append("\"rvNo\": \"" + vo.getRvNo() + "\", ");
            result.append("\"rvNick\": \"" + vo.getRvNick() + "\", ");
            result.append("\"rvTitle\": \"" + vo.getRvTitle() + "\", ");
            result.append("\"rvContent\": \"" + vo.getRvContent() + "\", ");
            result.append("\"rvDate\": \"" + vo.getRvDate() + "\", ");
            result.append("\"rvRec\": \"" + vo.getRvRec() + "\"");
			result.append("},");
		}
		result.deleteCharAt(result.length() - 1);
		result.append("]}");
		
		return result.toString();
	}

	
	


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

}