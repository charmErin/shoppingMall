<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 3:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            text-decoration-line: none;
            color: #000;
        }

        a:hover {
            text-decoration-line: underline;
            font-weight: bold;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="container">
    <h2>회원목록</h2>
    <table class="table table-hover">
      <tr>
        <th>회원번호</th>
        <th>아이디</th>
        <th>이메일</th>
        <th>핸드폰번호</th>
      </tr>
      <c:forEach var="member" items="${memberList}">
        <tr>
          <td><a href="/member/detail?id=${member.id}">${member.id}</a></td>
          <td><a href="/member/detail?id=${member.id}">${member.memberId}</a></td>
          <td>${member.memberEmail}</td>
          <td>${member.memberMobile}</td>
        </tr>
      </c:forEach>
    </table>
</div>
</body>
</html>
