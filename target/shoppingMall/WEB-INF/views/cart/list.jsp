<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-13
  Time: 오후 5:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/cart_order.css">
    <script src="/resources/js/jquery.js"></script>
    <title>CHICK</title>
    <style>
        .no_cartList {
            text-align: center;
            font-size: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container">
<h2>장바구니</h2>
<div id="cart-list">
    <table class="table table-hover">
        <tr>
            <th>ALL<br>
                <input type="checkbox" id="checkAll" class="checkOne" onclick="selectAll()"></th>
            <th>ITEM</th>
            <th>QTY</th>
            <th>PRICE</th>
            <th></th>
        </tr>

        <c:forEach var="cart" items="${cartList}">
            <tr>
                <td><input type="checkbox" name="goodsId" class="checkOne" value="${cart.goodsDTO.id}">
                    <img src="${pageContext.request.contextPath}/upload/${cart.goodsDTO.goodsFileName1}" height="120" width="120"></td>
                <td>${cart.goodsDTO.goodsName}</td>
                <td class="cart-count">${cart.cartStock}
                    <c:if test="${cart.cartStock < cart.goodsDTO.goodsStock}">
                        <i onclick="cartCountPlus(${cart.goodsDTO.id})" class="bi bi-bag-plus"></i>
                    </c:if>
                    <c:if test="${cart.cartStock > 1}">
                        <i onclick="cartCountMinus(${cart.goodsDTO.id})" class="bi bi-bag-dash"></i></td>
                    </c:if>
                <c:choose>
                    <c:when test="${cart.goodsDTO.goodsDiscount ne 0}">
                        <td><p class="price">${cart.goodsDTO.goodsPrice * cart.cartStock}원</p>
                            <p class="discount"><fmt:formatNumber type="number" pattern="0" value="${(cart.goodsDTO.goodsPrice * (1-cart.goodsDTO.goodsDiscount)) * cart.cartStock}"/>원</p></td>
                    </c:when>
                    <c:otherwise>
                        <td>${cart.goodsDTO.goodsPrice * cart.cartStock}원</td>
                    </c:otherwise>
                </c:choose>
                <td>
                    <button class="btn btn-outline-dark btn-sm" onclick="cartDelete('${cart.goodsDTO.id}')">삭제</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
    <c:choose>
        <c:when test="${cartList.isEmpty()}">
            <div class="no_cartList">
                장바구니에 담은 상품이 없습니다.
            </div>
        </c:when>
        <c:otherwise>
            <div class="d-flex justify-content-end">
                <button class="btn btn-outline-primary" onclick="orderGo()">주문하기</button>
            </div>

        </c:otherwise>
    </c:choose>
</div>

</body>
<script>
    const cartCountPlus = (goodsId) => {
        const memberId = '${sessionScope.memberId}';
        const cartList = document.getElementById("cart-list");

        $.ajax({
            type: "get",
            url: "/cart/count-up",
            data: {"goodsId": goodsId, "memberId": memberId},
            dataType: "json",
            success: function(result) {
                let output = '<table class="table table-hover">';
                    output += '<tr><th>ALL<br><input type="checkbox" id="checkAll" class="checkOne" onclick="selectAll()"></th>';
                    output += '<th>ITEM</th>';
                    output += '<th>QTY</th>';
                    output += '<th>PRICE</th><th></th></tr>';

                for (let i in result) {
                    output += '<tr>' + '<td><input type="checkbox" name="goodsId" value="${cart.goodsDTO.id}">';
                    output += '<img src="' + '${pageContext.request.contextPath}' + '/upload/' + result[i].goodsDTO.goodsFileName1 + '" height="120" width="120">' + '</td>';
                    output += '<td>' + result[i].goodsDTO.goodsName + '</td>';
                    output += '<td class="cart-count">' + result[i].cartStock + '&nbsp;';
                    if (result[i].cartStock < result[i].goodsDTO.goodsStock) {
                        output += '<i onclick="cartCountPlus(' + result[i].goodsDTO.id + ')" class="bi bi-bag-plus"></i>&nbsp;';
                    }
                    if (result[i].cartStock > 1) {
                        output += '<i onclick="cartCountMinus(' + result[i].goodsDTO.id + ')" class="bi bi-bag-dash"></i></td>';
                    }
                    if (result[i].goodsDTO.goodsDiscount != 0) {
                        output += '<td>' + '<p class="price">' + (result[i].goodsDTO.goodsPrice * result[i].cartStock) + '원</p>';
                        output += '<p class="discount">' + Math.floor((result[i].goodsDTO.goodsPrice * (1- result[i].goodsDTO.goodsDiscount)) * result[i].cartStock) + '원</p></td>';
                    } else {
                        output += '<td>' + (result[i].goodsDTO.goodsPrice * result[i].cartStock) + '원</td>';
                    }
                    output += '<td>' + '<button class="btn btn-outline-dark btn-sm" onclick="cartDelete(' + result[i].goodsDTO.id + ')">삭제</button></td></tr>';
                }
                cartList.innerHTML = output;
            }
        });
    }

    const cartCountMinus  = (goodsId) => {
        const memberId = '${sessionScope.memberId}';
        const cartList = document.getElementById("cart-list");

        $.ajax({
            type: "get",
            url: "/cart/count-down",
            data: {"goodsId": goodsId, "memberId": memberId},
            dataType: "json",
            success: function(result) {
                let output = '<table class="table table-hover">';
                output += '<tr><th>ALL<br><input type="checkbox" id="checkAll" class="checkOne" onclick="selectAll()"></th>';
                output += '<th>ITEM</th>';
                output += '<th>QTY</th>';
                output += '<th>PRICE</th><th></th></tr>';

                for (let i in result) {
                    output += '<tr>' + '<td><input type="checkbox" name="goodsId" value="${cart.goodsDTO.id}">';
                    output += '<img src="' + '${pageContext.request.contextPath}' + '/upload/' + result[i].goodsDTO.goodsFileName1 + '" height="120" width="120">' + '</td>';                    output += '<td>' + result[i].goodsDTO.goodsName + '</td>';
                    output += '<td class="cart-count">' + result[i].cartStock + '&nbsp;';
                    if (result[i].cartStock < result[i].goodsDTO.goodsStock) {
                        output += '<i onclick="cartCountPlus(' + result[i].goodsDTO.id + ')" class="bi bi-bag-plus"></i>&nbsp;';
                    }
                    if (result[i].cartStock > 1) {
                        output += '<i onclick="cartCountMinus(' + result[i].goodsDTO.id + ')" class="bi bi-bag-dash"></i></td>';
                    }
                    if (result[i].goodsDTO.goodsDiscount != 0) {
                        output += '<td>' + '<p class="price">' + (result[i].goodsDTO.goodsPrice * result[i].cartStock) + '원</p>';
                        output += '<p class="discount">' + Math.floor((result[i].goodsDTO.goodsPrice * (1- result[i].goodsDTO.goodsDiscount)) * result[i].cartStock) + '원</p></td>';
                    } else {
                        output += '<td>' + (result[i].goodsDTO.goodsPrice * result[i].cartStock) + '원</td>';
                    }
                    output += '<td>' + '<button class="btn btn-outline-dark btn-sm" onclick="cartDelete(' + result[i].goodsDTO.id + ')">삭제</button></td></tr>';
                }
                cartList.innerHTML = output;
            }
        });
    }

    const cartDelete = (goodsId) => {
        if (confirm("상품을 삭제하시겠습니까?")) {
            location.href = "/cart/delete?goodsId=" + goodsId;
        }
    }

    const orderGo = () => {
        if (confirm("주문하시겠습니까?")) {
            let goodsIdArray = [];
            $('input[name="goodsId"]:checked').each(function(){
                goodsIdArray.push($(this).val());
            });
            console.log(goodsIdArray[0]);

            $.ajax({
                type: "get",
                url : "/order/save-form",
                data : {"goodsIdArray": goodsIdArray},
                dataType : "text",
                success: function () {
                    location.href="/order/save";
                }
            });
        }
    }

    const selectAll = () => {
        console.log("함수실행됨");

        if ($("#checkAll").prop("checked")) {
            $(".checkOne").prop("checked", "true");
        } else {
            $(".checkOne").prop("checked", "false");
        }

    }
</script>
</html>
