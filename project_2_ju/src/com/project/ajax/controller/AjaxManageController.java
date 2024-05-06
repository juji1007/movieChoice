package com.project.ajax.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mystudy.model.dao.listTotDAO;
import com.mystudy.model.dao.movieDAO;
import com.mystudy.model.dao.postDAO;
import com.mystudy.model.dao.qnaDAO;
import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.vo.listTotVO;
import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.postCommentVO;
import com.mystudy.model.vo.postVO;
import com.mystudy.model.vo.qnaVO;
import com.mystudy.model.vo.reviewVO;
import com.mystudy.post.common.Paging;
import com.project.dao.AccountDAO;
import com.project.dao.AdminDAO;
import com.project.vo.AccountVO;

@WebServlet("/ajaxManageController")
public class AjaxManageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		System.out.println("action :" + action);
		
		//관리자검색처리
		if ("manageCategory".equals(action)) {
			System.out.println("검색처리");
			
			//검색종류 받아서 검색
			String idx = req.getParameter("idx");
			String keyword = req.getParameter("keyword");
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			//없으면 다시 처음화면으로
			if (idx == null || idx.trim().length() == 0) {
//				req.getRequestDispatcher("manage.jsp").forward(req, resp);
				return;
			}
			
			//검색DB처리 sql로 warn테이블에 따오기
			Map<String, List<?>> listSearch = AdminDAO.selectData(idx, keyword);
			System.out.println("ajaxlistSearch : " + listSearch);
			//listSearch없으면 다시 처음화면으로
			if (listSearch == null) {
//				req.getRequestDispatcher("manage.jsp").forward(req, resp);
				return;
			} 
			// 키값 가져오기
			Set<String> keys = listSearch.keySet();
			for (String key : keys) {
			    System.out.println("Key: " + key);
			}
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
			
		}
		
		//유저관리자검색처리
		if ("accountManageCategory".equals(action)) {
			System.out.println("유저검색처리");
			
			//검색종류 받아서 검색
			String idx = req.getParameter("idx");
			String keyword = req.getParameter("keyword");
			System.out.println("idx, keyword : " + idx + ", " + keyword);
			
			//없으면 다시 처음화면으로
			if (idx == null || idx.trim().length() == 0) {
				req.getRequestDispatcher("accountManage.jsp").forward(req, resp);
				return;
			}
			
			//검색DB처리
			List<AccountVO> list = AdminDAO.selectAccountData(idx, keyword);
			System.out.println("ajaxlistSearch : " + list);
			//listSearch없으면 다시 처음화면으로
			if (list == null) {
				req.getRequestDispatcher("accountManage.jsp").forward(req, resp);
				return;
			} 
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("account", list);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
			
		}
		
		//마이페이지처리 =====================================
		//회원정보
		if ("accountMypage".equals(action)) {
			System.out.println("마이페이지유저처리");
			
			//로그인 아이디로 검색처리
			HttpSession session = req.getSession();
			String id = (String) session.getAttribute("id");
			System.out.println("id : " + id);
			
			//없으면 다시 처음화면으로
			if (id == null || id.trim().length() == 0) {
				req.getRequestDispatcher("myPage.jsp").forward(req, resp);
				return;
			}
			
			List<AccountVO> avoList = AccountDAO.getAccountList(id);
			System.out.println("avoList : " + avoList);
			
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("account", avoList);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
			
		}
		//나의 리뷰목록
		if ("reviewMypage".equals(action)) {
			System.out.println("마이페이지리뷰처리");
			
			//로그인 아이디로 검색처리
			HttpSession session = req.getSession();
			String id = (String) session.getAttribute("id");
			System.out.println("id : " + id);
			
			//없으면 다시 처음화면으로
			if (id == null || id.trim().length() == 0) {
				req.getRequestDispatcher("myPage.jsp").forward(req, resp);
				return;
			}
			
			int no = AccountDAO.getAccountNo(id);
			System.out.println("avoNo : " + no);
			
		    List<reviewVO> rvoList = reviewDAO.getReviewList(no);
		    System.out.println("rvoList : " + rvoList);
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("review", rvoList);
			System.out.println("listSearch : " + listSearch);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
			
		}
		//나의 자유게시판
		if ("postMypage".equals(action)) {
			System.out.println("마이페이지post처리");
			
			//로그인 아이디로 검색처리
			HttpSession session = req.getSession();
			String id = (String) session.getAttribute("id");
			System.out.println("id : " + id);
			
			//없으면 다시 처음화면으로
			if (id == null || id.trim().length() == 0) {
				req.getRequestDispatcher("myPage.jsp").forward(req, resp);
				return;
			}
			
			int no = AccountDAO.getAccountNo(id);
			System.out.println("avoNo : " + no);
			
		    List<postVO> pvoList = postDAO.getPostList(no);
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("post", pvoList);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
					
		}
		//나의 댓글 정보
		if ("postCommentMypage".equals(action)) {
			System.out.println("마이페이지postComment처리");
			
			//로그인 아이디로 검색처리
			HttpSession session = req.getSession();
			String id = (String) session.getAttribute("id");
			System.out.println("id : " + id);
			
			//없으면 다시 처음화면으로
			if (id == null || id.trim().length() == 0) {
				req.getRequestDispatcher("myPage.jsp").forward(req, resp);
				return;
			}
			
			int no = AccountDAO.getAccountNo(id);
			System.out.println("avoNo : " + no);

			List<postCommentVO> pcoList = postDAO.getCommListMy(no);
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("postComment", pcoList);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
		}
		//나의 qna 정보
		if ("qnaMypage".equals(action)) {
			System.out.println("마이페이지qna처리");
			
			//로그인 아이디로 검색처리
			HttpSession session = req.getSession();
			String id = (String) session.getAttribute("id");
			System.out.println("id : " + id);
			
			//없으면 다시 처음화면으로
			if (id == null || id.trim().length() == 0) {
				req.getRequestDispatcher("myPage.jsp").forward(req, resp);
				return;
			}
			
			int no = AccountDAO.getAccountNo(id);
			System.out.println("avoNo : " + no);

			List<qnaVO> qnaList = qnaDAO.getMyQa(no);
			Map<String, List<?>> listSearch = new HashMap<>();
			listSearch.put("qna", qnaList);
			String result = makeJson(listSearch);
			
			System.out.println("result : \n" + result);
			
			// 응답
			resp.setContentType("application/json; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.print(result);
		}
		
	}
	
	private String makeJson(Map<String, List<?>> listSearch) {
		//Json만들기
		StringBuilder result = new StringBuilder();
		result.append("{ \"listSearch\" : [");
		// 맵의 각 항목을 반복하면서 키와 값을 가져옴
		for (Map.Entry<String, List<?>> entry : listSearch.entrySet()) {
		    String key = entry.getKey(); // 현재 항목의 키 가져오기
		    List<?> value = entry.getValue(); // 현재 항목의 값(리스트) 가져오기
		    
		    System.out.println("Key: " + key);
		    System.out.println("Value: " + value);
		    // 리스트의 각 요소 Json넣기
		    
		    if (value == null || value.isEmpty()) {
		    	if ("account".equals(key)) {
		    		System.out.println("review value null");
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"no\": \"" + null + "\", ");
		            result.append("\"name\": \"" + null + "\", ");
		            result.append("\"id\": \"" + null + "\", ");
		            result.append("\"pwd\": \"" + null + "\", ");
		            result.append("\"nick\": \"" + null + "\", ");
		            result.append("\"criticCheck\": \"" + null + "\", ");
		            result.append("\"email\": \"" + null + "\", ");
		            result.append("\"warn\": \"" + null + "\"");
		            result.append("},");
		    	}
		    	if ("review".equals(key)) {
		    		System.out.println("review value null");
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"rvNo\": \"" + null + "\", ");
		            result.append("\"mvNo\": \"" + null + "\", ");
		            result.append("\"no\": \"" + null + "\", ");
		            result.append("\"rvNick\": \"" + null + "\", ");
		            result.append("\"rvTitle\": \"" + null + "\", ");
		            result.append("\"rvContent\": \"" + null + "\", ");
		            result.append("\"rvDate\": \"" + null + "\", ");
		            result.append("\"rvRec\": \"" + null + "\", ");
		            result.append("\"warn\": \"" + null + "\"");
		            result.append("},");
		    	}
		    	if ("movie".equals(key)) {
		    		 result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"mvNo\": \"" + null + "\", ");
		            result.append("\"mvTitle\": \"" + null + "\", ");
		            result.append("\"mvDirect\": \"" + null + "\", ");
		            result.append("\"mvActor\": \"" + null + "\", ");
		            result.append("\"mvGenre\": \"" + null + "\", ");
		            result.append("\"mvRate\": \"" + null + "\", ");
		            result.append("\"mvAudience\": \"" + null + "\", ");
		            result.append("\"mvGrade\": \"" + null + "\", ");
		            result.append("\"mvDate\": \"" + null + "\", ");
		            result.append("\"mvPoster\": \"" + null + "\"");
		            result.append("},");
		    	}
		    	if ("post".equals(key)) {
		    		result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"psNo\": \"" + null + "\", ");
		            result.append("\"no\": \"" + null + "\", ");
		            result.append("\"psTitle\": \"" + null + "\", ");
		            result.append("\"psContent\": \"" + null + "\", ");
		            result.append("\"psDate\": \"" + null + "\", ");
		            result.append("\"psFile\": \"" + null + "\", ");
		            result.append("\"psWarn\": \"" + null + "\", ");
		            result.append("\"psNick\": \"" + null + "\"");
		            result.append("},");
		    	}
		    	if ("postComment".equals(key)) {
		        	result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"pcNo\": \"" + null + "\", ");
		            result.append("\"psNo\": \"" + null + "\", ");
		            result.append("\"no\": \"" + null + "\", ");
		            result.append("\"pcDate\": \"" + null + "\", ");
		            result.append("\"pcContent\": \"" + null + "\", ");
		            result.append("\"pcNick\": \"" + null + "\"");
		            result.append("},");
		        }
		    	if ("qna".equals(key)) {
		        	result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"qaNo\": \"" + null + "\", ");
		            result.append("\"no\": \"" + null + "\", ");
		            result.append("\"qaContent\": \"" + null + "\", ");
		            result.append("\"qaTitle\": \"" + null + "\", ");
		            result.append("\"qaDate\": \"" + null + "\", ");
		            result.append("\"id\": \"" + null + "\", ");
		            result.append("\"qaCategory\": \"" + null + "\", ");
		            result.append("\"criticCheck\": \"" + null + "\", ");
		            result.append("\"inquiryCheck\": \"" + null + "\"");
		            result.append("},");
		        }
		    }
		    for (Object item : value) {
		        if ("review".equals(key)) {
		            reviewVO rvo = new reviewVO();
		            rvo = (reviewVO) item;
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"rvNo\": \"" + rvo.getRvNo() + "\", ");
		            result.append("\"mvNo\": \"" + rvo.getMvNo() + "\", ");
		            result.append("\"no\": \"" + rvo.getNo() + "\", ");
		            result.append("\"rvNick\": \"" + rvo.getRvNick() + "\", ");
		            result.append("\"rvTitle\": \"" + rvo.getRvTitle() + "\", ");
		            result.append("\"rvContent\": \"" + rvo.getRvContent() + "\", ");
		            result.append("\"rvDate\": \"" + rvo.getRvDate() + "\", ");
		            result.append("\"rvRec\": \"" + rvo.getRvRec() + "\", ");
		            result.append("\"warn\": \"" + rvo.getRvWarn() + "\"");
		            result.append("},");
		        }
		        
		        if ("movie".equals(key)) {
		            movieVO mvo = (movieVO) item;
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"mvNo\": \"" + mvo.getMvNo() + "\", ");
		            result.append("\"mvTitle\": \"" + mvo.getMvTitle() + "\", ");
		            result.append("\"mvDirect\": \"" + mvo.getMvDirect() + "\", ");
		            result.append("\"mvActor\": \"" + mvo.getMvActor() + "\", ");
		            result.append("\"mvGenre\": \"" + mvo.getMvGenre() + "\", ");
		            result.append("\"mvRate\": \"" + mvo.getMvRate() + "\", ");
		            result.append("\"mvAudience\": \"" + mvo.getMvAudience() + "\", ");
		            result.append("\"mvGrade\": \"" + mvo.getMvGrade() + "\", ");
		            result.append("\"mvDate\": \"" + mvo.getMvDate() + "\", ");
		            result.append("\"mvPoster\": \"" + mvo.getMvPoster() + "\"");
		            result.append("},");
		        }
		        
		        if ("account".equals(key)) {
		        	AccountVO avo = (AccountVO) item;
		            result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"no\": \"" + avo.getNo() + "\", ");
		            result.append("\"name\": \"" + avo.getName() + "\", ");
		            result.append("\"id\": \"" + avo.getId() + "\", ");
		            result.append("\"pwd\": \"" + avo.getPwd() + "\", ");
		            result.append("\"nick\": \"" + avo.getNick() + "\", ");
		            result.append("\"criticCheck\": \"" + avo.getCriticCheck() + "\", ");
		            result.append("\"email\": \"" + avo.getEmail() + "\", ");
		            result.append("\"warn\": \"" + avo.getWarn() + "\"");
		            result.append("},");
		        }
		        
		        if ("post".equals(key)) {
		        	postVO pvo = (postVO) item;
		        	result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"psNo\": \"" + pvo.getPsNo() + "\", ");
		            result.append("\"no\": \"" + pvo.getNo() + "\", ");
		            result.append("\"psTitle\": \"" + pvo.getPsTitle() + "\", ");
		            result.append("\"psContent\": \"" + pvo.getPsContent() + "\", ");
		            result.append("\"psDate\": \"" + pvo.getPsDate() + "\", ");
		            result.append("\"psFile\": \"" + pvo.getPsFile() + "\", ");
		            result.append("\"psWarn\": \"" + pvo.getPsWarn() + "\", ");
		            result.append("\"psNick\": \"" + pvo.getPsNick() + "\"");
		            result.append("},");
		        }
		        
		        if ("postComment".equals(key)) {
		        	postCommentVO pco = (postCommentVO) item;
		        	result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"pcNo\": \"" + pco.getPcNo() + "\", ");
		            result.append("\"psNo\": \"" + pco.getPsNo() + "\", ");
		            result.append("\"no\": \"" + pco.getNo() + "\", ");
		            result.append("\"pcDate\": \"" + pco.getPcDate() + "\", ");
		            result.append("\"pcContent\": \"" + pco.getPcContent() + "\", ");
		            result.append("\"pcNick\": \"" + pco.getPcNick() + "\"");
		            result.append("},");
		        }
		        
		        if ("qna".equals(key)) {
		        	qnaVO qvo = (qnaVO) item;
		        	result.append("{");
		            result.append("\"table\": \"" + key + "\", ");
		            result.append("\"qaNo\": \"" + qvo.getQaNo() + "\", ");
		            result.append("\"no\": \"" + qvo.getNo() + "\", ");
		            result.append("\"qaContent\": \"" + qvo.getQaContent() + "\", ");
		            result.append("\"qaDate\": \"" + qvo.getQaDate() + "\", ");
		            result.append("\"nick\": \"" + qvo.getNick() + "\", ");
		            result.append("\"qaCategory\": \"" + qvo.getQaCategory() + "\", ");
		            result.append("\"criticCheck\": \"" + qvo.getCriticCheck() + "\", ");
		            result.append("\"inquiryCheck\": \"" + qvo.getisInquiryCheck() + "\"");
		            result.append("},");
		        }
		    }
		}
		result.deleteCharAt(result.length() - 1); // 마지막 쉼표(,) 제거
		result.append("]}");

		return result.toString();
	}
	
	private String makePage(Map<String, List<?>> listSearch, String cPage) {
		//페이징 처리를 위한 객체(Paging) 생성
		Paging p = new Paging();
		
		p.setNumPerPage(5);
		p.setPagePerBlock(5);
		
		//1. 전체 게시물 수량 구하기
		// 키값이랑 비교해서 각 맞는 vo형태로 count 출력 (myPage는 -> where no 조건)
		// myPage에서는 각자 페이지 따로만듬
		// manage에서는 count 전부 합침 -> listTot이용
		int totalRecord = 0;
		
		for (Map.Entry<String, List<?>> entry : listSearch.entrySet()) {
			String key = entry.getKey();
	        List<?> value = entry.getValue();
	        
	        System.out.println("PageKey: " + key);
		    System.out.println("PageValue: " + value);
		    
		    int count = 0;
		    if ("review".equals(key)) {
		    	count = reviewDAO.getTotalCount();
	        }
	        
	        if ("movie".equals(key)) {
	        	count = movieDAO.getTotalCount();
	        }
	        
	        if ("account".equals(key)) {
	        	count = AccountDAO.getTotalCount();
	        }
	        
	        if ("post".equals(key)) {
	        	count = postDAO.getTotalCount();
	        }
	        
	        if ("postComment".equals(key)) {
	        	count = postDAO.getPostCommentTotalCount();
	        }
	    
	        totalRecord += count;
		}
		
		p.setTotalRecord(totalRecord);
		p.setTotalPage();

		System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
		System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
		
		//2. 현재 페이지 번호 구하기
//		String cPage = request.getParameter("cPage");
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		}
		System.out.println("> cPage : " + cPage);
		System.out.println("> Paging nowPage : " + p.getNowPage());
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		
		System.out.println(">> 시작번호(begin) : " + p.getBegin());
		System.out.println(">> 끝번호(end) : " + p.getEnd());
		
		//4. --- 블록(block) 계산하기 -----
		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		p.setNowBlock(nowBlock);
		p.setEndPage(nowBlock * p.getPagePerBlock());
		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		System.out.println(">> nowBlock : " + p.getNowBlock());
		System.out.println(">> beginPage : " + p.getBeginPage());
		System.out.println(">> endPage : " + p.getEndPage());
		
		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
			System.out.println(">>정정 후 endPage : " + p.getEndPage());
		}
		
		//페이징 + 리뷰 전체(영화,회원) 목록
		List<listTotVO> listAll = listTotDAO.listTotAll(p.getBegin(), p.getEnd());
		System.out.println(">> 메인 listAll : " + listAll);
		
//		request.setAttribute("listAll", listAll);
		
//		request.setAttribute("rvPvo", p);
		return null;
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}