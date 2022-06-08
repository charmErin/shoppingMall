package com.its.shop.controller;

import com.its.shop.dto.MemberDTO;
import com.its.shop.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("/save-form")
    public String saveForm() {
        return "member/save";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO,
                       HttpSession session) {
        memberService.save(memberDTO);
        session.setAttribute("id", memberDTO.getId());
        session.setAttribute("memberName", memberDTO.getMemberName());
        return "index";
    }

}
