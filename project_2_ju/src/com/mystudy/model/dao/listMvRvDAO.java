package com.mystudy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.listMvRvVO;
import com.project.mybatis.DBService;

public class listMvRvDAO {

	//영화 번호로 리뷰 상세내용 1개 조회
	public static listMvRvVO selectList(int mvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()) {			
			return ss.selectOne("review.mvNoSearch", mvNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
