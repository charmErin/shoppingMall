<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오전 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <table>
        <tr>
            <td><img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="200" width="200"></td>
            <td><img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName2}" height="200" width="200"></td>
            <td>${goods.goodsName}<br>
                <c:choose>
                    <c:when test="${goods.goodsDiscount ne 0.0}">
                        ${goods.goodsPrice * (1-goods.goodsDiscount)}원</td>
                    </c:when>
                    <c:otherwise>
                        ${goods.goodsPrice}원</td>
                    </c:otherwise>
                </c:choose>
        </tr>
        <tr>
            <td></td>
            <td>${goods.goodsDetail}</td>
        </tr>
        <c:if test="${sessionScope.memberName eq '관리자'}">
            <tr>
                <td></td>
                <td><button onclick="goodsUpdate()">수정</button>
                    <button onclick="goodsDelete('${goods.goodsCategory}', '${goods.id}')">삭제</button></td>
            </tr>
        </c:if>
    </table>
</body>
<script>
    const goodsUpdate = () => {
        location.href = "/goods/update-form?id=${goods.id}";
    }

    const goodsDelete = (category, id) => {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "/goods/delete?category=" + category + "&id=" + id;
        }
    }
</script>
</html>
