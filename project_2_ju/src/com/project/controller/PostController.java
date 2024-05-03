

package com.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.postDAO;
import com.mystudy.model.vo.postVO;
import com.mystudy.post.common.Paging;

@WebServlet("/postController")
public class PostController extends HttpServlet { 
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("FrontController doGet() 실행~~~");
		
		String type = request.getParameter("type");
		System.out.println("작업형태 type : " + type);
		
		// 게시판
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		request.setCharacterEncoding("UTF-8");
		
		if ("freeList".equals(search)) {
			System.out.println(">> freeList 요청 처리~~");
			
			String idx = request.getParameter("idx");
			String keyword = request.getParameter("keyword");
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			String location = request.getParameter("location");
			System.out.println("location  : " +  location);
			if (idx == null || keyword == null || keyword.trim().length() == 0) {
				if ("freeAdmin".equals(location)) {
					request.getRequestDispatcher("freeListAdmin.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("free.jsp").forward(request, response);
				}
			}
			
			//페이징 처리를 위한 객체(Paging) 생성

	         Paging p = new Paging();
	         
	         //numPerPage=5, pagePerBlock=5 설정 먼저
//	         p.setNumPerPage(5);
//	         p.setPagePerBlock(5);
////	         
	         //1. 전체 게시물 수량 구하기
	         p.setTotalRecord(postDAO.getCount(idx, keyword));
	         p.setTotalPage();

	         System.out.println(">전체 게시글 수 : " + p.getTotalRecord());
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
	         
	         //동적 검색 및 페이징 처리
	         System.out.println("id : " + idx);
	         System.out.println("keyword : " + keyword);
	         System.out.println("p.getBegin() : " + p.getBegin());
	         System.out.println("p.getEnd() : " + p.getEnd());


			
			List<postVO> listOne = postDAO.freeList(idx, keyword);
			System.out.println("listOne : " + listOne);
			
			String sort = "";
			switch(idx) {
			case "0" : sort="제목"; break;
			case "1" : sort="작성일"; break;
			}
			
			if (listOne.size() == 0) {
				if ("freeAdmin".equals(location)) {
					request.getRequestDispatcher("freeListAdmin.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("free.jsp").forward(request, response);
				}
				return;
			}
			

			 request.setAttribute("selPvo", p);
	         request.setAttribute("listOne", listOne);
	         request.setAttribute("sort", sort);
	         request.setAttribute("keyword", keyword);


			
	         if ("freeAdmin".equals(location)) {
				request.getRequestDispatcher("freeListAdmin.jsp").forward(request, response);
			}
			request.getRequestDispatcher("freeList.jsp").forward(request, response);
		
		}
	}
		
		
		@Override
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("FrontController doPost() 실행~~~");
			doGet(request, response);
}
}
