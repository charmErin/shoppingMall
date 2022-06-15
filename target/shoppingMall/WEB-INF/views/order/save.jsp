<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-14
  Time: 오후 3:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/cart_order.css">
    <title>CHICK</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>

<div class="container col-4">
    <h2>주문 페이지</h2>
    <form action="/order/save" method="post" name="orderForm">
        <h4>주문정보</h4>
        주문날짜 : Date()
        주문상품<br>
        <table class="table">
            <tr>
                <th></th>
                <th>ITEM</th>
                <th>QTY</th>
                <th>PRICE</th>
            </tr>

            <c:forEach var="cart" items="${cartList}">
                <tr>
                    <input type="hidden" name="goodsIdList" value="${cart.goodsId}">
                    <td><img src="${pageContext.request.contextPath}/upload/${cart.goodsDTO.goodsFileName1}" height="120" width="120"></td>
                    <td class="goodsId">${cart.goodsDTO.goodsName}</td>
                    <td class="cart-count">${cart.cartStock}
                    <c:choose>
                        <c:when test="${cart.goodsDTO.goodsDiscount ne 0}">
                            <td><p class="price">${cart.goodsDTO.goodsPrice * cart.cartStock}원</p>
                                <p class="discount"><fmt:formatNumber type="number" pattern="0" value="${(cart.goodsDTO.goodsPrice * (1-cart.goodsDTO.goodsDiscount)) * cart.cartStock}"/>원</p></td>
                        </c:when>
                        <c:otherwise>
                            <td>${cart.goodsDTO.goodsPrice * cart.cartStock}원</td>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>
        </table> <br>
        주문자
        <input class="form-control" type="text" name="memberId" value="${sessionScope.memberName}" readonly>
        <h4>배송정보</h4>
        받으시는 분
        <input class="form-control" type="text" name="orderName">
        휴대전화('-' 포함)
        <input class="form-control" type="text" name="orderMobile" placeholder="010-1234-5678" required>
        주소
        <div class="input-group">
            <input class="form-control" type="text" id="sample6_postcode" name="orderZipCode" placeholder="우편번호"> &nbsp;
            <input class="form-control" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
        </div>
        <input class="form-control" type="text" id="sample6_address" name="orderAddress" placeholder="주소">
        <input class="form-control" type="text" id="sample6_detailAddress" name="orderAddDetail" placeholder="상세주소">
        배송메시지
        <input class="form-control" type="text" name="deliveryMsg">
        주문 금액
        <input class="form-control" type="text" value="총합">
        배송비
        <input class="form-control" type="text" name="deliveryCharge" value="3000" readonly>
        총 주문금액 : (주문금액 value + 배송비)<br>
        <button class="btn btn-outline-primary d-grid mx-auto m-4" onclick="orderOk()">주문하기</button>
    </form>
</div>
</body>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }

    const orderOk = () => {
        let goodsIdArray = [];
        $('input[name="goodsIdList"]').each(function(){
            goodsIdArray.push($(this).val());
        });
        console.log(goodsIdArray[0]);
        console.log(goodsIdArray[1]);
        console.log(goodsIdArray[2]);
        console.log(goodsIdArray[3]);

        // orderForm.submit();
    }
</script>
</html>
