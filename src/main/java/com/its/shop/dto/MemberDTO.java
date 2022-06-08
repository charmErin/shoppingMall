package com.its.shop.dto;

import lombok.Data;

@Data
public class MemberDTO {
    private Long id;
    private String memberId;
    private String memberPassword;
    private String memberName;
    private String memberZipCode;
    private String memberAddress;
    private String memberAddDetail;
    private String memberEmail;
    private String memberMobile;
}
