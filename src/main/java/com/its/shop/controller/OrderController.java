package com.its.shop.controller;

import com.its.shop.dto.CartDTO;
import com.its.shop.dto.OrderGoodsDTO;
import com.its.shop.dto.OrderPageDTO;
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

    List<CartDTO> cartDTOList = null;

    @GetMapping("/save-form")
    public @ResponseBody String saveForm(@RequestParam(value="goodsIdArray[]") List<Long> goodsIdArray, Model model) {
        cartDTOList = orderService.goodsList(goodsIdArray);
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
        String memberId = (String)session.getAttribute("memberId");
        List<OrderPageDTO> orderPageDTOList = orderService.findAll(memberId);
        model.addAttribute("orderList", orderPageDTOList);
        return "order/list";
    }

    @GetMapping("/findAll")
    public String findAll(HttpSession session, Model model) {
        String memberId = (String)session.getAttribute("memberId");
        List<OrderPageDTO> orderPageDTOList = orderService.findAll(memberId);
        model.addAttribute("orderList", orderPageDTOList);
        return "order/list";
    }

}
