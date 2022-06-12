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
    <link rel="stylesheet" type="text/css" href="../../../resources/css/list.css">
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <h1>SHOES</h1>
    <div class="page0">
        <div class="itemList">
            <c:forEach var="goods" items="${goodsList}">
            <span class="spanList">
                <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="350" width="350"
                     onclick="shoesDetail('${goods.id}')"><br>
                    ${goods.goodsName}<br>
                    ${goods.goodsDetail}<br>
                <c:choose>
                    <c:when test="${goods.goodsDiscount ne 0.0}">
                        ${goods.goodsPrice * (1-goods.goodsDiscount)}원<br>
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
    const shoesDetail = (id) => {
        location.href = "/goods/detail?id=" + id;
    }
</script>
</html>
