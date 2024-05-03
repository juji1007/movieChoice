package com.mystudy.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.vo.inquiryVO;
import com.mystudy.model.vo.qnaVO;
import com.project.mybatis.DBService;

public class inquiryDAO {
	 //IQ_CONTENT 정보 조회
  	public static inquiryVO ione(int qaNo) {
  		System.out.println("ione실행" + qaNo);
  		try (SqlSession ss = DBService.getFactory().openSession()) {
  			return ss.selectOne("inquiry.ione", qaNo);
  		} catch (Exception e) { 
  			e.printStackTrace();
  		}
  		return null;
  	}
  	
  	// INQUIRY 입력(INSERT) 
    public static int insert(inquiryVO ivo) {
        try (SqlSession ss = DBService.getFactory().openSession(true)) {
            return ss.insert("inquiry.insert", ivo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    // INQUIRY 삭제(DELETE)
    public static int delete(int iqNo) {
        try (SqlSession ss = DBService.getFactory().openSession(true)) {
            return ss.delete("inquiry.delete", iqNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
    
}
