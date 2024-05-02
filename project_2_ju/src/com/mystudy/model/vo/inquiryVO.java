package com.mystudy.model.vo;

import java.sql.Date;

public class inquiryVO {
	private int iqNo;
	private int qaNo;
	private String iqContent;
	private Date iqDate;
	
	public int getIqNo() {
		return iqNo;
	}
	public void setIqNo(int iqNo) {
		this.iqNo = iqNo;
	}
	public int getQaNo() {
		return qaNo;
	}
	public void setQaNo(int qaNo) {
		this.qaNo = qaNo;
	}
	public String getIqContent() {
		return iqContent;
	}
	public void setIqContent(String iqContent) {
		this.iqContent = iqContent;
	}
	public Date getiqDate() {
		return iqDate;
	}
	public void setiqDate(Date iqDate) {
		this.iqDate = iqDate;
	}
	
	@Override
	public String toString() {
		return "inquiryVO [iqNo=" + iqNo + ", qaNo=" + qaNo + ", iqContent=" + iqContent + ", iqDate=" + iqDate + "]";
	}
	
}
