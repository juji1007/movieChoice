package com.project.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.project.command.Command;
import com.project.command.FindIdCommand;
import com.project.command.FindIdOkCommand;
import com.project.command.FindPasswordCommand;
import com.project.command.FindPasswordOkCommand;
import com.project.command.LoginCommand;
import com.project.command.MemberJoinCommand;
import com.project.command.MemberJoinOkCommand;

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
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String type = req.getParameter("type");
		System.out.println("작업형태 type : " + type);
		
		Command command = null;
		command = commands.get(type);
		String path = command.exec(req, resp);
		req.getRequestDispatcher(path).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}


