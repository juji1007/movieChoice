package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.mybatis.DBService;
import com.project.vo.AccountVO;

public class AdminDAO {
	
	//관리 카테고리 목록 조회
	public static Map<String, List<?>> selectData(String idx, String keyword) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, List<?>> resultMap = new HashMap<>();
			if ("0".equals(idx)) {
				System.out.println("전체검색선택");
				resultMap.put("review", ss.selectList("admin.searchReviewList"));
				resultMap.put("movie", ss.selectList("admin.searchMovieList"));
				resultMap.put("account", ss.selectList("admin.searchAccountList"));
				System.out.println(resultMap);
				return resultMap;
			} else if ("1".equals(idx)) {
				System.out.println("리뷰검색선택");
				resultMap.put("review", ss.selectList("admin.searchReviewList"));
				return resultMap;
			} else if ("2".equals(idx)) {
				System.out.println("영화검색선택");
				resultMap.put("movie", ss.selectList("admin.searchMovieList"));
				return resultMap;
			} else if ("3".equals(idx)) {
				resultMap.put("account", ss.selectList("admin.searchAccountList"));
				return resultMap;
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//관리 카테고리 목록 조회
	public static List<AccountVO> selectAccountData(String idx, String keyword) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			Map<String, String> map = new HashMap<>();
			map.put("idx", idx);
			map.put("keyword", keyword);
			if ("0".equals(idx)) {
				System.out.println("전체검색선택");
				System.out.println(ss.selectList("admin.searchAccountDynamic",map));
				return ss.selectList("admin.searchAccountDynamic",map);
			} else if ("1".equals(idx)) {
				System.out.println("신고순");
				return ss.selectList("admin.searchAccountDynamic",map);
			} else if ("2".equals(idx)) {
				System.out.println("이름순");
				return ss.selectList("admin.searchAccountDynamic",map);
			} else if ("3".equals(idx)) {
				System.out.println("평론가");
				return ss.selectList("admin.searchAccountDynamic",map);
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
