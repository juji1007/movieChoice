package com.mystudy.model.vo;

import java.sql.Date;

public class listMvRv {
	
	private int rvNo;
	private int mvNo;
	private int no;
	private String mvTitle;
	private String mvPoster;
	private String rvTitle;
	private String rvContent;
	private String rvNick;
	private Date rvDate;
	private int rvRec;
	
	public int getRvNo() {
		return rvNo;
	}
	public void setRvNo(int rvNo) {
		this.rvNo = rvNo;
	}
	public int getMvNo() {
		return mvNo;
	}
	public void setMvNo(int mvNo) {
		this.mvNo = mvNo;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMvTitle() {
		return mvTitle;
	}
	public void setMvTitle(String mvTitle) {
		this.mvTitle = mvTitle;
	}
	public String getMvPoster() {
		return mvPoster;
	}
	public void setMvPoster(String mvPoster) {
		this.mvPoster = mvPoster;
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
	public String getRvNick() {
		return rvNick;
	}
	public void setRvNick(String rvNick) {
		this.rvNick = rvNick;
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
	
	@Override
	public String toString() {
		return "ListMvRv [rvNo=" + rvNo + ", mvNo=" + mvNo + ", no=" + no + ", mvTitle=" + mvTitle + ", mvPoster="
				+ mvPoster + ", rvTitle=" + rvTitle + ", rvContent=" + rvContent + ", rvNick=" + rvNick + ", rvDate="
				+ rvDate + ", rvRec=" + rvRec + "]";
	}
	
}
