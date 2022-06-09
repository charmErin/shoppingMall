<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 2:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <h2>로그인페이지</h2>
    <form action="/member/login" method="post">
        아이디<br>
        <input type="text" name="memberId"><br>
        비밀번호<br>
        <input type="password" name="memberPassword"><br>
        <input type="submit" value="로그인">
    </form>
</body>
</html>
