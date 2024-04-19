package com.mystudy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.listMvRv;
import com.mystudy.model.vo.reviewVO;
import com.project.mybatis.DBService;


public class reviewDAO {

/*
	//리뷰 전체 목록 조회
	public static List<ReviewVO> getList() {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("review.all");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
*/
	//카테고리별(영화명,작성자,작성일) 목록 조회
	public static List<reviewVO> selectOne(String idx, String keyword) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("idx", idx);
			map.put("keyword", keyword);
			
			return ss.selectList("review.one", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static List<listMvRv> selectList(int mvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()) {			
			return ss.selectList("review.mvNoSearch", mvNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
