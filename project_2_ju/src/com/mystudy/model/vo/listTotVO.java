package com.mystudy.model.vo;

import java.sql.Date;

public class listTotVO {
	
	private int no;
	private String name;
	private String id;
	private String pwd;
	private String nick;
	private int critic_check;
	private String email;
	
	private int mvNo;
	private String mvTitle;
	private String mvDirect;
	private String mvActor;
	private String mvGenre;
	private int mvRate;
	private String mvAudience;
	private String mvGrade;
	private Date mvDate;
	private String mvPoster;
	
	private int rvNo;
	private String rvNick;
	private String rvTitle;
	private String rvContent;
	private Date rvDate;
	private int rvRate;
	private int rvRec;
	private int rvWarn;
	
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
	public int getMvNo() {
		return mvNo;
	}
	public void setMvNo(int mvNo) {
		this.mvNo = mvNo;
	}
	public String getMvTitle() {
		return mvTitle;
	}
	public void setMvTitle(String mvTitle) {
		this.mvTitle = mvTitle;
	}
	public String getMvDirect() {
		return mvDirect;
	}
	public void setMvDirect(String mvDirect) {
		this.mvDirect = mvDirect;
	}
	public String getMvActor() {
		return mvActor;
	}
	public void setMvActor(String mvActor) {
		this.mvActor = mvActor;
	}
	public String getMvGenre() {
		return mvGenre;
	}
	public void setMvGenre(String mvGenre) {
		this.mvGenre = mvGenre;
	}
	public int getMvRate() {
		return mvRate;
	}
	public void setMvRate(int mvRate) {
		this.mvRate = mvRate;
	}
	public String getMvAudience() {
		return mvAudience;
	}
	public void setMvAudience(String mvAudience) {
		this.mvAudience = mvAudience;
	}
	public String getMvGrade() {
		return mvGrade;
	}
	public void setMvGrade(String mvGrade) {
		this.mvGrade = mvGrade;
	}
	public Date getMvDate() {
		return mvDate;
	}
	public void setMvDate(Date mvDate) {
		this.mvDate = mvDate;
	}
	public String getMvPoster() {
		return mvPoster;
	}
	public void setMvPoster(String mvPoster) {
		this.mvPoster = mvPoster;
	}
	public int getRvNo() {
		return rvNo;
	}
	public void setRvNo(int rvNo) {
		this.rvNo = rvNo;
	}
	public String getRvNick() {
		return rvNick;
	}
	public void setRvNick(String rvNick) {
		this.rvNick = rvNick;
	}
	public String getRvTitle() {
		return rvTitle;
	}
	public void setRvTitle(String rvTitle) {
		this.rvTitle = rvTitle;
	}
	public String getRvContent() {
		return rvContent;
	}
	public void setRvContent(String rvContent) {
		this.rvContent = rvContent;
	}
	public Date getRvDate() {
		return rvDate;
	}
	public void setRvDate(Date rvDate) {
		this.rvDate = rvDate;
	}
	public int getRvRec() {
		return rvRec;
	}
	public void setRvRec(int rvRec) {
		this.rvRec = rvRec;
	}
	public int getRvRate() {
		return rvRate;
	}
	public void setRvRate(int rvRate) {
		this.rvRate = rvRate;
	}
	public int getRvWarn() {
		return rvWarn;
	}
	public void setRvWarn(int rvWarn) {
		this.rvWarn = rvWarn;
	}
	
	@Override
	public String toString() {
		return "listTotVO [no=" + no + ", name=" + name + ", id=" + id + ", pwd=" + pwd + ", nick=" + nick
				+ ", critic_check=" + critic_check + ", email=" + email + ", mvNo=" + mvNo + ", mvTitle=" + mvTitle
				+ ", mvDirect=" + mvDirect + ", mvActor=" + mvActor + ", mvGenre=" + mvGenre + ", mvRate=" + mvRate
				+ ", mvAudience=" + mvAudience + ", mvGrade=" + mvGrade + ", mvDate=" + mvDate + ", mvPoster="
				+ mvPoster + ", rvNo=" + rvNo + ", rvNick=" + rvNick + ", rvTitle=" + rvTitle + ", rvContent="
				+ rvContent + ", rvDate=" + rvDate + ", rvRate=" + rvRate + ", rvRec=" + rvRec + ", rvWarn=" + rvWarn
				+ "]";
	}
	
}
