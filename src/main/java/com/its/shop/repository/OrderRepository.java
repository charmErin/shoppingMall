package com.its.shop.repository;

import com.its.shop.dto.GoodsDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public List<GoodsDTO> goodsList(List<Long> id) {
        return sql.selectList("Order.findById", id);
    }
}
