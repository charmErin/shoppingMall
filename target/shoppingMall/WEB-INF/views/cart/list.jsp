<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-13
  Time: 오후 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>CHICK</title>
</head>
<body>
    <h2>장바구니</h2>
    <c:forEach var="cart" items="${cartList}">
        상품이름: ${cart.goodsDTO.goodsName}<br>
        장바구니 담은 개수: ${cart.cartStock}<br>
        <c:choose>
            <c:when test="${cart.goodsDTO.goodsDiscount ne 0}">
                할인 후 가격: ${cart.goodsDTO.goodsPrice} * (1-${cart.goodsDTO.goodsDiscount})원<br>
            </c:when>
            <c:otherwise>
                가격 : ${cart.goodsDTO.goodsPrice}원<br>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</body>
</html>
