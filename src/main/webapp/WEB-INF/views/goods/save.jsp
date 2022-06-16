<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <title>CHICK</title>
    <style>
        h2 {
            text-align: center;
            margin-bottom: 50px;
        }

        input {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container col-4">
    <h2>상품등록</h2>
    <form action="/goods/save" method="post" enctype="multipart/form-data" name="goodsSaveForm">
        카테고리
        <select class="form-select" name="goodsCategory" size="4">
            <option value="1">TOP</option>
            <option value="2">BOTTOM</option>
            <option value="3">SHOES</option>
            <option value="4">ACC</option>
        </select><br>
        상품이름
        <input class="form-control" type="text" name="goodsName">
        상품설명
        <textarea class="form-control" name="goodsDetail" placeholder="설명"></textarea><br>
        상품가격
        <input class="form-control" type="text" name="goodsPrice">
        상품재고
        <input class="form-control" type="text" name="goodsStock">
        상품사진1
        <input class="form-control" type="file" name="goodsFile1">
        상품사진2
        <input class="form-control" type="file" name="goodsFile2">
        <input class="btn btn-primary d-grid mx-auto" type="button" onclick="goods_save()" value="등록">
    </form>
</div>
</body>
<script>
    const goods_save = () => {
        if (confirm("등록하시겠습니까?")) {
            goodsSaveForm.submit();
        }
    }
</script>
</html>
