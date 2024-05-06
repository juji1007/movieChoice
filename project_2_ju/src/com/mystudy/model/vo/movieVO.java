package com.mystudy.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class movieVO  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int mvNo;
	private String mvTitle;
	private String mvDirect;
	private String mvActor;
	private String mvGenre;
	private int mvRate;
	private String mvAudience;
	private String mvGrade;
	private Date mvDate;
	private String mvPoster;
	private String rvNick;
	private String rvTitle;
	private String rvContent;
	private Date rvDate;
	private int rvNo;
	
	public int getRvNo() {
		return rvNo;
	}
	public void setRvNo(int rvNo) {
		this.rvNo = rvNo;
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
	public int getMvNo() {
		return mvNo;
	}
	public void setMvNo(int mvNo) {
		this.mvNo = mvNo;
	}
	public String getMvTitle() {
		return mvTitle;
	}
	public void setMvTitle(String mvTitle) {
		this.mvTitle = mvTitle;
	}
	public String getMvDirect() {
		return mvDirect;
	}
	public void setMvDirect(String mvDirect) {
		this.mvDirect = mvDirect;
	}
	public String getMvActor() {
		return mvActor;
	}
	public void setMvActor(String mvActor) {
		this.mvActor = mvActor;
	}
	public String getMvGenre() {
		return mvGenre;
	}
	public void setMvGenre(String mvGenre) {
		this.mvGenre = mvGenre;
	}
	public int getMvRate() {
		return mvRate;
	}
	public void setMvRate(int mvRate) {
		this.mvRate = mvRate;
	}
	public String getMvAudience() {
		return mvAudience;
	}
	public void setMvAudience(String mvAudience) {
		this.mvAudience = mvAudience;
	}
	public String getMvGrade() {
		return mvGrade;
	}
	public void setMvGrade(String mvGrade) {
		this.mvGrade = mvGrade;
	}
	public Date getMvDate() {
		return mvDate;
	}
	public void setMvDate(Date mvDate) {
		this.mvDate = mvDate;
	}
	public String getMvPoster() {
		return mvPoster;
	}
	public void setMvPoster(String mvPoster) {
		this.mvPoster = mvPoster;
	}
	
	@Override
	public String toString() {
		return "movieVO [mvNo=" + mvNo + ", mvTitle=" + mvTitle + ", mvDirect=" + mvDirect + ", mvActor=" + mvActor
				+ ", mvGenre=" + mvGenre + ", mvRate=" + mvRate + ", mvAudience=" + mvAudience + ", mvGrade=" + mvGrade
				+ ", mvDate=" + mvDate + ", mvPoster=" + mvPoster + ", rvNick=" + rvNick + ", rvTitle=" + rvTitle
				+ ", rvContent=" + rvContent + ", rvDate=" + rvDate + ", rvNo=" + rvNo + "]";
	}
	
}
