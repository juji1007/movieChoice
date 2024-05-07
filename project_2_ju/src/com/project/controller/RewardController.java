package com.project.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.model.dao.listTotDAO;
import com.mystudy.model.dao.recDAO;
import com.mystudy.model.dao.reviewDAO;
import com.mystudy.model.dao.warnDAO;
import com.mystudy.model.vo.listTotVO;
import com.mystudy.model.vo.reviewVO;

//@WebServlet("/rewardController")
public class RewardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String category = request.getParameter("category");
		System.out.println("category : " + category);
		
		if("rwMain".equals(category)) {
			System.out.println(">> rwMain 요청 처리~~");
			
//		 	rvDate(월별) 추천 수가 많은 vo를 선택하여 [reward]에 해당 월의 리뷰vo insert 
//		 	화면에 보이는 페이지/관리자가 업로드 할 수 있는 페이지 따로 구현
			//rvDate 초기값은 시스템 날짜로 추출
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			Date now = new Date();
			
			String rvDate = sdf.format(now);
			System.out.println("rvDate : " + rvDate);
			
			//listTotVO의 전체 목록 리뷰 작성된 rvDate만 추출
			List<listTotVO> listAll = listTotDAO.getList();
			System.out.println("전체 목록 listAll : " + listAll);
			
			//중복된 날짜 빼고 set에 yyyymm값 저장
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
			String thisMonth = sdf2.format(now); //이번달 날짜
			String valueThisMonth = sdf.format(now); //이번달 날짜
			
			request.setAttribute("thisMonth", thisMonth);
			request.setAttribute("valueThisMonth", valueThisMonth);
			
			Set<String> set = new HashSet<>();
			Set<String> setValue = new HashSet<>();
			Map<String, Set<String>> map = new HashMap<>();
			for (int i = 0; i < listAll.size(); i++) {
				//option태그 표시 값
				String yearMonth = sdf2.format(listAll.get(i).getRvDate()); //yyyy-MM
				set.add(yearMonth);
				//option태그 value 값
				String yyyyMM = sdf.format(listAll.get(i).getRvDate());
				setValue.add(yyyyMM);
				
				//set-setValue를 묶어서 Map<String, Set<String>>에 저장
				map.put("set", set);
				map.put("setValue", setValue);
			}
			request.setAttribute("setValue", setValue);
			
			//set에서 이번달 날짜 제거
			set.remove(thisMonth);
			setValue.remove(valueThisMonth);
			System.out.println("set : " + set);
			request.setAttribute("set", set);
			
			System.out.println("map : " + map);
			request.setAttribute("map", map);
			
			Set<String> s = map.get("set");
			Set<String> sv = map.get("setValue");
			request.setAttribute("s", s);
			request.setAttribute("sv", sv);
			
			//review 테이블에서 월별로 rvNo 번호 추출
			List<reviewVO> list = reviewDAO.selectVO(rvDate);
			System.out.println("시스템날짜 List : " + list);
			
			//해당 월의 rvNo에서 높은 추천수인 rvNo번호 추출
			int rvNo = 0;
			int recNum = 0;
			int i;
			List<Integer> rwRvNo = new ArrayList<>();
			
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
			
			request.setAttribute("rwVo", vo);
			
			request.getRequestDispatcher("rwMain.jsp").forward(request, response);
		}
		
		if("search".equals(category)) {
			System.out.println(">> search 요청 처리~~");
			
			String search = request.getParameter("search");
			System.out.println("search : " + search);
			String year = search.substring(0, 4);
			String month = search.substring(5);
			
			//search(=날짜) 조건으로 List<listTotVO>에서 최고 추천수의 rvNo 추출
			List<listTotVO> dateVO = listTotDAO.dateVO(year, month);
			System.out.println("::DB 연결 후, dateVO : " + dateVO);
			
			//해당 월의 rvNo에서 높은 추천수인 rvNo번호 추출
			int rvNo = 0;
			int recNum = 0;
			int i;
			List<Integer> rwRvNo = new ArrayList<>();
			
			for(i=0; i < dateVO.size(); i++) {
				rvNo = dateVO.get(i).getRvNo();
				recNum = recDAO.getRec(rvNo);
				rwRvNo.add(i, recNum);
			}
			System.out.println("rwRvNo : " + rwRvNo);
			
			int largeRecNum = rwRvNo.get(0);
			int rvNoLarge = dateVO.get(0).getRvNo();
			for(i=0; i < rwRvNo.size(); i++) {
				if (rwRvNo.get(i) > largeRecNum) {
					largeRecNum = rwRvNo.get(i);
					rvNoLarge = dateVO.get(i).getRvNo();
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
			
			request.setAttribute("rwVo", vo);
			
			request.getRequestDispatcher("rwMain_ajax.jsp").forward(request, response);
//			request.getRequestDispatcher("rwMain.jsp").forward(request, response);
			
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
