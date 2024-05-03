package com.mystudy.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.mybatis.DBService;

public class warnDAO {
	//리뷰
	//리뷰 번호로 신고수 sum
	public static int warnSum(int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			return ss.selectOne("warn.cnt", rvNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//회원 번호로 신고수 sum
	public static int warnSumByNo(int no) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			return ss.selectOne("warn.cntByNo", no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//회원no, 리뷰rvNo에 맞는 신고수 확인(select)
	public static int warnSearch(int no, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			Map<String, Integer> map = new HashMap<>();
			map.put("no", no);
			map.put("rvNo", rvNo);
			
			return ss.selectOne("warn.search", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	//신고 클릭 선택(INSERT)
	public static int clickOn(int no, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)){
			Map<String, Integer> map = new HashMap<>();
			map.put("no", no);
			map.put("rvNo", rvNo);
			
			return ss.insert("warn.insert", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//신고 클릭 해제(DELETE)
	public static int clickOff(int no, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)){
			Map<String, Integer> map = new HashMap<>();
			map.put("no", no);
			map.put("rvNo", rvNo);
			
			return ss.delete("warn.delete", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//게시물
	
	
}
