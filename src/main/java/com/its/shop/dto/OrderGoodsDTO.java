package com.its.shop.dto;

import lombok.Data;

@Data
public class OrderGoodsDTO {
    private Long id;
    private Long orderId;
    private Long goodsId;
    private int orderCount;
    private int orderPrice;
}
