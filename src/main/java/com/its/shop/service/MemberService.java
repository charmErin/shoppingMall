package com.its.shop.service;

import com.its.shop.dto.MemberDTO;
import com.its.shop.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService {

    @Autowired
    private MemberRepository memberRepository;

    public void save(MemberDTO memberDTO) {
        memberRepository.save(memberDTO);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return memberRepository.login(memberDTO);
    }

    public List<MemberDTO> findAll() {
        return memberRepository.findAll();
    }

    public MemberDTO findById(Long id) {
        return memberRepository.findById(id);
    }

    public MemberDTO update(MemberDTO memberDTO) {
        memberRepository.update(memberDTO);
        return memberRepository.findById(memberDTO.getId());
    }

    public void delete(Long id) {
        memberRepository.delete(id);
    }
}
