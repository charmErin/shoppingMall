<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-15
  Time: 오전 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/cart_order.css">
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>

    <h2>주문목록</h2>
    <c:forEach var="order" items="${orderList}">
        ${order}<br>
    </c:forEach>
</body>
</html>
