<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오후 3:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
<div class="big-box">
    <div class="join">
        <h2>회원정보수정</h2>
    </div>
    <div>
        <form action="/member/update" method="post" name="updateForm">
            <input type="hidden" name="id" value="${member.id}">
            <table>
                <tr>
                    <th>아이디</th>
                    <td><input type="text" name="memberId" value="${member.memberId}" readonly></td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="memberPassword" id="member-pw"></td>
                </tr>
                <tr>
                    <th>이름(실명)</th>
                    <td><input type="text" name="memberName" maxlength="10" value="${member.memberName}" readonly></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td><input type="text" id="sample6_postcode" name="memberZipCode" value="${member.memberZipCode}">
                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                        <input type="text" id="sample6_address" name="memberAddress" value="${member.memberAddress}"><br>
                        <input type="text" id="sample6_detailAddress" name="memberAddDetail" value="${member.memberAddDetail}"></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><input type="email" name="memberEmail" maxlength="30" value="${member.memberEmail}"></td>
                </tr>
                <tr>
                    <th>휴대전화('-' 미포함)</th>
                    <td><input type="text" maxlength="15" name="memberMobile" value="${member.memberMobile}"></td>
            </table>
            <input type="button" onclick="mUpdate()" class="btn btn-warning btn-lg" style="background-color: rgb(249, 210, 39);" value="수정하기">
        </form>
    </div>
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

    const mUpdate = () => {
        const pwCheck = document.getElementById("member-pw").value;
        const DBpassword = '${member.memberPassword}';
        if (pwCheck == DBpassword) {
            updateForm.submit();
        } else {
            alert("비밀번호가 틀렸습니다.");
        }
    }
</script>
</html>
