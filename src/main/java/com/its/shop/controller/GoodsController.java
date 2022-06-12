package com.its.shop.controller;

import com.its.shop.dto.GoodsDTO;
import com.its.shop.dto.ReviewDTO;
import com.its.shop.dto.ReviewHitsDTO;
import com.its.shop.service.GoodsService;
import com.its.shop.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    private GoodsService goodsService;

    @Autowired
    private ReviewService reviewService;

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

    @GetMapping("/1")
    public String top(Model model) {
        int category = 1;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/top";
    }

    @GetMapping("/2")
    public String bottom(Model model) {
        int category = 2;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/bottom";
    }

    @GetMapping("/3")
    public String shoes(Model model) {
        int category = 3;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/shoes";
    }

    @GetMapping("/4")
    public String acc(Model model) {
        int category = 4;
        List<GoodsDTO> goodsDTOList = goodsService.list(category);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/acc";
    }

    @GetMapping("/detail")
    public String findById(@RequestParam Long id, HttpSession session, Model model) {
        GoodsDTO goodsDTO = goodsService.findById(id);
        model.addAttribute("goods", goodsDTO);
        List<ReviewDTO> reviewDTOList = reviewService.findAll(id);
        model.addAttribute("reviewList", reviewDTOList);
        String memberId = (String) session.getAttribute("memberId");
//        ReviewHitsDTO reviewHitsDTO = reviewService.findById(memberId);
//        model.addAttribute("reviewHits", reviewHitsDTO);
        return "goods/detail";
    }

    @GetMapping("update-form")
    public String updateForm (@RequestParam Long id, Model model) {
        GoodsDTO goodsDTO = goodsService.findById(id);
        model.addAttribute("goods", goodsDTO);
        return "goods/update";
    }

    @PostMapping("update")
    public String update(@ModelAttribute GoodsDTO goodsDTO, Model model) throws IOException {
        goodsService.update(goodsDTO);
        return "redirect:/goods/detail?id=" + goodsDTO.getId();
    }

    @GetMapping("/search")
    public String search (@RequestParam String search, Model model) {
        List<GoodsDTO> goodsDTOList = goodsService.search(search);
        model.addAttribute("goodsList", goodsDTOList);
        return "goods/search";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("category") int category,
                         @RequestParam("id") Long id) {
        goodsService.delete(id);
        return "redirect:/goods/" + category;
    }

}
