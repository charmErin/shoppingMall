package com.its.shop.repository;

import com.its.shop.dto.GoodsDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class GoodsRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public void save(GoodsDTO goodsDTO) {
        sql.insert("Goods.save", goodsDTO);
    }

    public List<GoodsDTO> findAll() {
        return sql.selectList("Goods.findAll");
    }

    public List<GoodsDTO> list(int goodsCategory) {
        return sql.selectList("Goods.list", goodsCategory);
    }
}