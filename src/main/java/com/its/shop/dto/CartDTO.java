package com.its.shop.dto;

import lombok.Data;

@Data
public class CartDTO {
    private Long id;
    private String memberId;
    private Long goodsId;
    private int cartStock;

    private GoodsDTO goodsDTO;
}
