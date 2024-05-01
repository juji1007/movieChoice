package com.project.command;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.postDAO;
import com.mystudy.model.dao.reviewDAO;
import com.project.dao.AccountDAO;
import com.project.vo.AccountVO;

public class UpdateAccountOkCommand implements Command{
	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

		// 유저정보 받기
//	    AccountVO avo = (AccountVO) request.getAttribute("avo");
//	    System.out.println("avo ok : " + avo);
	    
		int no = Integer.parseInt(request.getParameter("no"));
	    String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String nickName = request.getParameter("nick");
		String email = request.getParameter("email");
		String crticCheck = request.getParameter("criticCheck"); // 관리자페이지랑연결
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
		
		return "myPage.jsp";
	}
}
