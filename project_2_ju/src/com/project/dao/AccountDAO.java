package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.project.mybatis.DBService;
import com.project.vo.AccountVO;

// 로그인
// 아이디 선택시 내용 있는지 -> 비밀번호 맞는지
// 회원가입
// 아이디 중복체크 -> 
// 아이디찾기 -> 이메일로 찾고 DB에 맞는게 있으면 -> all로 찾아서 아이디알려주기
// 비밀번호찾기 -> 아이디로 찾고 DB에 맞는게 있으면 -> 해당 아이디 유저 update 가능하게하기	
public class AccountDAO {
	
	// 로그인 =====================================================
	//로그인시 아이디로 전체내용 조회 -> 1.아이디 있는지 2. 비밀번호 일치한지 -> id : 값, pwd : 값
	public static AccountVO getAccountLogin(String id, String pwd) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			System.out.println("id : " + id);
			System.out.println("pwd : " + pwd);
			Map<String, String> map = new HashMap<>();
			map.put("id", id);
			map.put("pwd", pwd);
			return ss.selectOne("project2.login", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 회원가입 ===================================================
	//아이디중복체크 -> 입력된아이디 DB에서 조회 null이면 성공
	public static Boolean getAccountSearchLoginCheckId(String id) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			String checkId = ss.selectOne("project2.id", id);
			System.out.println("checkidDAO : " + checkId);
			if (checkId != null) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//회원가입 데이터 넣기
	public static int insertMember(AccountVO avo) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			return ss.insert("project2.insertMember", avo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 찾기 ===================================================
	//아이디찾기 -> 이메일 (닉네임)로
	public static String getAccountSearchId(String email) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			System.out.println("email : " + email);
			return ss.selectOne("project2.searchIdByEmail", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//비밀번호 찾기 -> 아이디로 인증 (중복체크랑 같은 로직)
	public static String getAccountSearchPwd(String id) {
		try (SqlSession ss = DBService.getFactory().openSession()) {
			return ss.selectOne("project2.id", id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//비밀번호 찾기 -> 비밀번호 재설정
	public static int setAccountPwd(String id, String pwd) {
		try (SqlSession ss = DBService.getFactory().openSession(true)) {
			System.out.println("id : " + id);
			System.out.println("pwd : " + pwd);
			Map<String, String> map = new HashMap<>();
			map.put("id", id);
			map.put("pwd", pwd);
			return ss.update("project2.updatePwdById", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
}
