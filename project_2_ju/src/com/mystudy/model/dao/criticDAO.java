package com.mystudy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.criticVO;
import com.mystudy.model.vo.postVO;
import com.project.mybatis.DBService;


public class criticDAO {
	//전체 전문가 목록 조회
	public static List<criticVO> criticList() {
		System.out.println("criticList실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("critic.all");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
		
	//전문가 한명의 정보 조회
	public static criticVO criticOne(int no) {
		System.out.println("criticOne실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectOne("critic.one", no);
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return null;
	}
	
	//전문가 리뷰 건수 조회
	public static int criticCnt(int no) {
		System.out.println("criticCnt실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			System.out.println("ss.selectOne(\"critic.cnt\") : " + ss.selectOne("critic.cnt", no));
			return ss.selectOne("critic.cnt", no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//전문가 신청서 입력(INSERT) 
	public static int insert(int no) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.insert("critic.insert", no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//전문가 정보 업데이트(UPDATE)
	public static int update(criticVO cvo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.update("critic.update", cvo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//전문가 정보 삭제(DELETE)
	public static int delete(int no) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.delete("critic.delete", no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//전문가 한명의 정보 조회
	public static criticVO criticCone(int no) {
		System.out.println("criticCone실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectOne("critic.cone", no);
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return null;
	}
	
	//계정 번호 받아서 전문가 이름 찾기
	public static criticVO criticCname(int no) {
		System.out.println("criticCname실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectOne("critic.cname", no);
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return null;
	}
	
	//CRITICAPPLY
	//전문가 신청서 승인(INSERTAPPLY) 
	public static int insertApply(criticVO cvo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.insert("critic.insertApply", cvo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
	//전체 승인 목록 조회
	public static List<criticVO> criticApplyList() {
		System.out.println("criticApplyList실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("critic.allApply");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//전문가 정보 삭제(DELETE)
	public static int deleteApply(int no) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.delete("critic.deleteApply", no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}





