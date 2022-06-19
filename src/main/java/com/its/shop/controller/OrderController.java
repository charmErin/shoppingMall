package com.its.shop.controller;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.GoodsDTO;
import com.its.shop.dto.OrderGoodsDTO;
import com.its.shop.dto.OrderPageDTO;
import com.its.shop.service.CartService;
import com.its.shop.service.GoodsService;
import com.its.shop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CartService cartService;

    List<CartDTO> cartDTOList = null;
    List<Long> goodsIdList = null;
    @GetMapping("/save-form")
    public @ResponseBody String saveForm(@RequestParam(value="goodsIdArray[]") List<Long> goodsIdArray, Model model) {
        goodsIdList = goodsIdArray;
        cartDTOList = orderService.goodsList(goodsIdList);
        return "ok";
    }

    @GetMapping("/save")
    public String save(Model model) {
        model.addAttribute("cartList", cartDTOList);
        return "order/save";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute OrderPageDTO orderPageDTO,
                       Model model, HttpSession session) {
        orderService.save(orderPageDTO);
        Long id = (Long) session.getAttribute("id");
        orderService.sailUpdate(cartDTOList, orderPageDTO.getId(), id);
        Long memberId = (Long)session.getAttribute("id");
        List<OrderGoodsDTO> orderGoodsDTOList = orderService.findAll(memberId);
        model.addAttribute("orderList", orderGoodsDTOList);
        String memberEngId = (String) session.getAttribute("memberId");
        return "order/list";
    }

    @GetMapping("/findAll")
    public String findAll(HttpSession session, Model model) {
        Long memberId = (Long)session.getAttribute("id");
        List<OrderGoodsDTO> orderGoodsDTOList = orderService.findAll(memberId);
        model.addAttribute("orderList", orderGoodsDTOList);
        return "order/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id,
                         @RequestParam Long goodsId, Model model) {
        OrderPageDTO orderPageDTO = orderService.findOrder(id);
        GoodsDTO goodsDTO = goodsService.findById(goodsId);
        OrderGoodsDTO orderGoodsDTO = orderService.findGoods(orderPageDTO.getId(), goodsDTO.getId());
        model.addAttribute("order", orderPageDTO);
        model.addAttribute("cart", orderGoodsDTO);
        model.addAttribute("goods", goodsDTO);
        return "order/detail";
    }

}
