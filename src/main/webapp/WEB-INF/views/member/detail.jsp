<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 3:38
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
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container col-3">
    <h2>회원상세정보</h2>
    <table class="table">
        <tr>
            <th>아이디</th>
            <td>${member.memberId}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${member.memberName}</td>
        </tr>
        <tr>
            <th>주소</th>
            <td>${member.memberZipCode}<br>
                ${member.memberAddress}<br>
                ${member.memberAddDetail}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${member.memberEmail}</td>
        </tr>
        <tr>
            <th>휴대전화</th>
            <td>${member.memberMobile}</td>
        </tr>
    </table>
    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
    <c:choose>
        <c:when test="${member.memberName eq sessionScope.memberName}">
            <button class="btn btn-outline-primary d-grid" onclick="memberUpdate()">정보수정</button>
            <button class="btn btn-outline-dark" onclick="memberDelete()">회원탈퇴</button>
        </c:when>
        <c:otherwise>
            <button class="btn btn-outline-dark" onclick="memberDelete()">회원삭제</button>
        </c:otherwise>
    </c:choose>
    </div>
</div>
</body>
<script>
    const memberUpdate = () => {
        location.href = "/member/update-form?id=${member.id}";
    }

    const memberDelete = () => {
        if (confirm("탈퇴하시겠습니까?")){
            alert("탈퇴가 완료되었습니다.");
            location.href = "/member/delete?id=${member.id}";
        }
    }
</script>
</html>
