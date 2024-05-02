package com.mystudy.model.vo;

public class warnVO {
	private int idx;
	private int warn_num;
	private int no;
	private int rv_no;
	private int ps_no;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getWarn_num() {
		return warn_num;
	}
	public void setWarn_num(int warn_num) {
		this.warn_num = warn_num;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getRv_no() {
		return rv_no;
	}
	public void setRv_no(int rv_no) {
		this.rv_no = rv_no;
	}
	public int getPs_no() {
		return ps_no;
	}
	public void setPs_no(int ps_no) {
		this.ps_no = ps_no;
	}
	
	@Override
	public String toString() {
		return "warnVO [idx=" + idx + ", warn_num=" + warn_num + ", no=" + no + ", rv_no=" + rv_no + ", ps_no=" + ps_no
				+ "]";
	}
	
}
