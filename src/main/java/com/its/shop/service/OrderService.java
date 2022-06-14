package com.its.shop.service;

import com.its.shop.dto.GoodsDTO;
import com.its.shop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;


    public List<GoodsDTO> goodsList(List<Long> id) {
        return orderRepository.goodsList(id);
    }
}
