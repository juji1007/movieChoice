package com.mystudy.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.mybatis.DBService;

public class recDAO {
	
	//리뷰 번호로 추천수 sum
	public static int recSum(int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			return ss.selectOne("rec.cnt", rvNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//회원no, 리뷰rvNo에 맞는 추천수 확인(select)
	public static int recSearch(int no, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			Map<String, Integer> map = new HashMap<>();
			map.put("no", no);
			map.put("rvNo", rvNo);
			
			return ss.selectOne("rec.search", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	//추천 클릭 선택(INSERT)
	public static int clickOn(int no, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)){
			Map<String, Integer> map = new HashMap<>();
			map.put("no", no);
			map.put("rvNo", rvNo);
			
			return ss.insert("rec.insert", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//추천 클릭 해제(DELETE)
	public static int clickOff(int no, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)){
			Map<String, Integer> map = new HashMap<>();
			map.put("no", no);
			map.put("rvNo", rvNo);
			
			return ss.delete("rec.delete", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//[리뷰]월별 조회된 rvNo에 해당하는 [추천]추천수 count값 추출
	public static int getRec(int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			return ss.selectOne("rec.recNum", rvNo);
		} catch (Exception e) {
			//검색 결과 없으면 0으로 변경
			return 0;
		}
	}
	
	
}
