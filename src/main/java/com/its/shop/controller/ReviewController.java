package com.its.shop.controller;

import com.its.shop.dto.ReviewDTO;
import com.its.shop.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    @GetMapping("/save-form")
    public String saveForm(@RequestParam Long id, Model model) {
        model.addAttribute("goodsId", id);
        return "goods/review";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute ReviewDTO reviewDTO, Model model) {
        reviewService.save(reviewDTO);
        return "redirect:/goods/detail?id=" + reviewDTO.getGoodsId();
    }

    @PostMapping("/update")
    public String update(@ModelAttribute ReviewDTO reviewDTO) {
        reviewService.update(reviewDTO);
        return "redirect:/goods/detail?id=" + reviewDTO.getGoodsId();
    }

}
