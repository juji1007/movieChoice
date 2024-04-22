package com.mystudy.model.vo;

import java.sql.Date;

public class postVO {
	private int psNo;
	private int no;
	private String psTitle;
	private String psContent;
	private Date psDate;
	
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
	@Override
	public String toString() {
		return "postVO [psNo=" + psNo + ", no=" + no + ", psTitle=" + psTitle + ", psContent=" + psContent + ", psDate="
				+ psDate + "]";
	}
	
	

}
