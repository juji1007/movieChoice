package com.project.dao;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.dao.recDAO;
import com.mystudy.model.dao.warnDAO;
import com.mystudy.model.vo.reviewVO;
import com.project.mybatis.DBService;
import com.project.vo.AccountVO;

public class AdminDAO {
	
	//관리 카테고리 목록 조회
	public static Map<String, List<?>> selectData(String idx, String keyword) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, List<?>> resultMap = new HashMap<>();
			List<reviewVO> reviewList = ss.selectList("admin.searchReviewList", keyword);
			for (reviewVO rvo : reviewList) {
				int rvNo = rvo.getRvNo();
				int warn = warnDAO.warnSum(rvNo);
				rvo.setRvWarn(warn);
				int rec = recDAO.recSum(rvNo);
				rvo.setRvRec(rec);
			}
			List<AccountVO> accountList = ss.selectList("admin.searchAccountList", keyword);
			for (AccountVO avo : accountList) {
				int no = avo.getNo();
				int warn = warnDAO.warnSumByNo(no);
				avo.setWarn(warn);
			}
			System.out.println(resultMap);
			
			if ("0".equals(idx)) {
				System.out.println("전체검색선택");
				resultMap.put("review", reviewList);
				resultMap.put("movie", ss.selectList("admin.searchMovieList", keyword));
				resultMap.put("account", accountList);
				return resultMap;
			} else if ("1".equals(idx)) {
				System.out.println("리뷰검색선택");
				resultMap.put("review", reviewList);
				return resultMap;
			} else if ("2".equals(idx)) {
				System.out.println("영화검색선택");
				resultMap.put("movie", ss.selectList("admin.searchMovieList", keyword));
				return resultMap;
			} else if ("3".equals(idx)) {
				resultMap.put("account", accountList);
				System.out.println("account : " + accountList);
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
			List<AccountVO> accountList = ss.selectList("admin.searchAccountDynamic",map);
			for (AccountVO avo : accountList) {
				int no = avo.getNo();
				int warn = warnDAO.warnSumByNo(no);
				avo.setWarn(warn);
				System.out.println(avo);
			}
			if ("0".equals(idx)) {
				System.out.println("전체검색선택");
				System.out.println(accountList);
				return accountList;
			} else if ("1".equals(idx)) {
				System.out.println("신고순");
				Collections.sort(accountList, new Comparator<AccountVO>() {
			        @Override
			        public int compare(AccountVO avo1, AccountVO avo2) {
			            // avo1의 warn 값이 크면 양수, 작으면 음수, 같으면 0 반환하여 정렬
			            return Integer.compare(avo2.getWarn(), avo1.getWarn());
			        }
			    });

			    for (AccountVO avo : accountList) {
			        System.out.println(avo);
			    }
				
				return accountList;
			} else if ("2".equals(idx)) {
				System.out.println("이름순");
				return accountList;
			} else if ("3".equals(idx)) {
				System.out.println("평론가");
				return accountList;
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
