package com.mystudy.model.vo;

import java.sql.Date;

public class criticVO {
	private int no;
	private String name;
	private String company;
	private String career;
	private int mvNo;
	private String rvNick;
	private String rvTitle;
	private String rvContent;
	private Date rvDate;
	private String filename;
	
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getMvNo() {
		return mvNo;
	}
	public void setMvNo(int mvNo) {
		this.mvNo = mvNo;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	
	@Override
	public String toString() {
		return "criticVO [no=" + no + ", name=" + name + ", company=" + company + ", career=" + career + ", mvNo="
				+ mvNo + ", rvNick=" + rvNick + ", rvTitle=" + rvTitle + ", rvContent=" + rvContent + ", rvDate="
				+ rvDate + ", filename=" + filename + "]";
	}
	
}
