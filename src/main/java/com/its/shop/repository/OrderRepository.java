package com.its.shop.repository;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.OrderGoodsDTO;
import com.its.shop.dto.OrderPageDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    public List<OrderPageDTO> findAll(String memberId) {
        return sql.selectList("Order.findAll", memberId);
    }


    public void sailUpdate(Map<String, Long> goodsIdCartStock) {
        sql.update("Goods.sailUpdate", goodsIdCartStock);
    }

    public void orderGoodsSave(Map<String, Long> goodsIdCartStock) {
        sql.insert("Order.orderGoods", goodsIdCartStock);
    }

}
