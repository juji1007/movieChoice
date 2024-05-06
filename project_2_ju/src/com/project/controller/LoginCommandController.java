package com.project.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.mystudy.model.dao.postDAO;
import com.mystudy.model.dao.reviewDAO;
import com.project.command.Command;
import com.project.command.FindIdCommand;
import com.project.command.FindIdOkCommand;
import com.project.command.FindPasswordCommand;
import com.project.command.FindPasswordOkCommand;
import com.project.command.LoginCommand;
import com.project.command.MemberJoinCommand;
import com.project.command.MemberJoinOkCommand;
import com.project.command.UpdateAccountCommand;
import com.project.command.UpdateAccountOkCommand;
import com.project.command.deleteAccountCommand;
import com.project.command.deleteAccountOkCommand;
import com.project.dao.AccountDAO;
import com.project.vo.AccountVO;

@WebServlet("/loginController")
public class LoginCommandController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String, Command> commands;
	
	public void init(ServletConfig config) throws ServletException {
		commands = new HashMap<String, Command>();
		commands.put("login", new LoginCommand());
		commands.put("findId", new FindIdCommand());
		commands.put("findPassword", new FindPasswordCommand());
		commands.put("findIdOk", new FindIdOkCommand());
		commands.put("findPasswordOk", new FindPasswordOkCommand());
		commands.put("memberJoin", new MemberJoinCommand());
		commands.put("memberJoinOk", new MemberJoinOkCommand());
		commands.put("updateAccount", new UpdateAccountCommand());
		commands.put("updateAccountOk", new UpdateAccountOkCommand());
		commands.put("deleteAccount", new deleteAccountCommand());
		commands.put("deleteAccountOk", new deleteAccountOkCommand());
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		System.out.println("작업형태 type : " + type);
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		// AccountVO에서 사용자의 역할(role)을 가져와서 세션에 저장하는 과정
//	 	AccountVO avo = accountDAO.getAccountInfo(userId); // 사용자 정보 가져오기
//	 	session.setAttribute("role", avo.getRole()); // 사용자의 역할을 세션에 저장
		
//	 	// 페이지에서 세션에 저장된 사용자 역할을 확인하여 특정 역할에만 접근을 허용하는 예시
//	 	String role = (String) session.getAttribute("role");
//	 	if ("admin".equals(role)) {
//	 	    // 관리자 권한이 있는 경우에만 특정 기능에 접근할 수 있도록 처리
//	 	    // 예: 관리자 전용 기능을 보여주는 코드
//	 	} else {
//	 	    // 일반 사용자 또는 다른 역할에 대한 처리
//	 	    // 예: 일반 사용자에게 보여주는 코드
//	 	}
		if ("findIdOk".equals(type)) {
			request.setCharacterEncoding("UTF-8");

			 // 이메일 주소 받기
		    String email = request.getParameter("email");
		    System.out.println("emailjsp : " + email);
		    // 아이디 DB에서 조회
		    String id = AccountDAO.getAccountSearchId(email);
		    
		    request.setAttribute("id", id);
			
		}
		
		if ("updateAccountOk".equals(type)) {
		}
		
		Command command = null;
		command = commands.get(type);
		System.out.println("이동 type : " + command);
		String path = command.exec(request, response);
		System.out.println("path : " + path);
		request.getRequestDispatcher(path).forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}


