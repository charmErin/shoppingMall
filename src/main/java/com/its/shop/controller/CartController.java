package com.its.shop.controller;

import com.its.shop.dto.CartDTO;
import com.its.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        return "cart/list";
    }

    @GetMapping("/count-up")
    public @ResponseBody List<CartDTO> countUp (@ModelAttribute CartDTO cartDTO) {
        cartService.countAdd(cartDTO);
        List<CartDTO> cartDTOList = cartService.findAll(cartDTO.getMemberId());
        return cartDTOList;
    }

    @GetMapping("/count-down")
    public @ResponseBody List<CartDTO> countDown (@ModelAttribute CartDTO cartDTO) {
        cartService.countDown(cartDTO);
        List<CartDTO> cartDTOList = cartService.findAll(cartDTO.getMemberId());
        return cartDTOList;
    }

    @GetMapping("/delete")
    public String delete (@ModelAttribute CartDTO cartDTO, HttpSession session, Model model) {
        String memberId = (String) session.getAttribute("memberId");
        cartDTO.setMemberId(memberId);
        cartService.delete(cartDTO);
        List<CartDTO> cartDTOList = cartService.findAll(memberId);
        model.addAttribute("cartList", cartDTOList);
        return "cart/list";
    }
}
