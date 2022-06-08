<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 7:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <h2>TOP</h2>
    <c:forEach var="goods" items="${goodsList}">
        ${goods.goodsName}<br>
        ${goods.goodsDetail}<br>
        <c:choose>
            <c:when test="${goods.goodsDiscount ne 1}}">
                ${goods.goodsPrice * goods.goodsDiscount}<br>
            </c:when>
            <c:otherwise>
                ${goods.goodsPrice}<br>
            </c:otherwise>
        </c:choose>
        ${goods.goodsStock}<br>
        <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="200" width="200"><br>
        <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName2}" height="200" width="200"><br>
        <br>
    </c:forEach>
</body>
</html>
