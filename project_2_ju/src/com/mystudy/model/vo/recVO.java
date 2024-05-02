package com.mystudy.model.vo;

public class recVO {
	private int idx;
	private int rec_num;
	private int no;
	private int rv_no;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getRec_num() {
		return rec_num;
	}
	public void setRec_num(int rec_num) {
		this.rec_num = rec_num;
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
	
	@Override
	public String toString() {
		return "recVO [idx=" + idx + ", rec_num=" + rec_num + ", no=" + no + ", rv_no=" + rv_no + "]";
	}
	
}
