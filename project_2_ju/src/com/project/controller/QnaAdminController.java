package com.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.postDAO;
import com.mystudy.model.dao.qnaDAO;
import com.mystudy.model.vo.qnaVO;
import com.mystudy.post.common.Paging;

@WebServlet("/qnaAdminController")
public class QnaAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("QnaAdminController doGet() 실행");
		
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		request.setCharacterEncoding("UTF-8");
		
		if ("qnaAdminList".equals(search)) {
			System.out.println(">> qnaAdminList 요청 처리");
			
			String idx = request.getParameter("idx");
            String keyword = request.getParameter("keyword");
            System.out.println("idx, keyword : " + idx + ", " + keyword);
            
            String checkQaCategory = "0";
            String qaCategory = null;
            if (idx == null ) {
                request.getRequestDispatcher("qnaAdmin.jsp").forward(request, response);
                return;
            } 
            if ("2".equals(idx) && keyword == null && keyword.trim().isEmpty()) {
                keyword = "영화추가";
                checkQaCategory = "1";
            }
            if ("3".equals(idx) &&  keyword == null  && keyword.isEmpty()) {
                keyword = "평론가탈퇴";
                checkQaCategory = "1";
            } 
            if ("2".equals(idx)) {
                qaCategory = "영화추가";
            } 
            if ("3".equals(idx)) {
                qaCategory = "평론가탈퇴";
            }
            
	         
            List<qnaVO> listOne = qnaDAO.qnaList(idx, keyword, checkQaCategory, qaCategory);
            System.out.println("listOne : " + listOne);
            
            String sort = "";
            switch(idx) {
            case "0" : sort="제목"; break;
            case "1" : sort="작성일"; break;
            case "2" : sort="영화추가"; break;
            case "3" : sort="평론가탈퇴"; break;
            }
			
            request.setAttribute("listOne", listOne);
            request.setAttribute("sort", sort);
            request.setAttribute("keyword", keyword);
			
			request.getRequestDispatcher("qnaAdminList.jsp").forward(request, response);
		
		}
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("QnaAdminController doPost() 실행");
        doGet(request, response);
    }
}