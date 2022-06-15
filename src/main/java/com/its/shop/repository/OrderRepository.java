package com.its.shop.repository;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.OrderPageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public List<CartDTO> goodsList(List<Long> id) {
        return sql.selectList("Order.findById", id);
    }

    public void save(OrderPageDTO orderPageDTO) {
        sql.insert("Order.save", orderPageDTO);
    }
}
