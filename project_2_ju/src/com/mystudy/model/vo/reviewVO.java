package com.mystudy.model.vo;

import java.sql.Date;

public class reviewVO {
	
	private int rvNo;
	private int mvNo;
	private int no;
	private String rvNick;
	private String rvTitle;
	private String rvContent;
	private Date rvDate;
	private int rvRate;
	private int rvRec;
	private int rvWarn;
	
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
	
	@Override
	public String toString() {
		return "reviewVO [rvNo=" + rvNo + ", mvNo=" + mvNo + ", no=" + no + ", rvNick=" + rvNick + ", rvTitle="
				+ rvTitle + ", rvContent=" + rvContent + ", rvDate=" + rvDate + ", rvRate=" + rvRate + ", rvRec="
				+ rvRec + ", rvWarn=" + rvWarn + "]";
	}
	
}
