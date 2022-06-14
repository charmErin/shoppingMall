package com.its.shop.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class OrderPageDTO {
    private Long id;
    private String memberId;
    private String orderName;
    private String orderAddress;
    private String orderDetail;
    private String orderState;
    private int deliveryCharge = 3000;
    private Timestamp orderDate;
}
