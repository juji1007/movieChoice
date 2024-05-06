package com.mystudy.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.criticVO;
import com.mystudy.model.vo.inquiryVO;
import com.mystudy.model.vo.postVO;
import com.mystudy.model.vo.qnaVO;
import com.project.mybatis.DBService;

public class qnaDAO {
    
    // QA 전체 건수 조회
    public static int getTotalCount() {
        int totalCount = 0;
        try (SqlSession ss = DBService.getFactory().openSession()) {
            totalCount = ss.selectOne("qna.totalCount");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalCount;
    }

    // 페이지에 해당하는 글목록(QA) 가져오기(SELECT)
    public static List<qnaVO> getList(int begin, int end) {
        try (SqlSession ss = DBService.getFactory().openSession()) {
            Map<String, Integer> map = new HashMap<>();
            map.put("begin", begin);
            map.put("end", end);

            return ss.selectList("qna.list", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // QA 1개 조회
    public static qnaVO selectOne(int qaNo) {
        try (SqlSession ss = DBService.getFactory().openSession(true)) {
            return ss.selectOne("qna.one", qaNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 나의 QA 조회
    public static List<qnaVO> getMyQa(int no) {
        try (SqlSession ss = DBService.getFactory().openSession()) {
        	List<qnaVO> qnaList = ss.selectList("qna.getMyQa", no);
        	boolean checkInquiry = false;
        	for (qnaVO qvo : qnaList) {
        		int qaNo = qvo.getQaNo();
        		inquiryVO ivo = inquiryDAO.ione(qaNo);
        		System.out.println("ivo : " + ivo);
        		if (ivo != null) {
        			checkInquiry = true;
        		}
        		System.out.println("checkin : " + checkInquiry);
        		qvo.setInquiryCheck(checkInquiry);
        		System.out.println("qna : " + qvo);
        	}
            return qnaList;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 카테고리별 QA 동적 검색
    public static List<qnaVO> qnaList(String idx, String keyword, String checkQaCategory, String qaCategory) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("idx", idx); 
			map.put("keyword", keyword);
			map.put("checkQaCategory", checkQaCategory);
			map.put("qaCategory", qaCategory);
			
			System.out.println("map : " + map);
			
			return ss.selectList("qna.search", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
    
  //카테고리별 게시글 건수 조회
    public static int getCount(String idx, String keyword, String checkQaCategory, String qaCategory) {
       try (SqlSession ss = DBService.getFactory().openSession()) {
          Map<String, String> map = new HashMap<String, String>();
          map.put("idx", idx);
          map.put("keyword", keyword);
          map.put("checkQaCategory", checkQaCategory);
          map.put("qaCategory", qaCategory);
          
          return ss.selectOne("qna.cnt", map);
       } catch (Exception e) {
          e.printStackTrace();
       }
       return -1;
    }
    
    // QA 입력(INSERT) 
    public static int insert(qnaVO qvo) {
        try (SqlSession ss = DBService.getFactory().openSession(true)) {
            return ss.insert("qna.insert", qvo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    //게시글 수정(UPDATE)
  	public static int update(qnaVO qo) {
  		try (SqlSession ss = DBService.getFactory().openSession(true)) {
  			return ss.update("qna.update", qo);
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return -1;
  	}	
    
    // QA 삭제(DELETE)
    public static int delete(int qaNo) {
        try (SqlSession ss = DBService.getFactory().openSession(true)) {
            return ss.delete("qna.delete", qaNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
}

