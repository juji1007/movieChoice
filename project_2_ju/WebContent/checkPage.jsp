<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String pwd = request.getParameter("pwdCheck");
    System.out.println("checkdelid : " + id);
    System.out.println("checkdelpw : " + pwd);

    String location = request.getParameter("location");
    System.out.println("location : " + location);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Delete</title>
    <script>
        function confirmDelete() {
            var check = confirm("회원 강제 탈퇴시키시겠습니까?");
            if (check) {
                // 삭제 확인 시
                var id = "<%=id%>";
                var pwd = "<%=pwd%>";
                var location = "<%=location%>";
                var url = "";

                // 삭제 요청 URL 설정
                if (location === "admin") {
                    url = "loginController?type=deleteAccountOk&location=" + location + "&id=" + id + "&pwdCheck=" + pwd;
                } else {
                    url = "manage.jsp";
                }

                window.location.href = url;
            } else {
            }
        }
    </script>
</head>
<body>
    <script>
        window.onload = confirmDelete;
    </script>
</body>
</html>
