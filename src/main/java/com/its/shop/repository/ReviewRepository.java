package com.its.shop.repository;

import com.its.shop.dto.ReviewDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReviewRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public void save(ReviewDTO reviewDTO) {
        sql.insert("Review.save", reviewDTO);
    }

    public List<ReviewDTO> findAll(Long goodsId) {
        return sql.selectList("Review.findAll", goodsId);
    }

    public void update(ReviewDTO reviewDTO) {
        sql.update("Review.update", reviewDTO);
    }

    public void delete(Long id) {
        sql.delete("Review.delete", id);
    }
}
