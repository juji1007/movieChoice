package com.mystudy.model.vo;

import java.sql.Date;

public class qnaVO {
	private int qaNo;
	private int no;
	private String qaContent;
	private Date qaDate;
	private String id;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
		return "qnaVO [qaNo=" + qaNo + ", no=" + no + ", qaContent=" + qaContent + ", qaDate=" + qaDate + ", id=" + id
				+ "]";
	}
	
}
