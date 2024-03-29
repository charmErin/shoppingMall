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
    <link rel="stylesheet" type="text/css" href="/resources/css/cart_order.css">
    <title>CHICK</title>
    <style>
        th {
            font-size: 20px;
        }

        td:hover {
            cursor: pointer;
        }

        a {
            text-decoration-line: none !important;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container">
    <h2>주문목록</h2>
    <table class="table table-hover">
        <tr>
            <th>NUM</th>
            <th>RECEIVER</th>
            <th>DATE</th>
            <th>QTY</th>
            <th>PRICE</th>
            <th>STATE</th>
        </tr>

        <c:forEach var="order" items="${orderList}">
            <tr onclick="orderListDetail('${order.orderId}','${order.goodsId}')">
                <td>${order.orderId}</td>
                <td>${order.orderPageDTO.orderName}</td>
                <td>${order.orderPageDTO.orderDate}</td>
                <td>${order.cartCount}</td>
                <td>${order.orderPrice}</td>
                <td>${order.orderPageDTO.orderState}</td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    const orderListDetail = (id, goodsId) => {
        location.href = "/order/detail?id=" + id + "&goodsId=" + goodsId;
    }
</script>
</html>
