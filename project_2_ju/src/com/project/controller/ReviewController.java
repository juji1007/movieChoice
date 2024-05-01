package com.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.dao.listTotDAO;
import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.vo.listTotVO;
import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.reviewVO;
import com.project.mybatis.DBService;
import com.project.review.paging.Paging;

@WebServlet("/reviewController")
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String category = request.getParameter("category");
		System.out.println("category : " + category);
		
		//리뷰메인 페이지(rvMain)
		if ("rvMain".equals(category)) {
			System.out.println(">> rvMain 실행 중~");
			
			//페이징 처리를 위한 객체(Paging) 생성
			Paging p = new Paging();
			
			//numPerPage=5, pagePerBlock=5 설정 먼저
			p.setNumPerPage(5);
			p.setPagePerBlock(5);
			
			//1. 전체 게시물 수량 구하기
			p.setTotalRecord(reviewDAO.getTotalCount());
			p.setTotalPage();
			
			System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
			System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
			
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
				System.out.println(">>정정 후 endPage : " + p.getEndPage());
			}
			
			//페이징 + 리뷰 전체(영화,회원) 목록
			List<listTotVO> listAll = listTotDAO.listTot(p.getBegin(), p.getEnd());
			System.out.println(">> 리뷰 메인 listAll : " + listAll);
			
			request.setAttribute("listAll", listAll);
			
			request.setAttribute("rvPvo", p);
			
			//페이징 처리 위한 리뷰 전체 목록
//			List<reviewVO> list = reviewDAO.pList(p.getBegin(), p.getEnd());
//			System.out.println(">> 현재페이지 글목록 : " + list);
//			request.setAttribute("rvList", list);
			
			request.getRequestDispatcher("reviewMain.jsp").forward(request, response);
		}

		
		//리뷰 등록 - INSERT
		if ("rvWrite".equals(category)) {
			System.out.println(">> rvWrite 요청 처리~~");
			
			//영화 제목, 번호 목록(selection) 불러오기
			List<movieVO> list = null;
			try (SqlSession ss = DBService.getFactory().openSession()) {
				list =  ss.selectList("movie.all");
			} catch (Exception e) {
				e.printStackTrace();
			} 
			
			System.out.println(">> mvlist : " + list);
			request.setAttribute("mvlist", list);
			
			request.getRequestDispatcher("rvWrite.jsp").forward(request, response);
			
		}
		
		
		//리뷰 카테고리별(영화명,작성자,작성일) 동적 검색 - 작성일 검색X
		if ("selectOne".equals(category)) {
			System.out.println(">> selectOne 요청 처리~~");
			
			String idx = request.getParameter("idx");
			String keyword = request.getParameter("keyword");
			request.setAttribute("keyword", keyword);
			
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			if (idx == null || keyword == null || keyword.trim().length() == 0) {
				request.getRequestDispatcher("reviewController?category=rvMain").forward(request, response);
				
				return;
			}
			
			//페이징 처리를 위한 객체(Paging) 생성
			Paging p = new Paging();
			
			//numPerPage=5, pagePerBlock=5 설정 먼저
			p.setNumPerPage(5);
			p.setPagePerBlock(5);
			
			//1. 전체 게시물 수량 구하기
			p.setTotalRecord(reviewDAO.getCount(idx, keyword));
			p.setTotalPage();
			
			System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
			System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
			
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
				System.out.println(">>정정 후 endPage : " + p.getEndPage());
			}
			
			//동적 검색 및 페이징 처리
			System.out.println("id : " + idx);
			System.out.println("keyword : " + keyword);
			System.out.println("p.getBegin() : " + p.getBegin());
			System.out.println("p.getEnd() : " + p.getEnd());
			
			String sort = "";
			switch(idx) {
				case "0" : sort="영화명"; break;
				case "1" : sort="작성자"; break;
				case "2" : sort="작성일"; break;
			}
			System.out.println("keyword 타입 : " + keyword.getClass().getName());
			
			List<listTotVO> listOne = reviewDAO.selectOne(idx, keyword, p.getBegin(), p.getEnd());
			System.out.println("::DB 연결 후, listOne : " + listOne);
			
			request.setAttribute("selPvo", p);
//			request.setAttribute("sort", sort);
			
			request.setAttribute("listOne", listOne);
			
			request.getRequestDispatcher("selectOne.jsp").forward(request, response);
			
		}
			
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
