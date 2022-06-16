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
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/cart_order.css">
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container col-2">
    <h2>로그인페이지</h2>
    <form action="/member/login" method="post">
        아이디
        <input class="form-control" type="text" name="memberId" autofocus>
        비밀번호
        <input class="form-control" type="password" name="memberPassword">
        <input class="btn btn-outline-info d-grid mx-auto" type="submit" value="로그인">
    </form>
</div>
</body>
</html>
