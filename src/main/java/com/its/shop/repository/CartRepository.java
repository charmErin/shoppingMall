package com.its.shop.repository;

import com.its.shop.dto.CartDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CartRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public void save(CartDTO cartDTO) {
        sql.insert("Cart.save", cartDTO);
    }

    public CartDTO findById(CartDTO cartDTO) {
        return sql.selectOne("Cart.findById", cartDTO);
    }

    public void countAdd(CartDTO cartDTO) {
        sql.update("Cart.countAdd", cartDTO);
    }

    public List<CartDTO> findAll(String memberId) {
        return sql.selectList("Cart.findAll", memberId);
    }

    public void countDown(CartDTO cartDTO) {
        sql.update("Cart.countDown", cartDTO);
    }

    public void delete(CartDTO cartDTO) {
        sql.delete("Cart.delete", cartDTO);
    }
}
