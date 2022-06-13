package com.its.shop.repository;

import com.its.shop.dto.ReviewDTO;
import com.its.shop.dto.ReviewHitsDTO;
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

    public void hitsUp(ReviewHitsDTO reviewHitsDTO) {
        sql.insert("Review.hitsUp", reviewHitsDTO);
        sql.update("Review.hitsCountUpdate", reviewHitsDTO);
    }

    public void hitsDown(ReviewHitsDTO reviewHitsDTO) {
        sql.update("Review.hitsDown", reviewHitsDTO);
        sql.update("Review.hitsCountUpdate", reviewHitsDTO);
    }

    public ReviewHitsDTO findById(ReviewHitsDTO reviewHitsDTO) {
        return sql.selectOne("Review.findById", reviewHitsDTO);
    }

    public void hitsUpdate(ReviewHitsDTO reviewHitsDTO) {
        sql.update("Review.hitsUpdate", reviewHitsDTO);
        sql.update("Review.hitsCountUpdate", reviewHitsDTO);
    }

}
