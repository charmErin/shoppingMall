<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오전 11:09
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

        .no_searchList {
            text-align: center;
            font-size: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <h1>검색목록</h1>
<c:choose>
    <c:when test="${goodsList.isEmpty()}">
        <div class="no_searchList">검색 결과가 없습니다.</div>
    </c:when>
    <c:otherwise>
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
    </c:otherwise>
</c:choose>

</body>
</html>
