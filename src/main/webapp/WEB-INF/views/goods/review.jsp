<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오후 1:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CHICK</title>
</head>
<body>
    <h2>리뷰작성</h2>
    <form action="/review/save" method="post">
        <input type="hidden" name="goodsId" value="${goodsId}">
        <input type="hidden" name="memberId" value="${sessionScope.memberId}">
        <input type="text" name="reviewContents" placeholder="내용">
        <input type="submit" value="리뷰작성">
    </form>
</body>
</html>
