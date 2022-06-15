package com.its.shop.controller;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.OrderPageDTO;
import com.its.shop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    List<CartDTO> cartDTOList = null;

    @GetMapping("/save-form")
    public @ResponseBody String saveForm(@RequestParam(value="goodsIdArray[]") List<Long> goodsIdArray, Model model) {
        cartDTOList = orderService.goodsList(goodsIdArray);
        model.addAttribute("goodsList", cartDTOList);
        System.out.println(cartDTOList);
        return "ok";
    }

    @GetMapping("/save")
    public String save(Model model) {
        model.addAttribute("cartList", cartDTOList);
        return "order/save";
    }

//    @GetMapping("/save-goods-id")
//    public String saveGoodsId() {
//
//    }

    @PostMapping("/save")
    public String save(@ModelAttribute OrderPageDTO orderPageDTO,
                       Model model) {
        orderService.save(orderPageDTO);
        return null;
    }

}
