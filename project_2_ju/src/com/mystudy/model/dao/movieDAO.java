package com.mystudy.model.dao;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.movieVO;
import com.project.mybatis.DBService;

public class movieDAO {
	public static List<movieVO> getmvTitle() {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("PROJECT2.mvTitle");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	
	//영화검색
			public static movieVO getmvTitleList(String mvTitle) {
				try (SqlSession ss = DBService.getFactory().openSession()) {
					return ss.selectOne("PROJECT2.mvTitleList", mvTitle);
				} catch (Exception e) {
					e.printStackTrace();
				} 
				return null;
			}
	
	//동적검색(사번,이름,직종,부서)
		public static List<movieVO> getMovie(String idx) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				Map<String, String> map = new HashMap<>();
				map.put("idx", idx);
				return ss.selectList("PROJECT2.movie", map);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return null;
		}
		
		//민지
		//영화목록 전체조회
		public static List<movieVO> movieList() {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.selectList("movie.all");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//건희
		//영화번호로 조회
		public static movieVO searchOne(int mvNo) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.selectOne("movie.one", mvNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//재일
		//영화번호로 삭제
		public static int delete(int mvNo) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.delete("movie.delete", mvNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		//영화번호로 수정
		public static int update(int mvNo) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.update("movie.update", mvNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
}
