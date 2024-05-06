package com.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.model.dao.warnDAO;
import com.mystudy.model.vo.movieVO;
import com.mystudy.model.vo.postVO;
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
//         System.out.println(ss.selectOne("project2.login", map));
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
   
   //   아이디중복체크 -> 입력된아이디 DB에서 조회 null이면 성공
   public static int getAccountSearchNo(String id) {
         try (SqlSession ss = DBService.getFactory().openSession()) {
            System.out.println("checki id : " + id);
            return ss.selectOne("project2.NoById", id);
         } catch (Exception e) {
            e.printStackTrace();
         } 
         return -1;
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
   // 자유게시판 =====================================================
      //아이디로 유저넘버 조회 
      public static int getAccountNo(String id) {
         try (SqlSession ss = DBService.getFactory().openSession()) {
            System.out.println("id : " + id);
            return ss.selectOne("project2.noById", id);
         } catch (Exception e) {
            e.printStackTrace();
         }
         return -1;
      }
   

   // 자유게시판 =====================================================
   //아이디로 유저넘버 조회 (마이페이지에서도)
//   public static int getAccountNo(String id) {
//      try (SqlSession ss = DBService.getFactory().openSession()) {
//         System.out.println("id : " + id);
//         return ss.selectOne("project2.noById", id);
//      } catch (Exception e) {
//         e.printStackTrace();
//      }
//      return -1;
//   }
   

   // 마이페이지 =====================================================
   //로그인시 아이디로 전체내용 조회 
   public static List<AccountVO> getAccountList(String id) {
      try (SqlSession ss = DBService.getFactory().openSession()) {
         System.out.println("id : " + id);
         List<AccountVO> accountList = ss.selectList("project2.all", id);
         for (AccountVO avo : accountList) {
        	 int no = avo.getNo();
        	 int warn = warnDAO.warnSumByNo(no);
        	 avo.setWarn(warn);
        	 System.out.println(avo);
         }
         return accountList;
      } catch (Exception e) {
         e.printStackTrace();
      }
      return null;
   }
   
   public static AccountVO getAccount(String id) {
      try (SqlSession ss = DBService.getFactory().openSession()) {
         System.out.println("id : " + id);
         return ss.selectOne("project2.accountInfo", id);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return null;
   }
   
   public static int UpdateAccount(AccountVO avo) {
      try (SqlSession ss = DBService.getFactory().openSession(true)) {
         System.out.print("update계정실행 : ");
         System.out.println(avo);
         return ss.update("project2.update", avo);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   public static int delete(int no) {
      try (SqlSession ss = DBService.getFactory().openSession(true)) {
         System.out.print("delete계정실행 : ");
         System.out.println(no);
         return ss.delete("project2.delete", no);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   //아이디로 회원번호 조회
   public static int findNo(String id) {
      try (SqlSession ss = DBService.getFactory().openSession()) {
         return ss.selectOne("project2.findNo", id);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   //아이디로 회원번호 조회
   public static int findCriticCheck(int no) {
      try (SqlSession ss = DBService.getFactory().openSession()) {
         return ss.selectOne("project2.findCriticCheck", no);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   public static int updateCriticCheck(int no) {
      try (SqlSession ss = DBService.getFactory().openSession(true)) {
         System.out.print("updateCriticCheck실행");
         return ss.update("project2.updateCriticCheck", no);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   

   public static int updatedeleteCriticCheck(int no) {
      try (SqlSession ss = DBService.getFactory().openSession(true)) {
         System.out.print("updatedeleteCriticCheck실행");
         return ss.update("project2.updatedeleteCriticCheck", no);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   //계정 전체 건수 조회
   public static int getTotalCount() {
      try (SqlSession ss = DBService.getFactory().openSession()) {
         return ss.selectOne("project2.totalCnt");
      } catch (Exception e) {
         e.printStackTrace();
      }
      return -1;
   }
   
   

}