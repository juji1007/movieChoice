package com.mystudy.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.List;


import org.apache.ibatis.session.SqlSession;


import com.mystudy.model.vo.qnaVO;
import com.project.mybatis.DBService;



public class qnaDAO {
	
	//QA 전체 건수 조회
	public static int getTotalCount() {
		int totalCount = 0;
		try (SqlSession ss = DBService.getFactory().openSession()) {
			totalCount = ss.selectOne("qna.totalCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	//페이지에 해당하는 글목록(QA) 가져오기(SELECT)
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
		
		//QA 1개 조회
		public static qnaVO selectOne(int qaNo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.selectOne("qna.one", qaNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
}

