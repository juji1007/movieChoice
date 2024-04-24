package com.mystudy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.listTotVO;
import com.project.mybatis.DBService;

public class listTotDAO {

	// 회원,영화,리뷰 테이블 전체조회
	public static List<listTotVO> getList() {
		try (SqlSession ss = DBService.getFactory().openSession()) {			
			return ss.selectList("listTotal.listAll");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
