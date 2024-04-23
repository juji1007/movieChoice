package com.mystudy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.criticVO;
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
			return ss.selectOne("critic.one");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
