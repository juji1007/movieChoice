package com.project.vo;

public class AccountVO {

	private int no;
	private String name;
	private String id;
	private String pwd;
	private String nick;
	private int critic_check;
	private String email;
	
	
	public AccountVO() {
	}

	public AccountVO(int no, String name, String id, String pwd, String nick, int critic_check, String email) {
		this.no = no;
		this.name = name;
		this.id = id;
		this.pwd = pwd;
		this.nick = nick;
		this.critic_check = critic_check;
		this.email = email;
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

	public int getCritic_check() {
		return critic_check;
	}

	public void setCritic_check(int critic_check) {
		this.critic_check = critic_check;
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
				+ ", critic_check=" + critic_check + ", email=" + email + "]";
	}
	
	
	
}

