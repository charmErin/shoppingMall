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
    <title>Title</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <h2>상품등록</h2>
    <form action="/goods/save" method="post" enctype="multipart/form-data" name="goodsSaveForm">
        카테고리:
        <select name="goodsCategory" size="4">
            <option value="1">TOP</option>
            <option value="2">BOTTOM</option>
            <option value="3">SHOES</option>
            <option value="4">ACC</option>
        </select><br>
        상품이름: <br>
        <input type="text" name="goodsName"><br>
        상품설명: <br>
        <textarea name="goodsDetail" cols="30" rows="10" placeholder="설명"></textarea><br>
        상품가격: <br>
        <input type="text" name="goodsPrice"><br>
        상품재고: <br>
        <input type="text" name="goodsStock"><br>
        상품사진1: <br>
        <input type="file" name="goodsFile1"><br>
        상품사진2: <br>
        <input type="file" name="goodsFile2"><br>
        <input type="button" onclick="goods_save()" value="등록">
    </form>
</body>
<script>
    const goods_save = () => {
        if (confirm("등록하시겠습니까?")) {
            goodsSaveForm.submit();
        }
    }
</script>
</html>
