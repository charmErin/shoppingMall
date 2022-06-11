package com.its.shop.controller;

import com.its.shop.dto.ReviewDTO;
import com.its.shop.dto.ReviewHitsDTO;
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

    @GetMapping("/delete")
    public String delete(@RequestParam Long goodsId,
                         @RequestParam Long id) {
        reviewService.delete(id);
        return "redirect:/goods/detail?id=" + goodsId;
    }

    @GetMapping("/hitsUp")
    public @ResponseBody List<ReviewDTO> hitsUp(@ModelAttribute ReviewHitsDTO reviewHitsDTO, Model model) {
        ReviewHitsDTO hitsCondition = reviewService.findById(reviewHitsDTO);
        model.addAttribute("reviewHits", hitsCondition);
        if (hitsCondition.getReviewHits() != 0) {
            reviewService.hitsUp(reviewHitsDTO);
        } else {
            reviewService.hitsUpdate(reviewHitsDTO);
        }
        return reviewService.findAll(reviewHitsDTO.getReviewId());
    }

    @GetMapping("/hitsDown")
    public @ResponseBody List<ReviewDTO> hitsDown(@ModelAttribute ReviewHitsDTO reviewHitsDTO, Model model) {
        reviewService.hitsDown(reviewHitsDTO);
        ReviewHitsDTO hitsCondition = reviewService.findById(reviewHitsDTO);
        model.addAttribute("reviewHits", hitsCondition);
        return reviewService.findAll(reviewHitsDTO.getReviewId());

    }

}
