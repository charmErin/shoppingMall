<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오후 1:26
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

        a {
            text-decoration-line: none !important;
        }

        input {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container col-3">
    <h2>리뷰작성</h2>
    <form action="/review/save" method="post">
        <input class="form-control" type="hidden" name="goodsId" value="${goodsId}">
        <input class="form-control" type="hidden" name="memberId" value="${sessionScope.memberId}">
        <div class="input-group">
            <input class="form-control" type="text" name="reviewContents" placeholder="내용">
            <input class="btn btn-warning" type="submit" value="리뷰작성">
        </div>
    </form>
</div>
</body>
</html>
