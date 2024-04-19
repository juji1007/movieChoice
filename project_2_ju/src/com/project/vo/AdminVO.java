package com.project.vo;

public class AdminVO {

	private String id;
	private int a_no;
	private int m_no;
	private int r_no;
	
	public AdminVO(String id, int a_no, int m_no, int r_no) {
		this.id = id;
		this.a_no = a_no;
		this.m_no = m_no;
		this.r_no = r_no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getA_no() {
		return a_no;
	}

	public void setA_no(int a_no) {
		this.a_no = a_no;
	}

	public int getM_no() {
		return m_no;
	}

	public void setM_no(int m_no) {
		this.m_no = m_no;
	}

	public int getR_no() {
		return r_no;
	}

	public void setR_no(int r_no) {
		this.r_no = r_no;
	}

	@Override
	public String toString() {
		return "AdminVO [id=" + id + ", a_no=" + a_no + ", m_no=" + m_no + ", r_no=" + r_no + "]";
	}
	
	
	
}
