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
import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.vo.listTotVO;
import com.project.mybatis.DBService;
import com.project.review.paging.Paging;

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
			
			//페이징 처리를 위한 객체(Paging) 생성
			Paging p = new Paging();

			//1. 전체 게시물 수량 구하기
			p.setTotalRecord(reviewDAO.getTotalCount());
			p.setNumPerPage(5);
			p.setPagePerBlock(5);
			p.setTotalPage();
			
			System.out.println(">전체 리뷰 수 : " + p.getTotalRecord());
			System.out.println(">페이지당 리뷰 수 : " + p.getNumPerPage());
			System.out.println(">전체 페이지 수 : " + p.getTotalPage());
			
		 	//2. 현재 페이지 번호 구하기
		 	String cPage = request.getParameter("cPage");
		 	if (cPage != null) {
		 		p.setNowPage(Integer.parseInt(cPage));
		 	}
		 	System.out.println("> cPage : " + cPage);
		 	System.out.println("> Paging nowPage : " + p.getNowPage());
		 	
		 	//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		 	p.setEnd(p.getNowPage() * p.getNumPerPage());
		 	p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
			
		 	System.out.println(">> 시작번호(begin) : " + p.getBegin());
		 	System.out.println(">> 끝번호(end) : " + p.getEnd());
		
		 	//4. --- 블록(block) 계산하기 -----
		 	//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
		 	int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		 	p.setNowBlock(nowBlock);
		 	p.setEndPage(nowBlock * p.getPagePerBlock());
		 	p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		 	System.out.println(">> nowBlock : " + p.getNowBlock());
		 	System.out.println(">> beginPage : " + p.getBeginPage());
		 	System.out.println(">> endPage : " + p.getEndPage());
		 	
		 	// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		 	// 끝페이지를 전체페이지 수로 변경 처리
		 	if (p.getEndPage() > p.getTotalPage()) {
		 		p.setEndPage(p.getTotalPage());
		 		System.out.println(">>정정후 endPage : " + p.getEndPage());
		 	}
		 	
		 	//DB 연동 작업
		 	//현재페이지 기준으로 DB 데이터(게시글) 가져오기
		 	//시작번호(begin), 끝번호(end)
//		 	List<reviewVO> plist = reviewDAO.pList(p.getBegin(), p.getEnd());
//		 	System.out.println(">> 현재페이지 글목록 : " + plist);
		 	
		 	//EL, JSTL 사용을 위해 scope에 데이터 등록(page영역)
		 	// 페이징처리객체 page 영역에 저장
//		 	request.setAttribute("pList", plist);
		 	request.setAttribute("pvo", p);
//		 	
		 	//ajax 이용하여 리뷰 전체조회
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
		
		//리뷰 삭제
		if ("deleteReview".equals(action)) {
			int rvNo = Integer.parseInt(request.getParameter("rvNo"));
			System.out.println("delete rvNo : " + rvNo);
			//DB에서 리뷰삭제
			int result = reviewDAO.delete(rvNo);
			//응답
			boolean reviewDeleteCheck = false;
			if (result != -1) reviewDeleteCheck = true;
			System.out.println(reviewDeleteCheck);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(String.valueOf(reviewDeleteCheck));
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
//            result.append("\"rvRec\": \"" + vo.getRvRec() + "\"");
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