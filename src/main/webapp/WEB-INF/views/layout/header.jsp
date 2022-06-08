<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-07
  Time: 오후 12:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link rel="stylesheet" href="../../../resources/css/header.css"/>
    <title>Title</title>
</head>
<body>
<header>
    <div class="intro_bg">
        <div class="header">
            <div class="search_area">
                <form action="" method="get">
                    <img src="../../../resources/img/search_icon.png">
                    <input type="search" name="search" placeholder="검색">
                </form>
            </div>

            <ul class="nav">
                <li><a href="/">HOME</a></li>
                <li><a href="#">MEN</a></li>
                <li><a href="#">WOMEN</a></li>
                <li><a href="#">SALE</a></li>
            </ul>

            <c:choose>
                <c:when test="${sessionScope.memberName ne null}">
                    <ul class="btn">
                        <li>${sessionScope.memberName}</li>
                        <li onclick="memberDetail()">마이페이지</li>
                        <li onclick="memberLogout()">로그아웃</li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <ul class="btn">
                        <li></li>
                        <li onclick="loginForm()">로그인</li>
                        <li onclick="memberSave()">회원가입</li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>
</body>
<script>
    const loginForm = () => {
        location.href = "/member/login-form";
    }

    const memberSave = () => {
        location.href = "/member/save-form";
    }

    const memberDetail = () => {
        location.href = "/member/detail?id=${sessionScope.memberId}";
    }

    const memberLogout = () => {
        location.href = "/member/logout";
    }
</script>
</html>
