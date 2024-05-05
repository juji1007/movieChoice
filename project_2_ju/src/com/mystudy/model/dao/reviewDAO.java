package com.mystudy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.listTotVO;
import com.mystudy.model.vo.reviewVO;
import com.project.mybatis.DBService;


public class reviewDAO {

	//카테고리별(영화명,작성자,작성일) 목록 조회
	public static List<listTotVO> selectOne(String idx, String keyword, int begin, int end) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, Object> map = new HashMap<>();
			map.put("idx", idx);
			map.put("keyword", keyword);
			map.put("begin", begin);
			map.put("end", end);
			System.out.println(">> reviewDAO map : " + map);
			
			return ss.selectList("review.one", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}	
	//카테고리별 리뷰 건수 조회
	public static int getCount(String idx, String keyword) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("idx", idx);
			map.put("keyword", keyword);
			System.out.println("map : " + map);
			return ss.selectOne("review.cnt", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//영화번호로 리뷰vo 조회
	public static reviewVO mvNoRv(int mvNo, int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, String> map = new HashMap<String, String>();
			String mNO = String.valueOf(mvNo);
			String rNO = String.valueOf(rvNo);
			
			map.put("mvNO", mNO);
			map.put("rvNo", rNO);
			System.out.println("map : " + map);
			
			return ss.selectOne("review.mvNoReview", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//리뷰 전체 건수 조회
	public static int getTotalCount() {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectOne("review.totalCnt");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//리뷰 전체 목록 조회
	public static List<reviewVO> getList() {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("review.all");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
//	//페이징 처리 - 해당 페이지의 리뷰 목록 조회
//	public static List<reviewVO> pList(int begin, int end) {
//		try (SqlSession ss = DBService.getFactory().openSession()) {
//			Map<String, Integer> map = new HashMap<>();
//			map.put("begin", begin);
//			map.put("end", end);
//			
//			return ss.selectList("review.pageList", map);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return null;
//	}

	//리뷰 작성(INSERT)
	public static int insert(reviewVO vo){
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.insert("review.insert", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//리뷰 수정(UPDATE)
	public static int update(reviewVO vo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.update("review.update", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//리뷰 삭제(DELETE)
		public static int delete(int rvNo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.delete("review.delete", rvNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
	
	//리뷰 1건 조회
	public static reviewVO selectOne(int rvNo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.selectOne("review.rvOne", rvNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//리뷰 정보 삭제(DELETE)
	public static int delete(reviewVO rvo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.delete("review.delete", rvo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//[REVIEW]테이블에서 월별 선택하여 rvVO(rvNo) 추출
	public static List<reviewVO> selectVO(String rvDate) {
		try (SqlSession ss = DBService.getFactory().openSession()){
			return ss.selectList("review.yymm", rvDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	} 

//	//추천수 COUNT+1(본인 리뷰가 아닌 경우 추천+1)
//	public static int recCnt(int rvNo, int rvRec) {
//		try (SqlSession ss = DBService.getFactory().openSession(true)) {
//			Map<String, Integer> map = new HashMap<>();
//			map.put("rvNo", rvNo);
//			map.put("rvRec", rvRec);
//			
//			return ss.update("review.rec", map);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return -1;
//	}
	

	//마이페이지 ==================================================
	//나의 리뷰목록 조회
	public static List<reviewVO> getReviewList(int no) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			List<reviewVO> reviewList = ss.selectList("review.getReviewByNo", no);
			for (reviewVO rvo : reviewList) {
				int rvNo = rvo.getRvNo();
				int warn = warnDAO.warnSum(rvNo);
				rvo.setRvWarn(warn);
				int rec = recDAO.recSum(rvNo);
				rvo.setRvRec(rec);
			}
			return reviewList;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//닉네임 수정 시 리뷰의 닉네임 업데이트
	public static int updateNickReview(int no, String nick) {
	    try (SqlSession ss = DBService.getFactory().openSession(true)) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("no", no);
	        map.put("nick", nick);
	        return ss.update("review.updateNickReview", map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}

	
}
