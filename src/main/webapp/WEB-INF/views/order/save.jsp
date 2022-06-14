<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-14
  Time: 오후 3:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>CHICK</title>
</head>
<body>
    <h2>주문 페이지</h2>
    <c:forEach var="goods" items="${goodsList}">
        ${goods}<br>
    </c:forEach>
</body>
</html>
