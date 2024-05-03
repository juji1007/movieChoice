package com.project.vo;

public class AccountVO {
 
	private int no;
	private String name;
	private String id;
	private String pwd;
	private String nick;
	private int criticCheck;
	private String email;
	private int warn;
	
	public AccountVO() {
	}

	public int getWarn() {
		return warn;
	}

	public void setWarn(int warn) {
		this.warn = warn;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public int getCriticCheck() {
		return criticCheck;
	}

	public void setCriticCheck(int criticCheck) {
		this.criticCheck = criticCheck;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "AccountVO [no=" + no + ", name=" + name + ", id=" + id + ", pwd=" + pwd + ", nick=" + nick
				+ ", criticCheck=" + criticCheck + ", email=" + email + ", warn=" + warn + "]";
	}

	
	
	
}

