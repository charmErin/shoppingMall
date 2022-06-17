package com.its.shop.dto;

import lombok.Data;

@Data
public class OrderGoodsDTO {
    private Long id;
    private Long memberId;
    private Long orderId;
    private Long goodsId;
    private int cartCount;
    private int orderPrice;

    private OrderPageDTO orderPageDTO;
}
