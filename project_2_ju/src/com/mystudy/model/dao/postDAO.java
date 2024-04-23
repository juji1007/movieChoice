package com.mystudy.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.postVO;
import com.project.mybatis.DBService;

public class postDAO {
	//전체 자유게시판 글 목록 조회
	public static List<postVO> postList() {
		System.out.println("postList실행");
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectList("post.all");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}