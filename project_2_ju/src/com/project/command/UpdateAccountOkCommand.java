package com.project.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mystudy.model.dao.postDAO;
import com.mystudy.model.dao.reviewDAO;
import com.project.dao.AccountDAO;
import com.project.vo.AccountVO;

public class UpdateAccountOkCommand implements Command{
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		// 유저정보 받기
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
	    String id = (String) session.getAttribute("id");
	    System.out.println("upid : " + id);
		String crticCheck = request.getParameter("criticCheck"); 
		
		int no = Integer.parseInt(request.getParameter("no"));
	    String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String nickName = request.getParameter("nick");
		String email = request.getParameter("email");
//		String crticCheck = request.getParameter("criticCheck");
		System.out.println("crticCheck : " + crticCheck);

		int criticCheckInt = 0;
		if (crticCheck != null && !crticCheck.isEmpty()) {
			criticCheckInt = Integer.parseInt(crticCheck);
		} else {
			criticCheckInt = 0;
		}
		
		AccountVO avo = new AccountVO();
		avo.setNo(no);
		avo.setName(name);
		avo.setPwd(pwd);
		avo.setNick(nickName);
		avo.setEmail(email);
//		avo.setCriticCheck(criticCheckInt);
		System.out.println("avo ok : " + avo);
	    int result = AccountDAO.UpdateAccount(avo);
	    
	    //리뷰 닉네임 업데이트
	    int resultR = reviewDAO.updateNickReview(no, nickName);
	    
	    //포스트 닉네임 업데이트
	    int resultP = postDAO.updateNickPost(no, nickName);
	    
	    if (result == -1 && resultR == -1 && resultP == -1) {
	    	System.out.println("실패");
	    }
	    System.out.println("성공");
		
	    if ("1".equals(crticCheck)) {
	    	System.out.println("실행싱행실행");
	    	return "criticApply.jsp?location=myPage&id=" + id;
	    } else {
	    	return "myPage.jsp";
	    }
	}
}
