package com.its.shop.controller;

import com.its.shop.dto.GoodsDTO;
import com.its.shop.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    private GoodsService goodsService;

    @GetMapping("/save-form")
    public String saveForm() {
        return "goods/save";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute GoodsDTO goodsDTO) throws IOException {
        System.out.println("goodsDTO = " + goodsDTO);
        goodsService.save(goodsDTO);
        return "index";
    }

    @GetMapping("/top")
    public String top(Model model) {
        int category = 1;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/list";
    }

    @GetMapping("/bottom")
    public String bottom(Model model) {
        int category = 2;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/list";
    }

    @GetMapping("/shoes")
    public String shoes(Model model) {
        int category = 3;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/list";
    }

    @GetMapping("/acc")
    public String acc(Model model) {
        int category = 4;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/list";
    }
}
