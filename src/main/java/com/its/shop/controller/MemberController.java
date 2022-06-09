package com.its.shop.controller;

import com.its.shop.dto.MemberDTO;
import com.its.shop.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

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
    public String save(@ModelAttribute MemberDTO memberDTO) {
        memberService.save(memberDTO);
        return "member/login";
    }

    @GetMapping("/login-form")
    public String loginForm() {
        return "member/login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO,
                        HttpSession session){
        MemberDTO member = memberService.login(memberDTO);
        if (member != null) {
            session.setAttribute("memberId", member.getMemberId());
            session.setAttribute("memberName", member.getMemberName());
            return "index";
        } else {
            return "member/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "index";
    }

    @GetMapping("/findAll")
    public String findAll(Model model) {
        List<MemberDTO> memberDTOList = memberService.findAll();
        model.addAttribute("memberList", memberDTOList);
        return "member/list";
    }

    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id, Model model){
        MemberDTO member = memberService.findById(id);
        model.addAttribute("member", member);
        return "member/detail";
    }

    @GetMapping("/update-form")
    public String updateForm(@RequestParam("id") Long id, Model model){
        MemberDTO member = memberService.findById(id);
        model.addAttribute("member", member);
        return "member/update";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute MemberDTO memberDTO, Model model) {
        MemberDTO member = memberService.update(memberDTO);
        model.addAttribute("member", member);
        return "member/detail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id, HttpSession session) {
        memberService.delete(id);
        if (!session.getAttribute("memberName").equals("관리자")){
            session.invalidate();
            return "index";
        } else {
            return "redirect:/member/findAll";
        }
    }
}
