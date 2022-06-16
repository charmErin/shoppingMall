<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 7:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../../../resources/css/list.css">
    <title>CHICK</title>
    <style>
        p {
            color: orange;
            font-weight: bold;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <c:choose>
        <c:when test="${category eq 1}">
            <h1>TOP</h1>
        </c:when>
        <c:when test="${category eq 2}">
            <h1>BOTTOM</h1>
        </c:when>
        <c:when test="${category eq 3}">
            <h1>SHOES</h1>
        </c:when>
        <c:otherwise>
            <h1>ACC</h1>
        </c:otherwise>
    </c:choose>

    <div class="page0">
        <div class="itemList">
            <c:forEach var="goods" items="${goodsList}">
            <span class="spanList">
                <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="350" width="350"
                     onclick="topDetail('${goods.id}')"><br>
                    ${goods.goodsName}<br>
                    ${goods.goodsDetail}<br>
                <c:choose>
                    <c:when test="${goods.goodsDiscount ne 0.0}">
                        <p><fmt:formatNumber type="number" pattern="0" value="${goods.goodsPrice * (1-goods.goodsDiscount)}"/>원</p>
                    </c:when>
                    <c:otherwise>
                        ${goods.goodsPrice}원<br>
                    </c:otherwise>
                </c:choose>
            </span>
            </c:forEach>
        </div>
</div>
</body>
<script>
    const topDetail = (id) => {
        location.href = "/goods/detail?id=" + id;
    }
</script>
</html>
