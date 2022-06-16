<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2022-06-08
  Time: 오전 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%--    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">--%>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/resources/js/jquery.js"></script>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<%--    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>--%>
    <title>CHICK</title>
    <style>
        h2 {
            text-align: center;
            margin-bottom: 50px;
        }

        #icon0 {
            margin-top: 5px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" flush="false"></jsp:include>
    <div class="container col-3">
            <h2>회원가입</h2>

        <form action="/member/save" method="post" name="saveForm">
            아이디<br>
            <input class="form-control" type="text" name="memberId" id="user-id" onblur="idCheck()" autofocus>
            <!-- 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능 -->
            <p id="id-check"></p>

            비밀번호
            <div class="input-group">
                <input class="form-control" type="password" name="memberPassword" id="user-pw" onblur="pwCheck()">&nbsp;&nbsp;
                <!-- 5~16자 영문 대 소문자, 숫자, 특수문자( ),(-),(_),(!),(#),($)를 사용 가능 -->
                <i onclick="eyeIcon()" id="icon0" class="eyeIcon bi bi-eye-fill fs-3"></i>
            </div>
            <p id="pw-check"></p>

            이름(실명)
            <input class="form-control" type="text" name="memberName" maxlength="10" required>
            <p></p>

            주소
            <div class="input-group">
                <input class="form-control" type="text" id="sample6_postcode" name="memberZipCode" placeholder="우편번호">
                <input class="form-control" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
            </div>
            <input class="form-control" type="text" id="sample6_address" name="memberAddress" placeholder="주소">
            <input class="form-control" type="text" id="sample6_detailAddress" name="memberAddDetail" placeholder="상세주소">
            <p></p>

            본인 확인 이메일(선택)
            <input class="form-control" type="email" name="memberEmail" maxlength="30">
            <p></p>

            휴대전화('-' 포함)
            <div class="input-group">
                <input class="form-control" type="text" id="userMobile" maxlength="15" name="memberMobile" onblur="mobileCheck()" placeholder="010-1234-5678" required>
                <button type="button" class="btn btn-outline-warning" onclick="mobileCertify()">&nbsp;인증번호받기&nbsp;</button>
            </div>
            <p id="certify-number"></p>
            <p id="mobile-check"></p>


            <input type="button" onclick="mSave()" class="btn btn-warning btn-lg d-grid mx-auto" value="회원가입">
        </form>
    </div>

</div>
</div>

</body>
<script>
    function idCheck() {
        const memberId = document.getElementById("user-id").value;
        const exp = /^(?=.*[a-z])[a-z\d-_]{5,20}$/
        const idCheck = document.getElementById("id-check");

        if(memberId.match(exp)){
            idCheck.innerHTML = "사용가능한 아이디입니다.";
            idCheck.style.color = "green";
        } else {
            idCheck.innerHTML = "5~20자의 영문소문자<b>(필수)</b>,<br>"
            idCheck.innerHTML += "숫자, 특수문자(-),(_)만 사용 가능합니다.";
            idCheck.style.color = "red";
        }

        $.ajax({
            type: "post",
            url: "/member/duplicate-check",
            data: {"memberId": memberId},
            dataType: "text",
            success: function (result){
                if(result == "no") {
                    idCheck.innerHTML = "이미 사용중인 아이디입니다.";
                    idCheck.style.color = "red";
                }
            }
        });
    }

    function pwCheck() {
        const pw = document.getElementById("user-pw").value;
        const exp = /^(?=.*[a-z])[a-z\d -_!#$]{5,16}$/
        const pwCheck = document.getElementById("pw-check")

        if(!pw.match(exp)){
            pwCheck.innerHTML = "8~16자의 영문소문자<b>(필수)</b>,<br>"
            pwCheck.innerHTML += " 숫자, 공백( ), 특수문자(-),(_),(!),(#),($)만 사용 가능합니다.";
            pwCheck.style.color = "red";
        } else {
            pwCheck.innerHTML = "";
        }
    }

    function eyeIcon() {
        const pw = document.getElementById("user-pw");
        const icon = document.getElementById("icon0");

        if(pw.type === "password"){
            pw.type = "text";
            icon.className="bi bi-eye-slash fs-3";
        } else {
            pw.type = "password";
            icon.className="bi bi-eye-fill fs-3";
        }
    }

    function mobileCheck() {
        const userMobile = document.getElementById("userMobile").value;
        const exp = /^\d{3}-\d{4}-\d{4}$/
        const mobileCheck = document.getElementById("mobile-check");

        if(userMobile.match(exp)) {
            // mobileCheck.innerHTML = "<b>인증번호받기</b> 를 눌러주세요.";
        } else {
            mobileCheck.innerHTML = "전화번호 확인 바랍니다.";
        }
        // } else {
        //     mobileCheck.innerHTML = "<b>전화번호</b> 확인 후 다시 입력해주세요.";
        //     mobileCheck.style.color = "red";
        // }
    }

    function mobileCertify() {

    }

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

    function mSave() {
        saveForm.submit();
    }
</script>
</html>
