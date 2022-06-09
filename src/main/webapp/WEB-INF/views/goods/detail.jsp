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
                회원아이디: ${review.memberId}<br>
                내용: ${review.reviewContents}<br>
                작성일: <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${review.reviewCreatedDate}"></fmt:formatDate><br>
                추천수: ${review.reviewHits} <button id="hits" aria-pressed="false" onclick="reviewHitsUp('${review.id}','${review.memberId}')">추천하기▲</button><br>
                <c:if test="${sessionScope.memberId eq review.memberId}">
                    <button onclick="reviewUpdate('${review.goodsId}', '${review.id}','${review.reviewContents}')">리뷰수정</button>
                    <button onclick="reviewDelete('${review.goodsId}', '${review.id}')">리뷰삭제</button>
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

    const reviewDelete = (goodsId, id) => {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "/review/delete?goodsId=" + goodsId + "&id=" + id;
        }
    }

    const reviewHitsUp = (reviewId, memberId) => {
        const reviewOne = document.getElementById("reviewOne");
        const hitsCondition = document.getElementById("hits");
        const id = '${sessionScope.memberId}';
        if (hitsCondition.ariaPressed === "false") {
            console.log("if문 false 실행 OK");
            hitsCondition.ariaPressed = "true";

            $.ajax({
                type: "get",
                url: "/review/hitsUp",
                data: {"reviewId": reviewId, "memberId": memberId},
                dataType: "json",
                success: function (result) {
                    for (let i in result){
                        reviewOne.innerHTML = "회원아이디: " + result[i].memberId + "<br>"
                                            + "내용: " + result[i].reviewContents + "<br>"
                                            + "작성일: " + result[i].reviewCreatedDate + "<br>"
                                            + '추천수: ' + result[i].reviewHits + '<button id="hits" aria-pressed="true" onclick="reviewHitsUp(' + result[i].id + "," + result[i].memberId + ")'>추천하기▲</button><br>"
                                            + 'if (${sessionScope.memberId == result[i].memberId}) {'
                                            + '<button onclick="reviewUpdate(' + ${goods.id} + ',' + result[i].id + ',' + result[i].reviewContents + ')">리뷰수정</button><br>'
                                            + '<button onclick="reviewDelete(' + ${goods.id} + ',' + result[i].id + ')">리뷰삭제</button>}';
                    }
                }
            });
        } else {
            console.log("if문 true 실행 OK");
            hitsCondition.ariaPressed = "false";

            $.ajax({
                type: "get",
                url: "/review/hitsDown",
                data: {"id": id, "reviewId": reviewId, "memberId": memberId},
                dataType: "json",
                success: function (result) {
                    for (let i in result){
                        reviewOne.innerHTML = "회원아이디: " + result[i].memberId + "<br>"
                            + "내용: " + result[i].reviewContents + "<br>"
                            + "작성일: " + result[i].reviewCreatedDate + "<br>"
                            + '추천수: ' + result[i].reviewHits + '<button id="hits" aria-pressed="true" onclick="reviewHitsUp(' + result[i].id + "," + result[i].memberId + ")'>추천하기▲</button><br>"
                            + 'if (${sessionScope.memberId == result[i].memberId}) {'
                            + '<button onclick="reviewUpdate(' + ${goods.id} + ',' + result[i].id + ',' + result[i].reviewContents + ')">리뷰수정</button><br>'
                            + '<button onclick="reviewDelete(' + ${goods.id} + ',' + result[i].id + ')">리뷰삭제</button>}';
                    }
                }
            });
        }
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
