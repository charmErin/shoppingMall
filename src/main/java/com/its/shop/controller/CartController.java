package com.its.shop.controller;

import com.its.shop.dto.CartDTO;
import com.its.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("/save")
    public String save(@RequestParam Long goodsId,
                       HttpSession session) {
        String memberId = (String) session.getAttribute("memberId");
        CartDTO cartDTO = new CartDTO();
        cartDTO.setMemberId(memberId);
        cartDTO.setGoodsId(goodsId);
        CartDTO cartIn = cartService.findById(cartDTO);
        if (cartIn == null) {
            cartService.save(cartDTO);
        } else {
            cartService.countAdd(cartDTO);
        }
        return "redirect:/goods/detail?id=" + goodsId;
    }

    @GetMapping("/findAll")
    public String findAll (HttpSession session, Model model) {
        String memberId = (String) session.getAttribute("memberId");
        List<CartDTO> cartDTOList = cartService.findAll(memberId);
        model.addAttribute("cartList", cartDTOList);
        System.out.println("cartDTOList:" + cartDTOList);
        return "cart/list";
    }

}
