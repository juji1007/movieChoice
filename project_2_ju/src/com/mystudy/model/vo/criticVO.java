package com.mystudy.model.vo;

public class criticVO {
	private int no;
	private String name;
	private String company;
	private String career;
	
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
		return "criticVO [no=" + no + ", name=" + name + ", company=" + company + ", career=" + career + "]";
	}
	
}
