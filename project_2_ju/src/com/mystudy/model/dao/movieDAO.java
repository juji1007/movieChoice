package com.mystudy.model.dao;
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.criticVO;
import com.mystudy.model.vo.movieVO;
import com.project.mybatis.DBService;

public class movieDAO {
	//영화 탑텐
	public static List<movieVO> getmvTop() {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("PROJECT2.mvTop");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;
	}
	
		//전체 영화목록
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
				return ss.selectOne("PROJECT2.mvTitleDetail", mvTitle);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return null;
		}
		
		//영화 중복 검색 -> 있으면 true
		public static Boolean getMovieSearchCheckDup(String mvTitle, String mvDirect) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				Map<String, String> map = new HashMap<String, String>();
				map.put("mvTitle", mvTitle);
				
				//형식지정해야함 수정필요
				String checkMvDirect = mvDirect.replace(" ", "").replace(",", "");
				System.out.println("checkMvDirect : " + checkMvDirect);
				
				map.put("mvDirect", mvDirect);
				System.out.println("map : " + map);
				String CheckmvTitle = ss.selectOne("movie.searchDup", map);
				System.out.println("CheckmvTitle : " + CheckmvTitle);
				if (CheckmvTitle != null) return true;
				else return false;
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return false;
		}
	

	//동적검색

		public static List<movieVO> getMovie(String idx) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				if (idx == null || idx.isEmpty()) {
		            // idx가 null이거나 비어 있는 경우 전체 영화 목록을 가져옵니다.
		            return ss.selectList("PROJECT2.mvTitle");
		        } else {
		            Map<String, String> map = new HashMap<>();
		            map.put("idx", idx);
		            return ss.selectList("PROJECT2.movie", map);
		        }
//				
//				Map<String, String> map = new HashMap<>();
//				map.put("idx", idx);
//				return ss.selectList("PROJECT2.movie", map);
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
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.delete("movie.delete", mvNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		//영화번호로 수정
		public static int update(movieVO mvo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.update("movie.update", mvo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		//영화번호로 추가
		public static int insert(movieVO mvo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.update("movie.insert", mvo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//영화 번호로 조회(추가)
		public static movieVO rOne(int mvNo) {
			System.out.println("rOne실행");
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.selectOne("movie.rone", mvNo);
			} catch (Exception e) { 
				e.printStackTrace();
			}
			return null;
		}
		
		//영화 전체 건수 조회
		public static int getTotalCount() {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.selectOne("movie.totalCnt");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//마이페이지 ====================================
		//영화 테이블에 추천 수, 회원 번호
		//회원 번호로 조회
		public static movieVO getMovie(int mvNo) {
			System.out.println("rOne실행");
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.selectOne("movie.rone", mvNo);
			} catch (Exception e) { 
				e.printStackTrace();
			}
			return null;
		}
		
}
