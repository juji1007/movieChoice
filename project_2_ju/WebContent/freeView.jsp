<%@page import="com.project.dao.AccountDAO"%>
<%@page import="com.project.vo.AccountVO"%>
<%@page import="com.sun.nio.sctp.PeerAddressChangeNotification"%>
<%@page import="com.mystudy.model.vo.postCommentVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.model.dao.postDAO"%>
<%@page import="com.mystudy.model.vo.postVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
   int psNo = Integer.parseInt(request.getParameter("psNo"));
//     int pcNo = Integer.parseInt(request.getParameter("pcNo"));
//   int no = Integer.parseInt(request.getParameter("no"));
   String cPage = request.getParameter("cPage");
   
   postVO pvo = postDAO.selectOne(psNo);
   System.out.println("게시글 pvo : " + pvo);
   session.setAttribute("pvo", pvo);
   session.setAttribute("cPage", cPage);
   
   // 게시물 댓글
   session.getAttribute("no");
   session.getAttribute("nick");
   List<postCommentVO> commList = postDAO.getCommList(psNo);
   System.out.println("댓글목록 commList : " + commList);
   session.setAttribute("c_list", commList);//댓글목록
//    System.out.println("댓글작성자번호 : " + commList.get(0).getNo());
   

   session.getAttribute("coo");


%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세</title>
<!-- <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<script>

//   게시물 삭제 확인 및 권한
function ps_delete(frm) {
      let isDelete = confirm("삭제하시겠습니까?");
//    let isDelete = confirm(${no});
   if(isDelete) {
         if(${no} == ${pvo.no}) {
         frm.submit();
         alert("삭제가 완료되었습니다.")
         }
         else {
         alert("삭제권한이 없습니다");
//          history.back();
         }
   
   }
}
// 게시물 수정 권한
function ps_update(frm) {
   if(${no} == ${pvo.no}) {
      frm.submit();
   }else {
      alert("수정권한이 없습니다.")
   }
}

// 댓글 삭제 확인
   function pc_delete(frm, commNo) {
      let isDelete = confirm("삭제하시겠습니까?");
//       alert(commNo);
      if(isDelete) {
         if(${no} == commNo) {
         frm.submit();
         alert("삭제가 완료되었습니다.")
         }
         else {
         alert("삭제권한이 없습니다");
//          history.back();
         }
   
      }
   }

   //목록보기
   function list_go() {
      location.href = "free.jsp";
   }
   //로그인 후 작성가능
   function login_confirm(frm) {
<% 
   if (session.getAttribute("no") == null) {
%>
   alert("로그인 후 작성 가능합니다.");
   frm.location.href = "freeView.jsp";
<%
   }
   else 
%>
   frm.submit();
}
   //게시물 신고버튼
   
   function warn_push() {
   let isWarn = alert("신고하시겠습니까?")

   }

</script>
</head>
<body>

<table>
   <tr>
   <td colspan=3><h1>${pvo.psTitle }</h1></td>
   </tr>
   <tr>
   <td>${pvo.psNick }</td>
   <td>${pvo.no }</td>
   <td>${pvo.psDate }</td>
   <td>
   <td>
   <form action="postDelete.jsp" method="get">
      <input class="h_button" type="button" value="삭제" onclick="ps_delete(this.form)">
      <input type="hidden" name="psNo" value="${pvo.psNo }">
      <input type="hidden" name="no" value="${vo.no }">
      
   </form>
   </td>
   <td>
   <form action="postUpdate.jsp" method="get">
   <input type="button" value="수정" onclick="ps_update(this.form)">
   <input type="hidden" name="psNo" value="${pvo.psNo }">
   <input type="hidden" name="no" value="${vo.no }">
   </form>
   </td>
   <td>
   <input type="button" value="목록보기" onclick="list_go()">
   <input type="button" value="신고" onclick="warn_push()">
   </td>
   </tr>
</table>

<hr>
<tr>
   <td colspan=3>${pvo.psContent }</td>
</tr>
<tr>
<td>
   <c:if test="${empty pvo.psFile }">
      첨부파일없음
      </c:if>
      <c:if test="${not empty pvo.psFile }">
                  
      <img src="img/${pvo. psOrifile }" width="200">
      </c:if>
   </td>
</tr>

<hr>
<!-- 댓글작성 -->
<form action="postComment_write_ok.jsp" method="post">
      <input type="hidden" name="no" value="${no }">
      <textarea name="pcContent" rows="2" cols="55"></textarea>
      <input type="button" value="댓글작성" onclick="login_confirm(this.form)">
      <input type="hidden" name="psNo" value="${pvo.psNo }">
      <input type="hidden" name="cPage" value="${cPage }">
   </form>
   <hr>

<!-- 댓글표시 및 삭제-->
<c:forEach var="commVO" items="${c_list }">
   <div>
      <form action="postComment_del_ok.jsp" method="get">
         <p>${commVO.pcNick } ${commVO.no } ${commVO.pcDate }</p>
         <p>${commVO.pcContent }</p>
         <input type="button" value="댓글삭제"  data-comm-no="${commVO.no}" onclick="pc_delete(this.form, this.dataset.commNo)">
         <input type="hidden" name="pcNo" value="${commVO.pcNo }">
         <input type="hidden" name="no" value="${commVO.no }">
      </form>
   
   </div>
   <hr>
   </c:forEach>
</body>
</html>