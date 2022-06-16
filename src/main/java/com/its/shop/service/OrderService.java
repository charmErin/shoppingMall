package com.its.shop.service;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.OrderGoodsDTO;
import com.its.shop.dto.OrderPageDTO;
import com.its.shop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public List<OrderPageDTO> findAll(String memberId) {
        return orderRepository.findAll(memberId);
    }

    public void sailUpdate(List<CartDTO> cartDTOList, Long orderId , Long memberId) {
        Map<String, Long> goodsIdCartStock = new HashMap<>();
        // 상품 판매수량 증가, 재고수량 감소, 주문상품 테이블 insert
        for (int i=0; i<cartDTOList.size(); i++) {
            goodsIdCartStock.put("memberId", memberId);
            goodsIdCartStock.put("orderId", orderId);
            goodsIdCartStock.put("goodsId", cartDTOList.get(i).getGoodsId());
            goodsIdCartStock.put("cartStock", (long) cartDTOList.get(i).getCartStock());
            goodsIdCartStock.put("orderPrice", (long) cartDTOList.get(i).getGoodsDTO().getGoodsPrice() * cartDTOList.get(i).getCartStock());
            orderRepository.sailUpdate(goodsIdCartStock);
            orderRepository.orderGoodsSave(goodsIdCartStock);
        }

    }
}
