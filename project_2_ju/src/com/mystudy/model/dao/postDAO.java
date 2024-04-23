package com.mystudy.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.List;


import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.postVO;
import com.project.mybatis.DBService;



public class postDAO {
	
	//게시글 전체 건수 조회
	public static int getTotalCount() {
		int totalCount = 0;
		try (SqlSession ss = DBService.getFactory().openSession()) {
			totalCount = ss.selectOne("post.totalCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	//페이지에 해당하는 글목록(게시글) 가져오기(SELECT)
		public static List<postVO> getList(int begin, int end) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				Map<String, Integer> map = new HashMap<>();
				map.put("begin", begin);
				map.put("end", end);
				
				return ss.selectList("post.list", map);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//게시글 1개 조회
		public static postVO selectOne(int psNo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.selectOne("post.one", psNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		//카테고리별 게시글 동적 검색
		public static List<postVO> freeList(String idx, String keyword) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("idx", idx);
				map.put("keyword", keyword);
				
				return ss.selectList("post.search", map);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		// 게시글 입력(INSERT) 
		public static int insert(postVO pvo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.insert("post.insert", pvo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
}

