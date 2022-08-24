<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오전 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <div class="container col-4">
    <h2>상품등록</h2>
    <form action="/goods/update" method="post" enctype="multipart/form-data" name="goodsUpdateForm">
        <input class="form-control" type="hidden" name="id" value="${goods.id}">
        카테고리:
        <select class="form-select" name="goodsCategory" size="4">
            <c:choose>
                <c:when test="${goods.goodsCategory eq 1}">
                    <option value="1" selected>TOP</option>
                    <option value="2">BOTTOM</option>
                    <option value="3">SHOES</option>
                    <option value="4">ACC</option>
                </c:when>
                <c:when test="${goods.goodsCategory eq 2}">
                    <option value="1">TOP</option>
                    <option value="2" selected>BOTTOM</option>
                    <option value="3">SHOES</option>
                    <option value="4">ACC</option>
                </c:when>
                <c:when test="${goods.goodsCategory eq 3}">
                    <option value="1">TOP</option>
                    <option value="2">BOTTOM</option>
                    <option value="3" selected>SHOES</option>
                    <option value="4">ACC</option>
                </c:when>
                <c:otherwise>
                    <option value="1">TOP</option>
                    <option value="2">BOTTOM</option>
                    <option value="3">SHOES</option>
                    <option value="4" selected>ACC</option>
                </c:otherwise>
            </c:choose>
        </select><br>
        상품이름: <br>
        <input class="form-control" type="text" name="goodsName" value="${goods.goodsName}"><br>
        상품설명: <br>
        <textarea class="form-control" name="goodsDetail" cols="30" rows="10" placeholder="설명">${goods.goodsDetail}</textarea><br>
        상품가격: <br>
        <input class="form-control" type="text" name="goodsPrice" value="${goods.goodsPrice}"><br>
        상품할인율:('0.0') <br>
        <input class="form-control" type="text" name="goodsDiscount" value="${goods.goodsDiscount}"><br>
        상품재고: <br>
        <input class="form-control" type="text" name="goodsStock" value="${goods.goodsStock}"><br>
        현재상품사진1: <br>
        <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="200" width="200"><br>
        <input type="hidden" name="goodsFileName1" value="${goods.goodsFileName1}">
        변경할 상품사진1: <input class="form-control" type="file" name="goodsFile1"><br>
        현재상품사진2: <br>
        <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName2}" height="200" width="200"><br>
        <input type="hidden" name="goodsFileName2" value="${goods.goodsFileName2}">
        변경할 상품사진2: <input class="form-control" type="file" name="goodsFile2"><br>
        <input class="btn btn-outline-info d-grid mx-auto" type="button" onclick="goods_update()" value="수정">
        <br>
    </form>
    </div>
</body>
<script>
    const goods_update = () => {
        goodsUpdateForm.submit();
    }
</script>
</html>
