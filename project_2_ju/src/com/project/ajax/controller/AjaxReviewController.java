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

import com.mystudy.model.dao.movieDAO;
import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.reviewVO;
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
		//리뷰메인 페이지
		String action = request.getParameter("action");
		System.out.println("action : " + action);
		
		if ("reviewMain".equals(action)) {
			System.out.println(">> reviewMain 요청 처리~~");
			
			//1.리뷰 전체조회
			List<reviewVO> list = null;
			try (SqlSession ss = DBService.getFactory().openSession()) {
				list = ss.selectList("review.all");
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("list : " + list);
			//request.setAttribute("listRv", list);
			
			//JSON 형식 문자열 만들기
			// { "list" : [ {},{},{}, ..., {}] }
			String resultRv= makeJsonRv(list);
			System.out.println("resultRv : \n" + resultRv);
			
			//응답하기
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(resultRv);
/*			
			//2.영화 제목,포스터 전체 조회
			List<movieVO> mvList = null;
			try (SqlSession ss = DBService.getFactory().openSession()) {
				mvList = movieDAO.movieList();
			} catch (Exception e) {
				e.printStackTrace();
			}
			System.out.println("mvList : " + mvList);
			request.setAttribute("mvList", mvList);
			
			//JSON 형식 문자열 만들기
			// { "list" : [ {},{},{}, ..., {}] }
			String resultMv = makeJsonMv(mvList);
			System.out.println("result : \n" + resultMv);
			
			//응답하기
			out.print(resultMv);
*/
		}
		
	}

/*
	private String makeJsonMv(List<movieVO> movieList) {
		//JSON 형식 문자열 만들기
		StringBuilder result = new StringBuilder();
		result.append("{ \"lisMv\" : [");
		
		for (movieVO vo : movieList) {
			result.append("{");
			result.append("\"mvNo\" : " + vo.getMvNo() + ", ");
			result.append("\"mvTitle\" : " + vo.getMvTitle() + ", ");
			result.append("\"mvDirect\" : " + vo.getMvDirect() + ", ");
			result.append("\"mvActor\" : " + vo.getMvActor() + ", ");
			result.append("\"mvGenre\" : " + vo.getMvGenre() + ", ");
			result.append("\"mvRate\" : " + vo.getMvRate() + ", ");
			result.append("\"mvAudience\" : " + vo.getMvAudience() + ", ");
			result.append("\"mvGrade\" : " + vo.getMvGrade() + ", ");
			result.append("\"mvDate\" : " + vo.getMvDate() + ", ");
			result.append("\"mvPoster\" : " + vo.getMvPoster() + ", ");
			result.append("},");
		}
		result.deleteCharAt(result.length() - 1);
		result.append("]}");
		
		return result.toString();
	}
*/
	private String makeJsonRv(List<reviewVO> list) {
		//JSON 형식 문자열 만들기
		StringBuilder result = new StringBuilder();
		result.append("{ \"listRv\" : [");
	
		for (reviewVO rvo : list) {
			result.append("{");
			result.append("\"rvNo\": \"" + rvo.getRvNo() + "\", ");
            result.append("\"mvNo\": \"" + rvo.getMvNo() + "\", ");
            result.append("\"no\": \"" + rvo.getNo() + "\", ");
            result.append("\"rvNick\": \"" + rvo.getRvNick() + "\", ");
            result.append("\"rvTitle\": \"" + rvo.getRvTitle() + "\", ");
            result.append("\"rvContent\": \"" + rvo.getRvContent() + "\", ");
            result.append("\"rvDate\": \"" + rvo.getRvDate() + "\", ");
            result.append("\"rvRec\": \"" + rvo.getRvRec() + "\", ");
			result.append("\"Warn\" : \"" + rvo.getWarn() + "\"");
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