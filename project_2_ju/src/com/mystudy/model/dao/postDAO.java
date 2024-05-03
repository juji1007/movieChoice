package com.mystudy.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.List;


import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.postCommentVO;
import com.mystudy.model.vo.postVO;
import com.mystudy.model.vo.reviewVO;
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
		

		 //카테고리별 게시글 건수 조회
        public static int getCount(String idx, String keyword) {
           try (SqlSession ss = DBService.getFactory().openSession()) {
              Map<String, String> map = new HashMap<String, String>();
              map.put("idx", idx);
              map.put("keyword", keyword);
              
              return ss.selectOne("post.cnt", map);
           } catch (Exception e) {
              e.printStackTrace();
           }
           return -1;
        }


		
//		//게시글 작성자 닉네임 조회
//		public static postVO selectNick(int no) {
//			try (SqlSession ss = DBService.getFactory().openSession(true)) {
//				return ss.selectOne("post.nick", no);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			return null;
//		}
		
		// 게시글 입력(INSERT) 
		public static int insert(postVO po) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.insert("post.insert", po);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		//게시글 수정(UPDATE)
		public static int update(postVO po) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.update("post.update", po);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//게시글 삭제(DELETE)
		public static int delete(int psNo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.delete("post.delete", psNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//게시글 삭제(DELETE) - 건희
		public static int pDelete(postVO pvo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.delete("post.delete", pvo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//========= 댓글 관련 작업================
		//게시글에 딸린 댓글 찾기/검색/조회/선택
		public static List<postCommentVO> getCommList(int psNo) {
			try (SqlSession ss = DBService.getFactory().openSession()) {		
				return ss.selectList("post.commList", psNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		// 댓글입력
		public static int insertComment(postCommentVO cvo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.insert("post.commInsert", cvo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//댓글 1개 조회
		public static postCommentVO getComment(int pcNo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.selectOne("post.commOne", pcNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
		
		//댓글삭제
		public static int deleteComment(int pcNo) {
			try (SqlSession ss = DBService.getFactory().openSession(true)) {
				return ss.delete("post.commDelete", pcNo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		//댓글 전체 건수 조회
		public static int getPostCommentTotalCount() {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				return ss.selectOne("post.PostCommentTotalCnt");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		
		//마이페이지 ============================================ 
		//나의 자유게시판 조회
		public static List<postVO> getPostList(int no) {
			try (SqlSession ss = DBService.getFactory().openSession()) {
				List<postVO> postList = ss.selectList("post.getPostByNo", no);
				for (postVO pvo : postList) {
					int psNo = pvo.getPsNo();
					int warn = warnDAO.warnSumBypsNo(psNo);
					pvo.setPsWarn(warn);
				}
				return postList;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//닉네임 수정 시 자유게시판 닉네임 변경
		public static int updateNickPost(int no, String nick) {
		    try (SqlSession ss = DBService.getFactory().openSession(true)) {
		        Map<String, Object> map = new HashMap<>();
		        map.put("no", no);
		        map.put("nick", nick);
		        return ss.update("post.updateNickPost", map);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return -1;
		}
		
		//나의 댓글정보 조회
		public static List<postCommentVO> getCommListMy(int no) {
			try (SqlSession ss = DBService.getFactory().openSession()) {		
				return ss.selectList("post.commListMy", no);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
}

