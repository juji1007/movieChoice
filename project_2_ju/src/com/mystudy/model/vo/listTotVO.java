package com.mystudy.model.vo;

import java.sql.Date;

public class listTotVO {

	// account
	private int no;
	private String name;
	private String id;
	private String pwd;
	private String nick;
	private int critic_check;
	private String email;
	private int warn;

	// movie
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

	// review
	private int rvNo;
	private String rvNick;
	private String rvTitle;
	private String rvContent;
	private Date rvDate;
	private int rvRate;
	private int rvRec;
	private int rvWarn;

	// post
	private int psNo;
	private String psTitle;
	private String psContent;
	private Date psDate;
	private String psFile;
	private String psOrifile;

	// ps_comment
	private int pcNo;
	private Date pcDate;
	private String pcContent;
	private String pcNick;

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
	public int getWarn() {
		return warn;
	}
	public void setWarn(int warn) {
		this.warn = warn;
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

	public int getRvRate() {
		return rvRate;
	}

	public void setRvRate(int rvRate) {
		this.rvRate = rvRate;
	}

	public int getRvRec() {
		return rvRec;
	}

	public void setRvRec(int rvRec) {
		this.rvRec = rvRec;
	}

	public int getRvWarn() {
		return rvWarn;
	}

	public void setRvWarn(int rvWarn) {
		this.rvWarn = rvWarn;
	}

	public int getPsNo() {
		return psNo;
	}

	public void setPsNo(int psNo) {
		this.psNo = psNo;
	}

	public String getPsTitle() {
		return psTitle;
	}

	public void setPsTitle(String psTitle) {
		this.psTitle = psTitle;
	}

	public String getPsContent() {
		return psContent;
	}

	public void setPsContent(String psContent) {
		this.psContent = psContent;
	}

	public Date getPsDate() {
		return psDate;
	}

	public void setPsDate(Date psDate) {
		this.psDate = psDate;
	}

	public String getPsFile() {
		return psFile;
	}

	public void setPsFile(String psFile) {
		this.psFile = psFile;
	}

	public String getPsOrifile() {
		return psOrifile;
	}

	public void setPsOrifile(String psOrifile) {
		this.psOrifile = psOrifile;
	}

	public int getPcNo() {
		return pcNo;
	}

	public void setPcNo(int pcNo) {
		this.pcNo = pcNo;
	}

	public Date getPcDate() {
		return pcDate;
	}

	public void setPcDate(Date pcDate) {
		this.pcDate = pcDate;
	}

	public String getPcContent() {
		return pcContent;
	}

	public void setPcContent(String pcContent) {
		this.pcContent = pcContent;
	}

	public String getPcNick() {
		return pcNick;
	}

	public void setPcNick(String pcNick) {
		this.pcNick = pcNick;
	}

	@Override
	public String toString() {
		return "listTotVO [no=" + no + ", name=" + name + ", id=" + id + ", pwd=" + pwd + ", nick=" + nick
				+ ", critic_check=" + critic_check + ", email=" + email + ", mvNo=" + mvNo + ", mvTitle=" + mvTitle
				+ ", mvDirect=" + mvDirect + ", mvActor=" + mvActor + ", mvGenre=" + mvGenre + ", mvRate=" + mvRate
				+ ", mvAudience=" + mvAudience + ", mvGrade=" + mvGrade + ", mvDate=" + mvDate + ", mvPoster="
				+ mvPoster + ", rvNo=" + rvNo + ", rvNick=" + rvNick + ", rvTitle=" + rvTitle + ", rvContent="
				+ rvContent + ", rvDate=" + rvDate + ", rvRate=" + rvRate + ", rvRec=" + rvRec + ", rvWarn=" + rvWarn
				+ ", psNo=" + psNo + ", psTitle=" + psTitle + ", psContent=" + psContent + ", psDate=" + psDate
				+ ", psFile=" + psFile + ", psOrifile=" + psOrifile + ", pcNo=" + pcNo + ", pcDate=" + pcDate
				+ ", pcContent=" + pcContent + ", pcNick=" + pcNick + ", getNo()=" + getNo() + ", getName()="
				+ getName() + ", getId()=" + getId() + ", getPwd()=" + getPwd() + ", getNick()=" + getNick()
				+ ", getCritic_check()=" + getCritic_check() + ", getEmail()=" + getEmail() + ", getMvNo()=" + getMvNo()
				+ ", getMvTitle()=" + getMvTitle() + ", getMvDirect()=" + getMvDirect() + ", getMvActor()="
				+ getMvActor() + ", getMvGenre()=" + getMvGenre() + ", getMvRate()=" + getMvRate()
				+ ", getMvAudience()=" + getMvAudience() + ", getMvGrade()=" + getMvGrade() + ", getMvDate()="
				+ getMvDate() + ", getMvPoster()=" + getMvPoster() + ", getRvNo()=" + getRvNo() + ", getRvNick()="
				+ getRvNick() + ", getRvTitle()=" + getRvTitle() + ", getRvContent()=" + getRvContent()
				+ ", getRvDate()=" + getRvDate() + ", getRvRec()=" + getRvRec() + ", getRvRate()=" + getRvRate()
				+ ", getRvWarn()=" + getRvWarn() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

}
