package com.its.shop.service;

import com.its.shop.dto.CartDTO;
import com.its.shop.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;


    public void save(CartDTO cartDTO) {
        cartRepository.save(cartDTO);
    }

    public CartDTO findById(CartDTO cartDTO) {
        return cartRepository.findById(cartDTO);
    }

    public void countAdd(CartDTO cartDTO) {
        cartRepository.countAdd(cartDTO);
    }

    public List<CartDTO> findAll(String memberId) {
        return cartRepository.findAll(memberId);
    }


    public void countDown(CartDTO cartDTO) {
        cartRepository.countDown(cartDTO);
    }

    public void delete(CartDTO cartDTO) {
        cartRepository.delete(cartDTO);
    }
}
