package com.its.shop.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ReviewDTO {
    private Long id;
    private Long goodsId;
    private String memberId;
    private String reviewContents;
    private Timestamp reviewCreatedDate;
    private int reviewHits;
}
