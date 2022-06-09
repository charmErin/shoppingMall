<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-09
  Time: 오전 9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <script src="/resources/js/jquery.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
    <div>
        <span onclick="goodsDetail()">상품설명</span><br>
        ${goods.goodsDetail}
    </div>
    <div style="border-color: black">
        <span onclick="goodsReview()">상품리뷰</span><br>
        <c:forEach var="review" items="${reviewList}">
            <div id="reviewOne">
                ${review.memberId}<br>
                ${review.reviewContents}<br>
                <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${review.reviewCreatedDate}"></fmt:formatDate><br>
                ${review.reviewHits}<br>
                <c:if test="${sessionScope.memberId eq review.memberId}">
                    <button onclick="reviewUpdate('${review.goodsId}', '${review.id}','${review.reviewContents}')">리뷰수정</button>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <h1 onclick="reviewSave()">리뷰작성</h1>
    <div>
        <span onclick="goodsQnA()">Q&A</span>
    </div>
    <p id="inner">
    </p>
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

    const reviewSave = () => {
        location.href = "/review/save-form?id=${goods.id}";
    }

    const reviewUpdate = (goodsId ,id, reviewContents) => {
        const reviewOne = document.getElementById("reviewOne");

        reviewOne.innerHTML = "<form action='/review/update' method='post'>"
                                + "<input type='hidden' name=goodsId value='" + goodsId + "'><br>"
                                + "<input type='hidden' name=id value='" + id + "'><br>"
                                + "<input type='text' name='reviewContents' value='" + reviewContents + "'><br>"
                                + "<input type='submit' value='리뷰수정완료'></form>";

    }

   <%-- const goodsDetail = () => {--%>
   <%--     const inner = document.getElementById("inner");--%>
   <%--     inner.innerHTML = "${goods.goodsDetail}";--%>
   <%-- }--%>

   <%-- const goodsReview = () => {--%>
   <%--     const id = '${goods.id}';--%>
   <%--     const inner = document.getElementById("inner");--%>
   <%--     $.ajax({--%>
   <%--         type: "post",--%>
   <%--         url: "/review/save-form?id=" + id,--%>
   <%--         data: {"id": id},--%>
   <%--         dataType: "json",--%>
   <%--         success: function (result){--%>
   <%--             let output = '';--%>
   <%--         }--%>
   <%--     });--%>
   <%-- }--%>

   <%--const goodsQnA = () => {--%>

   <%--}--%>
</script>
</html>
