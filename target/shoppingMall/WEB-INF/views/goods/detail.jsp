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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
    <link rel="stylesheet" type="text/css" href="../../../resources/css/detail.css">
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <div class="detail_header">
        <div class="contents0">
            <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="700" width="700"><br>
            <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName2}" height="700" width="700">
        </div>
        <div class="contents1">
            ${goods.goodsName}<br>
                <c:choose>
                    <c:when test="${goods.goodsDiscount ne 0.0}">
                        ${goods.goodsPrice * (1-goods.goodsDiscount)}원
                    </c:when>
                    <c:otherwise>
                        ${goods.goodsPrice}원
                    </c:otherwise>
                </c:choose>
                ${goods.goodsDetail}
                <c:if test="${sessionScope.memberName eq '관리자'}">
                    <button onclick="goodsUpdate()">수정</button>
                    <button onclick="goodsDelete('${goods.goodsCategory}', '${goods.id}')">삭제</button>
                </c:if>
        </div>
    </div>

    <ul class="contents2">
        <li class="li_title">
            <span onclick="goodsDetail()">상품설명</span><br>
            ${goods.goodsDetail}
        </li>

        <li class="li_title">
            <span onclick="goodsReview()">상품리뷰</span><br>
            <c:forEach var="review" items="${reviewList}">
                <div id="reviewOne">
                    회원아이디: ${review.memberId}<br>
                    내용: ${review.reviewContents}<br>
                    작성일: <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${review.reviewCreatedDate}"></fmt:formatDate><br>
                    추천수: ${review.reviewHits}
                    <c:choose>
                        <c:when test="${reviewHits.reviewHits ne 1}">
                            <i id="icon0" onclick="reviewHitsUpAndDown('${review.id}', '${reviewHits.id}' ,'${review.memberId}')" class="bi bi-hand-thumbs-up"></i><br>
                        </c:when>
                        <c:otherwise>
                            <i id="icon0" onclick="reviewHitsUpAndDown('${review.id}', '${reviewHits.id}','${review.memberId}')" class="bi bi-hand-thumbs-up-fill"></i><br>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${sessionScope.memberId eq review.memberId}">
                        <button onclick="reviewUpdate('${review.goodsId}', '${review.id}','${review.reviewContents}')">리뷰수정</button>
                        <button onclick="reviewDelete('${review.goodsId}', '${review.id}')">리뷰삭제</button>
                    </c:if>
                </div>
            </c:forEach>
        </li>

        <li class="li_title">
            <span onclick="goodsQnA()">Q&A</span>
        </li>
    </ul>
    <p id="inner"></p>
    <h1 onclick="reviewSave()">리뷰작성</h1>

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

    const reviewHitsUpAndDown = (reviewId, id, memberId) => {
        const reviewOne = document.getElementById("reviewOne");
        const iconCondition = document.getElementById("icon0");

        if (iconCondition.className == "bi bi-hand-thumbs-up") {
            console.log("색채우기");
            iconCondition.className = "bi bi-hand-thumbs-up-fill";
            $.ajax({
                type: "get",
                url: "/review/hitsUp",
                data: {"id":id, "reviewId": reviewId, "memberId": memberId},
                dataType: "json",
                success: function (result) {
                    for (let i in result){
                        reviewOne.innerHTML = "회원아이디: " + result[i].memberId + "<br>"
                            + "내용: " + result[i].reviewContents + "<br>"
                            + "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>"
                            + '추천수: ' + result[i].reviewHits + '<button id="hits" aria-pressed="true" onclick="reviewHitsUp(' + result[i].id + "," + result[i].memberId + ")'>추천하기▲</button><br>"
                            + 'if(${reviewHits.reviewHits != 1}){'
                            + '<button id="hits" aria-pressed="false" onclick="reviewHitsUp(' + result[i].id + ',' + '${reviewHits.id}' +',' + result[i].memberId + ')">추천하기▲</button><br>}'
                            + 'else {'
                            + '<button id="hits" aria-pressed="true" onclick="reviewHitsDown(' + result[i].id +',' + '${reviewHits.id}' + ',' + result[i].memberId + ')">추천하기▽</button><br>'
                            + 'if (${sessionScope.memberId == result[i].memberId}) {'
                            + '<button onclick="reviewUpdate(' + ${goods.id} + ',' + result[i].id + ',' + result[i].reviewContents + ')">리뷰수정</button><br>'
                            + '<button onclick="reviewDelete(' + ${goods.id} + ',' + result[i].id + ')">리뷰삭제</button>}';
                    }
                }
            });
        } else {
            console.log("색비우기");
            iconCondition.className = "bi bi-hand-thumbs-up";
            $.ajax({
                type: "get",
                url: "/review/hitsDown",
                data: {"reviewId": reviewId, "id": id, "memberId": memberId},
                dataType: "json",
                success: function (result) {
                    for (let i in result){
                        reviewOne.innerHTML = "회원아이디: " + result[i].memberId + "<br>"
                            + "내용: " + result[i].reviewContents + "<br>"
                            + "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>"
                            + '추천수: ' + result[i].reviewHits + '<button id="hits" aria-pressed="true" onclick="reviewHitsUp(' + result[i].id + "," + result[i].memberId + ")'>추천하기▲</button><br>"
                            + 'if(${reviewHits.reviewHits != 1}){'
                            + '<button id="hits" aria-pressed="false" onclick="reviewHitsUp(' + result[i].id + ',' + '${reviewHits.id}' +',' + result[i].memberId + ')">추천하기▲</button><br>}'
                            + 'else {'
                            + '<button id="hits" aria-pressed="true" onclick="reviewHitsDown(' + result[i].id +',' + '${reviewHits.id}' + ',' + result[i].memberId + ')">추천하기▽</button><br>'
                            + 'if (${sessionScope.memberId == result[i].memberId}) {'
                            + '<button onclick="reviewUpdate(' + ${goods.id} + ',' + result[i].id + ',' + result[i].reviewContents + ')">리뷰수정</button><br>'
                            + '<button onclick="reviewDelete(' + ${goods.id} + ',' + result[i].id + ')">리뷰삭제</button>}';
                    }
                }
            });

        }
    }


    <%--const reviewHitsUp = (reviewId, id, memberId) => {--%>
    <%--    --%>
    <%--    const reviewOne = document.getElementById("reviewOne");--%>
    <%--   --%>

    <%--    $.ajax({--%>
    <%--        type: "get",--%>
    <%--        url: "/review/hitsUp",--%>
    <%--        data: {"id":id, "reviewId": reviewId, "memberId": memberId},--%>
    <%--        dataType: "json",--%>
    <%--        success: function (result) {--%>
    <%--            for (let i in result){--%>
    <%--                reviewOne.innerHTML = "회원아이디: " + result[i].memberId + "<br>"--%>
    <%--                                    + "내용: " + result[i].reviewContents + "<br>"--%>
    <%--                                    + "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>"--%>
    <%--                                    + '추천수: ' + result[i].reviewHits + '<button id="hits" aria-pressed="true" onclick="reviewHitsUp(' + result[i].id + "," + result[i].memberId + ")'>추천하기▲</button><br>"--%>
    <%--                                    + 'if(${reviewHits.reviewHits != 1}){'--%>
    <%--                                    + '<button id="hits" aria-pressed="false" onclick="reviewHitsUp(' + result[i].id + ',' + '${reviewHits.id}' +',' + result[i].memberId + ')">추천하기▲</button><br>}'--%>
    <%--                                    + 'else {'--%>
    <%--                                    + '<button id="hits" aria-pressed="true" onclick="reviewHitsDown(' + result[i].id +',' + '${reviewHits.id}' + ',' + result[i].memberId + ')">추천하기▽</button><br>'--%>
    <%--                                    + 'if (${sessionScope.memberId == result[i].memberId}) {'--%>
    <%--                                    + '<button onclick="reviewUpdate(' + ${goods.id} + ',' + result[i].id + ',' + result[i].reviewContents + ')">리뷰수정</button><br>'--%>
    <%--                                    + '<button onclick="reviewDelete(' + ${goods.id} + ',' + result[i].id + ')">리뷰삭제</button>}';--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>
    <%--}--%>

    <%--const reviewHitsDown = (reviewId, id, memberId) => {--%>
    <%--    console.log("reviewHitsDown 실행 OK");--%>
    <%--    const reviewOne = document.getElementById("reviewOne");--%>
    <%--    const iconCondition = document.getElementById("icon1");--%>
    <%--    iconCondition.className = "bi bi-hand-thumbs-up";--%>

    <%--    $.ajax({--%>
    <%--        type: "get",--%>
    <%--        url: "/review/hitsDown",--%>
    <%--        data: {"reviewId": reviewId, "id": id, "memberId": memberId},--%>
    <%--        dataType: "json",--%>
    <%--        success: function (result) {--%>
    <%--            for (let i in result){--%>
    <%--                reviewOne.innerHTML = "회원아이디: " + result[i].memberId + "<br>"--%>
    <%--                                    + "내용: " + result[i].reviewContents + "<br>"--%>
    <%--                                    + "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>"--%>
    <%--                                    + '추천수: ' + result[i].reviewHits + '<button id="hits" aria-pressed="true" onclick="reviewHitsUp(' + result[i].id + "," + result[i].memberId + ")'>추천하기▲</button><br>"--%>
    <%--                                    + 'if(${reviewHits.reviewHits != 1}){'--%>
    <%--                                    + '<button id="hits" aria-pressed="false" onclick="reviewHitsUp(' + result[i].id + ',' + '${reviewHits.id}' +',' + result[i].memberId + ')">추천하기▲</button><br>}'--%>
    <%--                                    + 'else {'--%>
    <%--                                    + '<button id="hits" aria-pressed="true" onclick="reviewHitsDown(' + result[i].id +',' + '${reviewHits.id}' + ',' + result[i].memberId + ')">추천하기▽</button><br>'--%>
    <%--                                    + 'if (${sessionScope.memberId == result[i].memberId}) {'--%>
    <%--                                    + '<button onclick="reviewUpdate(' + ${goods.id} + ',' + result[i].id + ',' + result[i].reviewContents + ')">리뷰수정</button><br>'--%>
    <%--                                    + '<button onclick="reviewDelete(' + ${goods.id} + ',' + result[i].id + ')">리뷰삭제</button>}';--%>
    <%--            }--%>
    <%--        }--%>
    <%--    });--%>
    <%--}--%>

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
