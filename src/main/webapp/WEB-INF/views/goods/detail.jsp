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
    <link rel="stylesheet" type="text/css" href="../../../resources/css/bootstrap.min.css">
    <title>CHICK</title>
    <style>
        a {
            text-decoration-line: none !important;
        }

        .item_title {
            font-size: 40px;
            font-weight: bold;
        }

        .item_detail {
            font-size: 30px;
        }

        .item_price0 {
            text-align: end;
            font-size: 28px;
        }

        .item_price1 {
            text-align: end;
            font-size: 25px;
            text-decoration-line: line-through;
        }

        .item_sale_price {
            text-align: end;
            color: orange;
            font-size: 28px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <div class="detail_header">
        <div class="contents0">
            <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName1}" height="700" width="700"><br>
            <img src="${pageContext.request.contextPath}/upload/${goods.goodsFileName2}" height="700" width="700">
        </div>
        <div class="contents1">
            <p class="item_title">${goods.goodsName}</p>
            <p class="item_detail">${goods.goodsDetail}</p>
                <c:choose>
                    <c:when test="${goods.goodsDiscount eq 0.0}">
                        <p class="item_price0">${goods.goodsPrice}원</p>
                    </c:when>
                    <c:otherwise>
                        <p class="item_price1">${goods.goodsPrice}원</p>
                        <p class="item_sale_price"><fmt:formatNumber type="number" pattern="0" value="${goods.goodsPrice * (1-goods.goodsDiscount)}"/>원</p>
                    </c:otherwise>
                </c:choose>

                <c:if test="${sessionScope.memberName eq '관리자'}">
                    <div class="d-md-flex justify-content-md-end">
                        <button class="btn btn-outline-primary" onclick="goodsUpdate()">상품수정</button>
                        <button class="btn btn-outline-dark" onclick="goodsDelete('${goods.goodsCategory}', '${goods.id}')">삭제</button>
                    </div>
                </c:if>
                <c:if test="${sessionScope.memberName ne '관리자'}">
                    <div class="d-md-flex justify-content-md-end">
                        <button class="btn btn-secondary" onclick="cartAdd()">장바구니추가</button>
                    </div>
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
            <button class="btn btn-warning d-grid mx-auto" onclick="reviewSave()">리뷰작성</button>
            <div id="reviewOne">
                <c:forEach var="review" items="${reviewList}">
                        회원아이디: ${review.memberId}<br>
                        내용: ${review.reviewContents} <br>
                        작성일: <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${review.reviewCreatedDate}"></fmt:formatDate><br>
                        추천수: ${review.reviewHits}
                        <i id="icon0_${review.id}" onclick="reviewHitsUp('${goods.id}', '${review.id}', '${sessionScope.memberId}')" class="bi bi-hand-thumbs-up"></i>
                        <i id="icon1_${review.id}" onclick="reviewHitsDown('${goods.id}', '${review.id}', '${sessionScope.memberId}')" class="bi bi-hand-thumbs-down"></i><br>
                        <c:if test="${sessionScope.memberId eq review.memberId}">
                            <button class="btn btn-outline-dark" onclick="reviewUpdate('${review.goodsId}', '${review.id}','${review.reviewContents}')">리뷰수정</button>
                            <button class="btn btn-outline-dark" onclick="reviewDelete('${review.goodsId}', '${review.id}')">리뷰삭제</button>
                        </c:if>
                    <br><br>
                </c:forEach>
            </div>
        </li>

        <li class="li_title">
            <span onclick="goodsQnA()">Q&A</span>
        </li>
    </ul>
    <p id="inner"></p>

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
                                + "<textarea class='form-control' type='text' name='reviewContents'>" + reviewContents + "</textarea><br>"
                                + "<input class='btn btn-outline-warning' type='submit' value='리뷰수정완료'></form>";
    }

    const reviewDelete = (goodsId, id) => {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "/review/delete?goodsId=" + goodsId + "&id=" + id;
        }
    }

    const reviewHitsUp = (goodsId, reviewId, memberId) => {
        const reviewOne = document.getElementById("reviewOne");
        const iconCondition = document.getElementById("icon0_" + reviewId);
        if (iconCondition.className == "bi bi-hand-thumbs-up") {
            iconCondition.className = "bi bi-hand-thumbs-up-fill";
        } else {
            iconCondition.className = "bi bi-hand-thumbs-up";
        }
        $.ajax({
            type: "get",
            url: "/review/hitsUp",
            data: {"goodsId": goodsId, "reviewId": reviewId, "memberId": memberId},
            dataType: "json",
            success: function (result) {
                let output = '';
                for (let i in result){
                    output += "회원아이디: " + result[i].memberId + "<br>";
                    output += "내용: " + result[i].reviewContents + "<br>";
                    output += "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>";
                    output += '추천수: ' + result[i].reviewHits +'&nbsp;';
                    output += '<i id="icon0_' + result[i].id + '"' + ' onclick="reviewHitsUp2(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-up"></i> ';
                    output += '<i id="icon1_' + result[i].id + '"' + ' onclick="reviewHitsDown2(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-down"></i><br>';
                    if ('${sessionScope.memberId}' == result[i].memberId) {
                        output += '<button class="btn btn-outline-dark" onclick="reviewUpdate(' + '${goods.id}' + ',' + result[i].id + ',' + "'" + result[i].reviewContents + "'" + ')">리뷰수정</button>';
                        output += '<button class="btn btn-outline-dark" onclick="reviewDelete(' + '${goods.id}' + ',' + result[i].id + ')">리뷰삭제</button><br>';
                    }
                    output += '<br>';
                }
                reviewOne.innerHTML = output;
                const iconCondition = document.getElementById("icon0_" + reviewId);
                if (iconCondition.className == "bi bi-hand-thumbs-up") {
                    iconCondition.className = "bi bi-hand-thumbs-up-fill";
                } else {
                    iconCondition.className = "bi bi-hand-thumbs-up";
                }
            }

        });
    }

    const reviewHitsDown = (goodsId, reviewId, memberId) => {
        const reviewOne = document.getElementById("reviewOne");
        const iconCondition2 = document.getElementById("icon1_" + reviewId);
        if (iconCondition2.className == "bi bi-hand-thumbs-down") {
            iconCondition2.className = "bi bi-hand-thumbs-down-fill";
        } else {
            iconCondition2.className = "bi bi-hand-thumbs-down";
        }

        $.ajax({
            type: "get",
            url: "/review/hitsDown",
            data: {"goodsId": goodsId, "reviewId": reviewId, "memberId": memberId},
            dataType: "json",
            success: function (result) {
                let output = '';
                for (let i in result){
                    output += "회원아이디: " + result[i].memberId + "<br>";
                    output += "내용: " + result[i].reviewContents + "<br>";
                    output += "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>";
                    output += '추천수: ' + result[i].reviewHits +'&nbsp;'
                    output += '<i id="icon0_' + result[i].id + '"' + ' onclick="reviewHitsUp2(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-up"></i> ';
                    output += '<i id="icon1_' + result[i].id + '"' + ' onclick="reviewHitsDown2(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-down"></i><br>';
                    if ('${sessionScope.memberId}' == result[i].memberId) {
                        output += '<button class="btn btn-outline-dark" onclick="reviewUpdate(' + '${goods.id}' + ',' + result[i].id + ',' + "'" + result[i].reviewContents + "'" + ')">리뷰수정</button>';
                        output += '<button class="btn btn-outline-dark" onclick="reviewDelete(' + '${goods.id}' + ',' + result[i].id + ')">리뷰삭제</button><br>';
                    }
                    output += '<br>';
                }
                reviewOne.innerHTML = output;
                const iconCondition2 = document.getElementById("icon1_" + reviewId);
                if (iconCondition2.className == "bi bi-hand-thumbs-down") {
                    iconCondition2.className = "bi bi-hand-thumbs-down-fill";
                } else {
                    iconCondition2.className = "bi bi-hand-thumbs-down";
                }
            }
        });

    }

    const reviewHitsUp2 = (goodsId, reviewId, memberId) => {
        const reviewOne = document.getElementById("reviewOne");
        const iconCondition = document.getElementById("icon0_" + reviewId);
        if (iconCondition.className == "bi bi-hand-thumbs-up") {
            iconCondition.className = "bi bi-hand-thumbs-up-fill";
        } else {
            iconCondition.className = "bi bi-hand-thumbs-up";
        }

        $.ajax({
            type: "get",
            url: "/review/hitsUp",
            data: {"goodsId": goodsId, "reviewId": reviewId, "memberId": memberId},
            dataType: "json",
            success: function (result) {
                let output = '';
                for (let i in result){
                    output += "회원아이디: " + result[i].memberId + "<br>";
                    output += "내용: " + result[i].reviewContents + "<br>";
                    output += "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>";
                    output += '추천수: ' + result[i].reviewHits +'&nbsp;'
                    output += '<i id="icon0_' + result[i].id + '"' + ' onclick="reviewHitsUp(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-up"></i> ';
                    output += '<i id="icon1_' + result[i].id + '"' + ' onclick="reviewHitsDown(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-down"></i><br>';
                    if ('${sessionScope.memberId}' == result[i].memberId) {
                        output += '<button class="btn btn-outline-dark" onclick="reviewUpdate(' + '${goods.id}' + ',' + result[i].id + ',' + "'" + result[i].reviewContents + "'" + ')">리뷰수정</button>';
                        output += '<button class="btn btn-outline-dark" onclick="reviewDelete(' + '${goods.id}' + ',' + result[i].id + ')">리뷰삭제</button><br>';
                    }
                    output += '<br>';
                }
                reviewOne.innerHTML = output;
                const iconCondition = document.getElementById("icon0_" + reviewId);
                if (iconCondition.className == "bi bi-hand-thumbs-up") {
                    iconCondition.className = "bi bi-hand-thumbs-up-fill";
                } else {
                    iconCondition.className = "bi bi-hand-thumbs-up";
                }
            }
        });
    }

    const reviewHitsDown2 = (goodsId, reviewId, memberId) => {
        const reviewOne = document.getElementById("reviewOne");
        const iconCondition2 = document.getElementById("icon1_" + reviewId);
        if (iconCondition2.className == "bi bi-hand-thumbs-down") {
            iconCondition2.className = "bi bi-hand-thumbs-down-fill";
        } else {
            iconCondition2.className = "bi bi-hand-thumbs-down";
        }

        $.ajax({
            type: "get",
            url: "/review/hitsDown",
            data: {"goodsId": goodsId, "reviewId": reviewId, "memberId": memberId},
            dataType: "json",
            success: function (result) {
                let output = '';
                for (let i in result){
                    output += "회원아이디: " + result[i].memberId + "<br>";
                    output += "내용: " + result[i].reviewContents + "<br>";
                    output += "작성일: " + moment(result[i].reviewCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "<br>";
                    output += '추천수: ' + result[i].reviewHits + '&nbsp;'
                    output += '<i id="icon0_' + result[i].id + '"' + ' onclick="reviewHitsUp(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-up"></i> ';
                    output += '<i id="icon1_' + result[i].id + '"' + ' onclick="reviewHitsDown(' + goodsId + ',' + result[i].id + ',' + "'${sessionScope.memberId}'" + ')" class="bi bi-hand-thumbs-down"></i><br>';
                    if ('${sessionScope.memberId}' == result[i].memberId) {
                        output += '<button class="btn btn-outline-dark" onclick="reviewUpdate(' + '${goods.id}' + ',' + result[i].id + ',' + "'" + result[i].reviewContents + "'" + ')">리뷰수정</button>';
                        output += '<button class="btn btn-outline-dark" onclick="reviewDelete(' + '${goods.id}' + ',' + result[i].id + ')">리뷰삭제</button><br>';
                    }
                    output += '<br>';
                }
                reviewOne.innerHTML = output;
                const iconCondition2 = document.getElementById("icon1_" + reviewId);
                if (iconCondition2.className == "bi bi-hand-thumbs-down") {
                    iconCondition2.className = "bi bi-hand-thumbs-down-fill";
                } else {
                    iconCondition2.className = "bi bi-hand-thumbs-down";
                }
            }
        });
    }

    const cartAdd = () => {
        alert("장바구니에 추가되었습니다.");
        location.href = "/cart/save?goodsId=${goods.id}";
    }

</script>
</html>
