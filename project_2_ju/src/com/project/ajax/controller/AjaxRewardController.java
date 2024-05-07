package com.project.ajax.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.listTotDAO;
import com.mystudy.model.dao.recDAO;
import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.dao.warnDAO;
import com.mystudy.model.vo.listTotVO;
import com.mystudy.model.vo.reviewVO;

@WebServlet("/ajaxRewardController")
public class AjaxRewardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		System.out.println(":: AjaxRewardController doGet 시작~~");
			
		String action = request.getParameter("action");
		System.out.println("action : " + action);
		
//		String rwDate = (String)request.getAttribute("rwDate");
//		System.out.println("rwDate : " + rwDate);
		
		//날짜 조회한 이달의 리뷰
		if ("rwMainAjax".equals(action)) {
			System.out.println(">> action: rwMainAjax 요청 처리~~");
		
			//검색 클릭해서 다른날짜 조회
			//검색 종류 확인
			String rwDate = request.getParameter("date");
			System.out.println("검색 받은 date : " + rwDate);
			String year = rwDate.substring(0, 4);
			String month = rwDate.substring(5);
			String date = year + month;
			System.out.println("date : " + date);
			
			//DB 데이터 조회 후 JSON 형식 문자열 생성해서 응답하기
			//	 	rvDate(월별) 추천 수가 많은 vo를 선택하여 [reward]에 해당 월의 리뷰vo insert 
			//	 	화면에 보이는 페이지/관리자가 업로드 할 수 있는 페이지 따로 구현
			
			//review 테이블에서 월별로 rvNo 번호 추출
			List<reviewVO> list = reviewDAO.selectVO(date);
			System.out.println("넘겨 받은 날짜 List : " + list);
			
			//해당 월의 rvNo에서 높은 추천수인 rvNo번호 추출
			int rvNo = 0;
			int recNum = 0;
			List<Integer> rwRvNo = new ArrayList<>();
			int i;
			for(i=0; i < list.size(); i++) {
				rvNo = list.get(i).getRvNo();
				recNum = recDAO.getRec(rvNo);
				rwRvNo.add(i, recNum);
			}
			System.out.println("rwRvNo : " + rwRvNo);
			
			int largeRecNum = rwRvNo.get(0);
			int rvNoLarge = list.get(0).getRvNo();
			for(i=0; i < rwRvNo.size(); i++) {
				if (rwRvNo.get(i) > largeRecNum) {
					largeRecNum = rwRvNo.get(i);
					rvNoLarge = list.get(i).getRvNo();
				}
			}
			System.out.println("largeRwNo : " + largeRecNum);
			System.out.println("rvNoLarge : " + rvNoLarge);
			
			//rvNo(추천수 높은 largeRvNo)로 listTot에서 vo 정보 받아오기
			listTotVO vo = listTotDAO.selectOne(rvNoLarge);
			System.out.println("추천수 높은 vo : " +  vo);
			
			//rvRec, rvWarn 계산 처리 필요!!!=>request로 rvRec, rvWarn 넘겨주기 
			//추천수 sum 보여주기 계산
			int selRvNo = vo.getRvNo();
			System.out.println("> 이달의 리뷰 selRvNo : " + selRvNo);
			
			int rvRec = recDAO.recSum(selRvNo);
			System.out.println("::recDAO.recSum rvRec : " + rvRec);
			if (rvRec == -1) {
				rvRec = 0;
			}
			vo.setRvRec(rvRec);
			
			//신고수 sum 보여주기 계산
			int rvWarn = warnDAO.warnSum(rvNo);
			System.out.println("::warnDAO.warnSum rvWarn : " + rvWarn);
			if (rvWarn == -1) {
				rvWarn = 0;
			}
			vo.setRvWarn(rvWarn);
			System.out.println("<추천/신고 계산>추천수 높은 vo : " + vo);
			
			request.setAttribute("vo", vo);
			
			//JSON 형식 문자열 만들기
			// { "list" : [ {},{},{}, ..., {}] }
			String result = makeJson(vo);
			System.out.println("result : \n" + result);
			
			//응답하기
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print(result);
		}
		
	
		if ("rwDate".equals(action)) {
			System.out.println(">> action : rwDate 요청 처리~~");
			
		}
	}

	private String makeJson(listTotVO vo) {
		//JSON 형식 문자열 만들기
		StringBuilder result = new StringBuilder();
		result.append("{ \"vo\" : [");
		
		result.append("{");
	    result.append("\"no\": \"" + vo.getNo() + "\", ");
	    result.append("\"name\": \"" + vo.getName() + "\", ");
	    result.append("\"id\": \"" + vo.getId() + "\", ");
	    result.append("\"pwd\": \"" + vo.getPwd() + "\", ");
	    result.append("\"nick\": \"" + vo.getNick() + "\", ");
	    result.append("\"critic_check\": \"" + vo.getCritic_check() + "\", ");
	    result.append("\"email\": \"" + vo.getEmail() + "\", ");
	    result.append("\"warn\": \"" + vo.getWarn() + "\", ");

	    result.append("\"mvNo\": \"" + vo.getMvNo() + "\", ");
	    result.append("\"mvTitle\": \"" + vo.getMvTitle() + "\", ");
	    result.append("\"mvDirect\": \"" + vo.getMvDirect() + "\", ");
	    result.append("\"mvActor\": \"" + vo.getMvActor() + "\", ");
	    result.append("\"mvGenre\": \"" + vo.getMvGenre() + "\", ");
	    result.append("\"mvRate\": \"" + vo.getMvRate() + "\", ");
	    result.append("\"mvAudience\": \"" + vo.getMvAudience() + "\", ");
	    result.append("\"mvGrade\": \"" + vo.getMvGrade() + "\", ");
	    result.append("\"mvDate\": \"" + vo.getMvDate() + "\", ");
	    result.append("\"mvPoster\": \"" + vo.getMvPoster() + "\", ");

	    result.append("\"rvNo\": \"" + vo.getRvNo() + "\", ");
	    result.append("\"rvNick\": \"" + vo.getRvNick() + "\", ");
	    result.append("\"rvTitle\": \"" + vo.getRvTitle() + "\", ");
	    result.append("\"rvContent\": \"" + vo.getRvContent() + "\", ");
	    result.append("\"rvDate\": \"" + vo.getRvDate() + "\", ");
	    result.append("\"rvRate\": \"" + vo.getRvDate() + "\", ");
	    result.append("\"rvWarn\": \"" + vo.getRvWarn() + "\", ");
	    result.append("\"rvRec\": \"" + vo.getRvRec() + "\"");
	    result.append("}");
	    result.append("]}");
		
		return result.toString();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

}