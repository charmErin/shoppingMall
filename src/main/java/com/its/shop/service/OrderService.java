package com.its.shop.service;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.OrderPageDTO;
import com.its.shop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;


    public List<CartDTO> goodsList(List<Long> id) {
        return orderRepository.goodsList(id);
    }

    public void save(OrderPageDTO orderPageDTO) {
        orderRepository.save(orderPageDTO);
    }
}
