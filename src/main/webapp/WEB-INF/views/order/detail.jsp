<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-17
  Time: 오전 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/cart_order.css">
    <title>CHICK</title>
    <style>
        th {
            font-size: 20px;
        }

        h4 {
            margin: 50px 0;
            text-align: center;
        }

        hr {
            margin-top: 50px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container col-4">
    <h2>주문 상세 정보</h2>
        <table class="table">
            <tr>
                <th>주문자</th>
                <td>${sessionScope.memberName}</td>
            </tr>
            <tr>
                <th>받으시는분</th>
                <td>${order.orderName}</td>
            </tr>
            <tr>
                <th>휴대전화</th>
                <td>${order.orderMobile}</td>
            </tr>
            <tr>
                <th>주소</th>
                <td>${order.orderZipCode}<br>
                    ${order.orderAddress}<br>
                    ${order.orderAddDetail}</td>
            </tr>
            <tr>
                <th>배송메시지</th>
                <td>${order.deliveryMsg}</td>
            </tr>
            <tr>
                <th>주문금액<br>(+배송비 3000원)</th>
                <td>${order.orderSum}</td>
            </tr>
            <tr>
                <th>주문상태</th>
                <td>${order.orderState}</td>
            </tr>
        </table>

        <h4>주문상품정보</h4>
        <table class="table">
            <tr>
                <th></th>
                <th>ITEM</th>
                <th>QTY</th>
                <th>PRICE</th>
            </tr>
            <tr>
                <td><img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="120" width="120"></td>
                <td>${goods.goodsName}</td>
                <td>${cart.cartCount}</td>
                <c:choose>
                    <c:when test="${goods.goodsDiscount ne 0}">
                        <td><p class="price">${goods.goodsPrice * cart.cartCount}원</p>
                            <p class="discount"><fmt:formatNumber type="number" pattern="0" value="${(goods.goodsPrice * (1-goods.goodsDiscount)) * cart.cartStock}"/>원</p></td>
                    </c:when>
                    <c:otherwise>
                        <td>${goods.goodsPrice * cart.cartCount}원</td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </table>
        <button class="btn btn-outline-secondary d-grid mx-auto" onclick="goBack()">주문목록</button>
</div>
</body>
<script>
    const goBack = () => {
        location.href = "/order/findAll";
    }
</script>
</html>
