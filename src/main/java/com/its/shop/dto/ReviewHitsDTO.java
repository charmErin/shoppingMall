package com.its.shop.dto;

import lombok.Data;

@Data
public class ReviewHitsDTO {
    private Long id;
    private Long reviewId;
    private String memberId;
    private int reviewHits;
}
