package com.mystudy.model.vo;

import com.mystudy.model.dao.listTotDAO;

public class recommand {
	private listTotVO vo; //추천 포함된 전체 데이터
	private int rvNo; //리뷰 번호
	private int rec; //추천 수
	
	public recommand() {
		vo = listTotDAO.selectOne(rvNo);
	}
	
	public void pushRec(int rvNo, int rec) {
		
	}
}
