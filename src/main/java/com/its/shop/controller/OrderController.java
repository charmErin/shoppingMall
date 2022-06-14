package com.its.shop.controller;

import com.its.shop.dto.GoodsDTO;
import com.its.shop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Array;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping("/saveForm")
    public @ResponseBody List<GoodsDTO> saveForm(@RequestParam(value="goodsIdArray[]") List<Long> goodsIdArray, Model model) {
        List<GoodsDTO> goodsDTOList = orderService.goodsList(goodsIdArray);
        model.addAttribute("goodsList", goodsDTOList);
        System.out.println(goodsDTOList);
        return goodsDTOList;
    }

//    @PostMapping("/save")
//    public String save() {
//
//        return ;
//    }

}
