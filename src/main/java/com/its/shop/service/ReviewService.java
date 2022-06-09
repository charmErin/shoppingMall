package com.its.shop.service;

import com.its.shop.dto.ReviewDTO;
import com.its.shop.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    private ReviewRepository reviewRepository;

    public void save(ReviewDTO reviewDTO) {
        reviewRepository.save(reviewDTO);
    }

    public List<ReviewDTO> findAll(Long goodsId) {
        return reviewRepository.findAll(goodsId);
    }

    public void update(ReviewDTO reviewDTO) {
        reviewRepository.update(reviewDTO);
    }
}
