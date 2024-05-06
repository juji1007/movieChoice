package com.mystudy.model.vo;

import java.sql.Date;

public class qnaVO {
	private int qaNo;
	private int no;
	private String qaContent;
	private Date qaDate;
	private String nick;
	private String qaCategory;
	private int criticCheck;
	private boolean inquiryCheck;
	private String qaTitle;
	
	public String getQaTitle() {
		return qaTitle;
	}
	public void setQaTitle(String qaTitle) {
		this.qaTitle = qaTitle;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public boolean getisInquiryCheck() {
		return inquiryCheck;
	}
	public void setInquiryCheck(boolean inquiryCheck) {
		this.inquiryCheck = inquiryCheck;

	}
	public int getCriticCheck() {
		return criticCheck;
	}
	public void setCriticCheck(int criticCheck) {
		this.criticCheck = criticCheck;
	}
	public String getQaCategory() {
		return qaCategory;
	}
	public void setQaCategory(String qaCategory) {
		this.qaCategory = qaCategory;
	}
	public int getQaNo() {
		return qaNo;
	}
	public void setQaNo(int qaNo) {
		this.qaNo = qaNo;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getQaContent() {
		return qaContent;
	}
	public void setQaContent(String qaContent) {
		this.qaContent = qaContent;
	}
	public Date getQaDate() {
		return qaDate;
	}
	public void setQaDate(Date qaDate) {
		this.qaDate = qaDate;
	}
	
	@Override
	public String toString() {
		return "qnaVO [qaNo=" + qaNo + ", no=" + no + ", qaContent=" + qaContent + ", qaDate=" + qaDate + ", nick="
				+ nick + ", qaCategory=" + qaCategory + ", criticCheck=" + criticCheck + ", inquiryCheck="
				+ inquiryCheck + ", qaTitle=" + qaTitle + "]";
	}
	
}
