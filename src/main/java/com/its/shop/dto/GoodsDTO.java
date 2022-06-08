package com.its.shop.dto;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class GoodsDTO {
    private Long id;
    private int goodsCategory;
    private String goodsName;
    private String goodsDetail;
    private int goodsPrice;
    private double goodsDiscount;
    private int goodsStock;
    private int goodsSailCount;
    private MultipartFile goodsFile1;
    private String goodsFileName1;
    private MultipartFile goodsFile2;
    private String goodsFileName2;
}
