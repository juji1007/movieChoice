package com.mystudy.model.vo;

import java.sql.Date;

public class postCommentVO {
	
	private int pcNo;
	private int psNo;
	private int no;
	private Date pcDate;
	private String pcContent;
	private String pcNick;
	
	public int getPcNo() {
		return pcNo;
	}
	public void setPcNo(int pcNo) {
		this.pcNo = pcNo;
	}
	public int getPsNo() {
		return psNo;
	}
	public void setPsNo(int psNo) {
		this.psNo = psNo;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
		return "postCommentVO [pcNo=" + pcNo + ", psNo=" + psNo + ", no=" + no + ", pcDate=" + pcDate + ", pcContent="
				+ pcContent + ", pcNick=" + pcNick + "]";
	}
	
	
	
	
}
