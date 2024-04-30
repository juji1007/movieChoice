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

	// 리뷰 번호로 조회
	public static listTotVO selectOne(int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()) {			
			return ss.selectOne("listTotal.one", rvNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
