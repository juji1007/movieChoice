package com.project.vo;

public class CriticVO {
	private int no;
	private String company;
	private String career;
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
		return "CriticVO [no=" + no + ", company=" + company + ", career=" + career + "]";
	}
	
	
}
